package gov.michigan.lara.security;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import gov.michigan.lara.exception.PasswordExpiredException;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(PasswordExpiredException.class)
    public ResponseEntity<String> handlePasswordExpiredException(PasswordExpiredException ex) {
        System.out.println("%%%%% handlePasswordExpiredException");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Password expired. Please reset your password.");
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleGenericException(Exception ex) {
        System.out.println("%%%%% handleGenericException");
        ex.printStackTrace();
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred: " + ex.getMessage());
    }
}
