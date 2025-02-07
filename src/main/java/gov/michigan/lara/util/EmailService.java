package gov.michigan.lara.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import java.io.File;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;

@Service
public class EmailService {

    private static Logger log=LogManager.getLogger();

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromAddress;

    private String fromName = "WORKHORSE Support";

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
            helper.setFrom(fromAddress, fromName);
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
                "<p style='color: #6c757d;'>The Web-based Organization and Reporting Kit for High-level Operations and Reliable Systematic Extraction (that's WORKHORSE for short) is here to power up your data entry for the LARAStat Dashboard!</p>" +
                "</div>" +
                "<div style='color: #6c757d; margin-bottom: 20px;'>" +
                "<p>Dear <strong>" + displayName + "</strong>,</p>" +
                "<p>We're thrilled to have you join our team! Here's a quick rundown of your login details:</p>" +
                "<ul style='list-style: none; padding: 0;'>" +
                "<li>Username: <strong>" + username + "</strong></li>" +
                "<li>Password: <strong>" + password + "</strong></li>" +
                "</ul>" +
                "<p>You'll be prompted to change your password on your first login, so you can set it to something secure.</p>" +
                "<p>You can access WORKHORSE using the following link:</p>" +
                "<p><a href='" + appUrl + "'>Go to WORKHORSE</a></p>" +
                "<p>For instructions on how to use WORKHORSE, click <a href='\" + appUrl + \"'>here</a>.</p>" +
                "<p>If you need any help or have questions, please email <a href='mailto:LARA-BSS @michigan.gov'>LARA/FAS Support</a> for assistance.</p>" +
                "</div>" +
                "<div style='text-align: center; margin-top: 50px;'>" +
                "<img src='cid:logoImage' alt='WORKHORSE Logo' style='width: 150px;'>" +
                "</div>" +
                "<div style='text-align: center; margin-top: 20px; color: #6c757d;'>" +
                "<p>Warmest regards,<br>the DTMB team</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";

            helper.setText(htmlContent, true);
            File logoImage = ResourceUtils.getFile("classpath:static/img/small-light2.png");
            helper.addInline("logoImage", logoImage);

            mailSender.send(message);
            log.info("Email sent to {}", to);
        } catch (Exception e) {
            log.error("Failed to send email", e);
        }
    }

    public void sendPWEmail(String to, String subject, String username, String displayName, String password, String appUrl) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setFrom(fromAddress, fromName);
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
                "<h2 style='color: #343a40;'>Your Password Has Been Reset</h2>" +
                "</div>" +
                "<div style='color: #6c757d; margin-bottom: 20px;'>" +
                "<p>Dear <strong>" + displayName + "</strong>,</p>" +
                "<p>Your password has been reset. Please use the following new password to log in:</p>" +
                "<ul style='list-style: none; padding: 0;'>" +
                "<li>Username: <strong>" + username + "</strong></li>" +
                "<li>Password: <strong>" + password + "</strong></li>" +
                "</ul>" +
                "<p>You can access WORKHORSE using the following link:</p>" +
                "<p><a href='" + appUrl + "'>Go to WORKHORSE</a></p>" +
                "<p>If you have any questions or need further assistance, please contact our support team.</p>" +
                "</div>" +
                "<div style='text-align: center; margin-top: 20px;'>" +
                "<img src='cid:logoImage' alt='WORKHORSE Logo' style='width: 150px;'>" +
                "</div>" +
                "<div style='text-align: center; margin-top: 20px; color: #6c757d;'>" +
                "<p>Best wishes,<br>the DTMB team</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";

            helper.setText(htmlContent, true);
            File logoImage = ResourceUtils.getFile("classpath:static/img/small-light2.png");
            helper.addInline("logoImage", logoImage);

            mailSender.send(message);
            log.info("Email sent to {}", to);
        } catch (Exception e) {
            log.error("Failed to send email", e);
        }
    }

    public void sendForgotPasswordEmail(String email, String resetUrl, String displayName){
        
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(email);
            helper.setFrom(fromAddress, fromName);
            helper.setSubject("Need to reset your password?");
    
            String htmlContent = "<!DOCTYPE html>" +
            "<html lang='en'>" +
            "<head>" +
            "<meta charset='UTF-8'>" +
            "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
            "<title>Password Reset - WORKHORSE</title>" +
            "<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css'>" +
            "</head>" +
            "<body style='font-family: Arial, sans-serif; background-color: #f8f9fa;'>" +
            "<div style='max-width: 600px; margin: auto; padding: 20px; background-color: #f8f9fa; border-radius: 5px;'>" +
            "<div style='text-align: center;'>" +
            "<h2 style='color: #343a40;'>Your new password is just a few clicks away.</h2>" +
            "</div>" +
            "<div style='color: #6c757d; margin-bottom: 20px;'>" +
            "<p>Dear <strong>" + displayName + "</strong>,</p>" +
            "<p>We received a request to reset your password. To proceed with resetting your password, please click the link below:</p>" +
            "<p><a href='" + resetUrl + "'>Reset My Password</a></p>" +
            "<p>Please note that this link will expire in 60 minutes. If you did not request a password reset, please ignore this email or contact our support team if you have any questions.</p>" +
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
            File logoImage = ResourceUtils.getFile("classpath:static/img/small-light2.png");
            helper.addInline("logoImage", logoImage);

            mailSender.send(message);
            log.info("Forgot password email sent to {}", email);
        } catch (Exception e) {
            log.error("Failed to send forgot password email", e);
        }
    }

}
