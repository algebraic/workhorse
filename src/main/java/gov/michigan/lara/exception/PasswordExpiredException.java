package gov.michigan.lara.exception;

import org.springframework.security.core.AuthenticationException;

public class PasswordExpiredException extends AuthenticationException {

    private final Long userId;

    public PasswordExpiredException(Long id) {
        super("Password expired");
        this.userId = id;

    }


    public Long getUserId() {
        return userId;
    }
}