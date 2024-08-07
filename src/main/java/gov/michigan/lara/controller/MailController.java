package gov.michigan.lara.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import gov.michigan.lara.security.UserDetailsUtil;
import gov.michigan.lara.util.EmailService;
import gov.michigan.lara.util.PasswordGenerator;

@RestController
public class MailController {

    @Autowired
    private EmailService emailService;

    @GetMapping("/test-email")
    public String testEmail(@RequestParam String to) {
        String randomPassword = PasswordGenerator.generateRandomPassword();
        String username = UserDetailsUtil.getCurrentUsername();
        // String email = "johnsonz2@michigan.gov";

        emailService.sendHtmlEmail(
            to,
            "WORKHORSE: new user created",
            username,
            UserDetailsUtil.getCurrentUserDisplayName(),
            randomPassword,
            "http://127.0.0.1:8080/workhorse/"
        );
        
        return "Email sent! :)";
    }
}
