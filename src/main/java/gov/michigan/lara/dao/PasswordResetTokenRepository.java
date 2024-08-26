package gov.michigan.lara.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import gov.michigan.lara.domain.PasswordResetToken;

import java.util.Optional;

public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken,Long>{

    Optional<PasswordResetToken> findByToken(String token);

    void deleteByToken(String token);

    void deleteByEmail(String email);
}
