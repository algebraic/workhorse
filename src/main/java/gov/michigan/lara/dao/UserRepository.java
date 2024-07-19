package gov.michigan.lara.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import gov.michigan.lara.domain.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}