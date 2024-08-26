package gov.michigan.lara.security;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import gov.michigan.lara.exception.PasswordExpiredException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        Throwable cause = exception;
        
        // Check if it's the PasswordExpiredException or if it's wrapped inside another exception
        while (cause != null) {
            if (cause instanceof PasswordExpiredException) {
                Long userId = ((PasswordExpiredException) cause).getUserId();
                request.getSession().setAttribute("expiredUserId", userId);
                response.sendRedirect("login?error=passwordExpired");
                return;
            }
            cause = cause.getCause(); // Move to the next cause in the chain
        }
        
        // Handle other exceptions
        System.out.println("exception cause: " + exception.toString());
        response.sendRedirect("login?error=invalid");
        
    }
}
