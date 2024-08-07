package gov.michigan.lara.security;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import gov.michigan.lara.exception.PasswordExpiredException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler{

    @Override
    public void onAuthenticationFailure(HttpServletRequest request,HttpServletResponse response,AuthenticationException exception) throws IOException,ServletException{
        if(exception.getCause() instanceof PasswordExpiredException){
            Long userId = ((PasswordExpiredException) exception.getCause()).getUserId();
            request.getSession().setAttribute("passwordExpiredUserId", userId);
            System.out.println("change password prompt, userid = " + userId);
            response.sendRedirect(request.getContextPath()+"/auth/login?error=passwordExpired");
        }else{
            response.sendRedirect(request.getContextPath()+"/auth/login?error=true");
        }
    }
}
