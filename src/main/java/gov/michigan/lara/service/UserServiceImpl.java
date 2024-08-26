package gov.michigan.lara.service;

import gov.michigan.lara.dao.UserRepository;
import gov.michigan.lara.domain.User;
import gov.michigan.lara.security.UserDetailsUtil;
import gov.michigan.lara.util.EmailService;
import gov.michigan.lara.util.PasswordGenerator;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    private static Logger log = LogManager.getLogger();

    @Autowired
    private UserRepository repository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private EmailService emailService;

    @Override
    public List<User> getAllUsers(){
        return (List<User>) repository.findAll();
    }

    @Override
    public User findUserById(Long id) {
        return repository.findById(id).get();
    }

    @Override
    public User saveUser(User user) {
        // check if email already exists before saving
        if (repository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already in use");
        }

        log.info("saving new user: " + user.toString());
        String randomPassword = PasswordGenerator.generateRandomPassword();
        user.setPassword(passwordEncoder.encode(randomPassword));
        user.setCreatedBy(UserDetailsUtil.getCurrentUsername());
        user.setCreatedOn(Timestamp.valueOf(LocalDateTime.now()));
        user.setPasswordExpired(true);

        // Send the email
        emailService.sendHtmlEmail(
            user.getEmail(),
            "Your account has been created!",
            user.getUsername(),
            user.getDisplayName(),
            randomPassword,
            "http://127.0.0.1:8080/workhorse"
        );

        return repository.save(user);
    }

    @Override
    public User updateUser(User user,Long id){
        log.info("updating user id " + id);
        User userDB=repository.findById(id).get();
        userDB.setBureau(user.getBureau());
        userDB.setDisabled((user.isDisabled()));
        userDB.setDisplayName(user.getDisplayName());
        userDB.setEmail(user.getEmail());
        userDB.setId(user.getId());
        userDB.setUsername(user.getUsername());

        // Preserve createdBy and createdOn if they are null in the update
        if (user.getCreatedBy() != null) {
            userDB.setCreatedBy(user.getCreatedBy());
        }
        if (user.getCreatedOn() != null) {
            userDB.setCreatedOn(user.getCreatedOn());
        }
        
        userDB.setModifiedBy(UserDetailsUtil.getCurrentUsername());
        userDB.setModifiedOn(Timestamp.valueOf(LocalDateTime.now()));
        
        return repository.save(userDB);
    }

    @Override
    public User updateOwnUser(User user,Long id){
        log.info("updating userprofile " + id);
        User userDB=repository.findById(id).get();
        userDB.setDisplayName(user.getDisplayName());
        userDB.setPassword(passwordEncoder.encode(user.getPassword()));
        userDB.setModifiedBy(UserDetailsUtil.getCurrentUsername());
        userDB.setModifiedOn(Timestamp.valueOf(LocalDateTime.now()));
        return repository.save(userDB);
    }

    @Override
    public User resetPassword(User user){
        log.info("resetting password: " + user.toString());
        
        String randomPassword = PasswordGenerator.generateRandomPassword();
        user.setPassword(passwordEncoder.encode(randomPassword));
        user.setPasswordExpired(true);
        user.setModifiedBy(UserDetailsUtil.getCurrentUsername());
        user.setModifiedOn(Timestamp.valueOf(LocalDateTime.now()));

        // Send the email
        emailService.sendPWEmail(
            user.getEmail(),
            "Here's your temporary password",
            user.getUsername(),
            user.getDisplayName(),
            randomPassword,
            "http://127.0.0.1:8080/workhorse"
        );

        return repository.save(user);
    }

    @Override
    public Optional<User> findUserByEmail(String email){
        return repository.findByEmail(email);
    }

    @Override
    public void updateUserPassword(User user, String encodedPassword){
        // TODO Auto-generated method stub
        System.out.println("Unimplemented method 'updateUserPassword'");
        throw new UnsupportedOperationException("Unimplemented method 'updateUserPassword'");
    }

    @Override
    public boolean existsByEmail(String email){
        return repository.existsByEmail(email);
    }

}