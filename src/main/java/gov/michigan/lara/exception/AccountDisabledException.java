package gov.michigan.lara.exception;

import org.springframework.security.core.AuthenticationException;

public class AccountDisabledException extends AuthenticationException {

    public AccountDisabledException(String message) {
        super(message);
    }
}