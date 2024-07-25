package gov.michigan.lara.controller;

import gov.michigan.lara.config.UserDetailsUtil;
import gov.michigan.lara.dao.UserRepository;
import gov.michigan.lara.domain.User;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController

public class UserController{
    @Autowired
    private UserRepository userRepository;

    @SuppressWarnings("unchecked")
    @GetMapping("/users")
    public List<User> findAllUsers() {
        List<User> userlist = new ArrayList<User>();
        if (UserDetailsUtil.getCurrentUserBureau().equals("*")) {
            userlist = userRepository.findAll();
        } else {
            userlist.add(userRepository.findByUsername(UserDetailsUtil.getCurrentUsername()));
        }
        return userlist;
    }


}