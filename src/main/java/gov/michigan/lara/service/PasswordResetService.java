package gov.michigan.lara.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import gov.michigan.lara.dao.PasswordResetTokenRepository;
import gov.michigan.lara.domain.PasswordResetToken;
import java.time.LocalDateTime;
import java.util.Optional;
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
        // Retrieve the reset token from the repository
        Optional<PasswordResetToken> optionalResetToken = tokenRepository.findByToken(token);
    
        // Check if the token is present
        if (!optionalResetToken.isPresent()) {
            throw new IllegalArgumentException("Invalid token");
        }
    
        PasswordResetToken resetToken = optionalResetToken.get();
    
        // Check if the token has expired
        if (resetToken.getExpirationTime().isBefore(LocalDateTime.now())) {
            // Token is expired, delete it from the database
            tokenRepository.deleteByToken(token);
            throw new IllegalArgumentException("Token expired");
        }
    
        return true;
    }
    
}
