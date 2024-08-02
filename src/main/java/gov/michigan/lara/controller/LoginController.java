package gov.michigan.lara.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/auth")
public class LoginController {

    @GetMapping("/login")
    public String showLoginPage(@RequestParam(value = "logout", required = false) String logout, Model model) {
        System.out.println("### showLoginPage");
        model.addAttribute("title", "Login");
        if (logout != null) {
            System.out.println("@@ logging out");
            model.addAttribute("message", "You have been logged out successfully.");
        }
        return "login";
    }

    @GetMapping("/access-denied")
    public String showAccessDeniedPage(Model model) {
        model.addAttribute("title", "Access Denied");
        return "access-denied"; // This refers to the access-denied.jsp view
    }

}
