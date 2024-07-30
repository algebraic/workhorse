package gov.michigan.lara.service;

import gov.michigan.lara.config.UserDetailsUtil;
import gov.michigan.lara.dao.UserRepository;
import gov.michigan.lara.domain.User;
import gov.michigan.lara.util.EmailService;
import gov.michigan.lara.util.PasswordGenerator;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

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
        log.info("saving new user: " + user.toString());
        
        String randomPassword = PasswordGenerator.generateRandomPassword();
        user.setPassword(passwordEncoder.encode(randomPassword));
        user.setCreatedBy(UserDetailsUtil.getCurrentUsername());
        user.setCreatedOn(Timestamp.valueOf(LocalDateTime.now()));

        // Send the email
        String subject = "workhorse: new user email";
        String message = "An account has been created for you on the workhorse app. Your username is " + user.getUsername() + ", and your password is " + randomPassword;
        emailService.sendSimpleEmail(user.getEmail(), subject, message);

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
        userDB.setPassword(passwordEncoder.encode(user.getPassword()));
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

}