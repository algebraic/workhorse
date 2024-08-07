package gov.michigan.lara.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
import gov.michigan.lara.domain.User;
import gov.michigan.lara.security.CustomUserDetails;
import gov.michigan.lara.security.UserDetailsUtil;
import gov.michigan.lara.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/auth")
public class LoginController {

    @Autowired
    private UserService userService;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private UserDetailsService customUserDetailsService;

    @GetMapping("/login")
    public String showLoginPage(HttpServletRequest request, @RequestParam(value = "error", required = false) String error, @RequestParam(value = "id", required = false) Long id, Model model) {

        System.out.println("@@@ showLoginPage: " + error);
        System.out.println("UserDetailsUtil.getCurrentUserId() = " + UserDetailsUtil.getCurrentUserId());
        if (error == null) {
            model.addAttribute("title", "Login");
        } else {
            model.addAttribute("title", "Your password has expired and must be changed");
            Long userId = (Long) request.getSession().getAttribute("passwordExpiredUserId");
            model.addAttribute("id", userId);
        }
        model.addAttribute("error", error);
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

    @PostMapping("/changePassword")
    // public String changePassword(@RequestParam("userId") Long userId, @RequestParam("newPassword") String newPassword, Model model){
    public String changePassword(@RequestParam("userId") Long userId, @RequestParam("newPassword") String newPassword, HttpServletRequest request, HttpServletResponse response, Model model) {

        System.out.println("userId: " + userId);
        System.out.println("newPassword: " + newPassword);
        
        User user = userService.findUserById(userId);
        user.setPassword(passwordEncoder.encode(newPassword));
        user.setPasswordExpired(false);
        userService.updateUser(user, userId);

        // Load the updated user details
        CustomUserDetails userDetails = (CustomUserDetails) customUserDetailsService.loadUserByUsername(user.getUsername());
        System.out.println("###\n" + userDetails.toString());

        // Re-authenticate the user with the new password
        Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, newPassword, userDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(authentication);

        // Manually update the session to avoid any invalidation issues
        request.getSession().setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());

        // Check if the user is correctly authenticated
        Authentication newAuth = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("### ## newAuth.isAuthenticated() = " + newAuth.isAuthenticated());

        String username = UserDetailsUtil.getCurrentUsername();
        String userbureau = UserDetailsUtil.getCurrentUserBureau();
        String displayname = UserDetailsUtil.getCurrentUserDisplayName();
        
        System.out.println("### ## username = " + username);
        System.out.println("### ## userbureau = " + userbureau);
        System.out.println("### ## displayname = " + displayname);

        System.out.println("### password changed, go to index");
        return "redirect:/";
    }

}
