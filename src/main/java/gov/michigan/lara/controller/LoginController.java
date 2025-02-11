package gov.michigan.lara.controller;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gov.michigan.lara.dao.PasswordResetTokenRepository;
import gov.michigan.lara.domain.PasswordResetToken;
import gov.michigan.lara.domain.User;
import gov.michigan.lara.security.CustomUserDetails;
import gov.michigan.lara.security.UserDetailsUtil;
import gov.michigan.lara.service.PasswordResetService;
import gov.michigan.lara.service.UserService;
import gov.michigan.lara.util.EmailService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

@Controller
@RequestMapping("/auth")
public class LoginController {

    @Autowired
    private UserService userService;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private UserDetailsService customUserDetailsService;
    @Autowired
    private PasswordResetService passwordResetService;
    @Autowired
    private EmailService emailService;
    @Autowired
    private PasswordResetTokenRepository tokenRepository;


    @GetMapping("/login")
    public String showLoginPage(HttpServletRequest request, @RequestParam(value = "error", required = false) String error, @RequestParam(value = "id", required = false) Long id, Model model) {

        if (error == null) {
            model.addAttribute("title", "Login");
        } else if (error.equals("passwordExpired")) {
            Long userId = (Long) request.getSession().getAttribute("expiredUserId");
            model.addAttribute("title", "Your password has expired and must be changed");
            model.addAttribute("id", userId);
        } else {
            System.err.println("invalid username/password");
            model.addAttribute("errorMsg", "invalid username/password");
            model.addAttribute("title", "Login");
        }

        model.addAttribute("error", error);
        return "login";
    }

    @GetMapping("/changePassword")
    public String changePassword(HttpServletRequest request, Model model) {
        model.addAttribute("title", "Change Password");
        model.addAttribute("id", UserDetailsUtil.getCurrentUserId());
        return "login";
    }


    @GetMapping("/forgotPassword")
    public String forgotPassword(HttpServletRequest request, Model model) {
        model.addAttribute("title", "Forgot Password");
        return "login";
    }

    @PostMapping("/forgotPassword")
    public String forgotPasswordSend(@RequestParam String email, HttpServletRequest request) {
        // Validate the email address
        Optional<User> optionalUser = userService.findUserByEmail(email);
        if (!optionalUser.isPresent()) {
            throw new IllegalArgumentException("User not found for the provided email");
        }
        User pwuser = optionalUser.get();
    
        if (pwuser != null) {
            PasswordResetToken token = passwordResetService.createPasswordResetToken(email);
    
            String serverUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
            String resetUrl = serverUrl + "/auth/resetPassword?token=" + token.getToken();
            emailService.sendForgotPasswordEmail(email, resetUrl, pwuser.getDisplayName());
            return "yay";
        }
        return "boo";
    }

    
    @GetMapping("/resetPassword")
    public String showResetPasswordPage(HttpServletRequest request, @RequestParam("token") String token, Model model) {
        // Validate the token and check its expiration
        Optional<PasswordResetToken> optionalResetToken = tokenRepository.findByToken(token);
        if (!optionalResetToken.isPresent()) {
            throw new IllegalArgumentException("Invalid or expired reset token");
        }
        PasswordResetToken resetToken = optionalResetToken.get();
    
        // Add the token to the model so it can be used in the JSP page
        model.addAttribute("token", token);
        model.addAttribute("title", "Please set a new password");
    
        // Find user by email in token
        Optional<User> user = userService.findUserByEmail(resetToken.getEmail());
        if (!user.isPresent()) {
            throw new IllegalArgumentException("User not found for the provided token");
        }
        User rpUser = user.get();
    
        Long userId = rpUser.getId();
        System.out.println("resetting pw for user id " + userId);
        model.addAttribute("id", userId);
    
        // Return the login view
        return "login";
    }
    
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            LogoutHandler logoutHandler = new SecurityContextLogoutHandler();
            logoutHandler.logout(request, response, auth);
        }
        return "redirect:/auth/login";
    }
    
    @GetMapping("/access-denied")
    public String showAccessDeniedPage(Model model) {
        model.addAttribute("title", "Access Denied");
        return "access-denied"; // This refers to the access-denied.jsp view
    }

    @Transactional
    @PostMapping("/changePassword")
    // public String changePassword(@RequestParam("userId") Long userId, @RequestParam("newPassword") String newPassword, Model model){
    public String changePassword(@RequestParam("userId") Long userId, @RequestParam("newPassword") String newPassword, HttpServletRequest request, HttpServletResponse response, Model model, @RequestParam(value = "token", required = false) String token) {
        User user = userService.findUserById(userId);
        user.setPassword(passwordEncoder.encode(newPassword));
        user.setPasswordExpired(false);
        userService.updateUser(user, userId);

        // Load the updated user details
        CustomUserDetails userDetails = (CustomUserDetails) customUserDetailsService.loadUserByUsername(user.getUsername());

        // Re-authenticate the user with the new password
        Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, newPassword, userDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(authentication);

        // Manually update the session to avoid any invalidation issues
        request.getSession().setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());

        // If token is present, delete it
        if (token != null && !token.isEmpty()) {
            tokenRepository.deleteByToken(token);
        } else {
            System.out.println("no token found");
        }
        
        request.getSession().setAttribute("successMessage", "Your password has been changed!");

        return "redirect:/";
    }

    @PostMapping("/reset")
    public ResponseEntity<Void> clearSuccessMessage(HttpServletRequest request) {
        request.getSession().removeAttribute("successMessage");
        request.getSession().removeAttribute("expiredUserId");
        return ResponseEntity.ok().build();
    }

}
