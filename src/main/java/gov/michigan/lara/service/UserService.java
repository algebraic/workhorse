package gov.michigan.lara.service;

import gov.michigan.lara.domain.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    List<User> getAllUsers();
    User findUserById(Long id);
    User saveUser(User user, String serverUrl);
    User updateUser(User user, Long id);
    User updateOwnUser(User user, Long id);
    User updateDisplayName(String displayName, Long id);
    User resetPassword(User user);
    Optional<User> findUserByEmail(String email);
    boolean existsByEmail(String email);
}