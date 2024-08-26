package gov.michigan.lara.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import gov.michigan.lara.domain.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
    Optional<User> findByEmail(String email);
    boolean existsByEmail(String email);
}