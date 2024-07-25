package gov.michigan.lara.service;

import gov.michigan.lara.dao.UserRepository;
import gov.michigan.lara.domain.User;

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

    @Override
    public List<User> getAllUsers(){
        return (List<User>) repository.findAll();
    }

    @Override
    public User findUserById(Long id) {
        return repository.getReferenceById(id);
    }

    @Override
    public User saveUser(User user) {
        log.info("saving user: " + user.toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return repository.save(user);
    }

}