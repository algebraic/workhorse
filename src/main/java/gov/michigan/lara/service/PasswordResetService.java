package gov.michigan.lara.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import gov.michigan.lara.dao.PasswordResetTokenRepository;
import gov.michigan.lara.domain.PasswordResetToken;
import gov.michigan.lara.domain.User;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
public class PasswordResetService {

    @Autowired
    private PasswordResetTokenRepository tokenRepository;
    
    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

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

    @Transactional
    public void resetPassword(String token, String newPassword) {
        PasswordResetToken resetToken = tokenRepository.findByToken(token)
            .orElseThrow(() -> new IllegalArgumentException("Invalid token"));
    
        // Use the service layer to fetch and update the user
        Optional<User> user = userService.findUserByEmail(resetToken.getEmail());
        User pwuser = user.orElseThrow(() -> new IllegalArgumentException("User not found for the provided token"));

        if (pwuser != null) {
            userService.updateUserPassword(pwuser, passwordEncoder.encode(newPassword));
            tokenRepository.deleteByToken(token);
        }
    }
    
}
