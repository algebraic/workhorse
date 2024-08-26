package gov.michigan.lara.service;

import gov.michigan.lara.domain.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    List<User> getAllUsers();
    User findUserById(Long id);
    User saveUser(User user);
    User updateUser(User user, Long id);
    User updateOwnUser(User user, Long id);
    User resetPassword(User user);
    Optional<User> findUserByEmail(String email);
    void updateUserPassword(User user,String encodedPassword);
    boolean existsByEmail(String email);
}