package gov.michigan.lara.util;

import java.security.SecureRandom;
import java.util.Base64;

public class PasswordGenerator {

    private static final SecureRandom RANDOM = new SecureRandom();
    private static final int PASSWORD_LENGTH = 12;

    public static String generateRandomPassword() {
        byte[] randomBytes = new byte[PASSWORD_LENGTH];
        RANDOM.nextBytes(randomBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
    }
}
