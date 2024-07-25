package gov.michigan.lara.controller;

import gov.michigan.lara.config.UserDetailsUtil;
import gov.michigan.lara.domain.User;
import gov.michigan.lara.service.UserService;
import jakarta.validation.Valid;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserController{
    
    @Autowired
    private UserService userService;

    // zj: this is stupid, fix it:
    @GetMapping("/users")
    public List<User> findAllUsers() {
        List<User> userlist = new ArrayList<User>();
        if (UserDetailsUtil.getCurrentUserBureau().equals("*")) {
            userlist = userService.getAllUsers();
        } else {
            userlist.add(userService.findUserById(UserDetailsUtil.getCurrentUserId()));
        }
        return userlist;
    }

    @GetMapping("/user/{id}")
    public User findUsersById(@PathVariable Long id){
        System.out.println("trying find user by id...");
        return userService.findUserById(id);
    }

    // Save operation
    @PostMapping("/user")
    public User saveUser(@Valid @RequestBody User user){
        System.out.println("$$$ saving user $$$");
        return userService.saveUser(user);
    }

}                    