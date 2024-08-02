package gov.michigan.lara.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import java.io.File;

import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {

    private static Logger log=LogManager.getLogger();

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromAddress;

    public void sendSimpleEmail(String to, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setFrom(fromAddress);
        message.setSubject(subject);
        message.setText(text);
        mailSender.send(message);
        log.info(message);
    }

    public void sendHtmlEmail(String to, String subject, String username, String displayName, String password, String appUrl) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setFrom(fromAddress);
            helper.setSubject(subject);
    
            String htmlContent = "<!DOCTYPE html>" +
                "<html lang='en'>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
                "<title>Welcome to WORKHORSE</title>" +
                "<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css'>" +
                "</head>" +
                "<body style='font-family: Arial, sans-serif; background-color: #f8f9fa;'>" +
                "<div style='max-width: 600px; margin: auto; padding: 20px; background-color: #f8f9fa; border-radius: 5px;'>" +
                "<div style='text-align: center;'>" +
                "<h2 style='color: #343a40;'>Welcome to WORKHORSE</h2>" +
                "<p style='color: #6c757d;'>The Web-based Organization and Reporting Kit for High-level Operations and Reliable Systematic Extraction (that's WORKHORSE for short) is here to power up your data entry for the dashboards project!</p>" +
                "</div>" +
                "<div style='color: #6c757d; margin-bottom: 20px;'>" +
                "<p>Dear <strong>" + displayName + "</strong>,</p>" +
                "<p>We're thrilled to have you join our team. Here's a quick rundown of your login details:</p>" +
                "<ul style='list-style: none; padding: 0;'>" +
                "<li><strong>Username:</strong> " + username + "</li>" +
                "<li><strong>Password:</strong> " + password + "</li>" +
                "</ul>" +
                "<p>You can access WORKHORSE using the following link:</p>" +
                "<p><a href='" + appUrl + "'>Go to WORKHORSE</a></p>" +
                "<p>Don't forget to change your password on your first login, because we all love good security policy!<br><small>(password change functionality not yet available)</small></p>" +
                "<p>If you need any help or have questions, just hit up our support team. They're awesome and here for you.</p>" +
                "</div>" +
                "<div style='text-align: center; margin-top: 20px;'>" +
                "<img src='cid:logoImage' alt='WORKHORSE Logo' style='width: 150px;'>" +
                "</div>" +
                "<div style='text-align: center; margin-top: 20px; color: #6c757d;'>" +
                "<p>Warmest regards,<br>the DTMB team</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";

            helper.setText(htmlContent, true);
            helper.addInline("logoImage", new File("src/main/resources/static/img/small-light2.png"));
            mailSender.send(message);
            log.info("Email sent to {}", to);
        } catch (Exception e) {
            log.error("Failed to send email", e);
        }
    }
}
