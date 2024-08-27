package gov.michigan.lara.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import gov.michigan.lara.dao.PasswordResetTokenRepository;
import gov.michigan.lara.domain.PasswordResetToken;
import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class PasswordResetService {

    @Autowired
    private PasswordResetTokenRepository tokenRepository;
    
    @Transactional
    public PasswordResetToken createPasswordResetToken(String email) {
        String token = UUID.randomUUID().toString();
        LocalDateTime expirationTime = LocalDateTime.now().plusHours(1);

        // Remove any existing tokens for the user
        tokenRepository.deleteByEmail(email);

        // Save the new token
        PasswordResetToken resetToken = new PasswordResetToken();
        resetToken.setEmail(email);
        resetToken.setToken(token);
        resetToken.setExpirationTime(expirationTime);

        tokenRepository.save(resetToken);

        return resetToken;
    }

    @Transactional
    public boolean validatePasswordResetToken(String token) {
        PasswordResetToken resetToken = tokenRepository.findByToken(token)
            .orElseThrow(() -> new IllegalArgumentException("Invalid token"));

        if (resetToken.getExpirationTime().isBefore(LocalDateTime.now())) {
            // Token is expired, delete it from the database
            tokenRepository.deleteByToken(token);
            throw new IllegalArgumentException("Token expired");
        }

        return true;
    }

}
