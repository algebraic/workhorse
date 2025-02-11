package gov.michigan.lara.controller;

import gov.michigan.lara.domain.User;
import gov.michigan.lara.security.UserDetailsUtil;
import gov.michigan.lara.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.apache.logging.log4j.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserController{
    
    private static Logger log = LogManager.getLogger();

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

    @GetMapping("/users/exists")
    public ResponseEntity<Boolean> emailExists(@RequestParam("email") String email) {
        boolean exists = userService.existsByEmail(email);
        return ResponseEntity.ok(exists);
    }

    @GetMapping("/user/{id}")
    public User findUsersById(@PathVariable Long id){
        return userService.findUserById(id);
    }

    // Save operation
    @PostMapping("/user")
    public User saveUser(@Valid @RequestBody User user, HttpServletRequest request){
        String serverUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
        return userService.saveUser(user, serverUrl);
    }

    // Update operation
    @PutMapping("/user/{id}")
    public User updateUser(@RequestBody User user,@PathVariable Long id, @RequestParam Optional<Boolean> profileUpdate){
        Boolean fromProfile = profileUpdate.orElse(false);
        if (fromProfile) {
            log.info("updating user from user profile\n" + user.toString());
            return userService.updateOwnUser(user,id);
        } else {
            log.info("updating user from user list\n" + user.toString());
            return userService.updateUser(user,id);
        }
    }

    @PutMapping("/updateDisplayName/{id}")
    public User updateDisplayName(@RequestParam String displayName,@PathVariable Long id){
        return userService.updateDisplayName(displayName,id);
    }

    @ResponseBody
    @PostMapping("/resetPassword")
    public String resetPassword(@RequestParam Long id){
        User pwuser = userService.findUserById(id);
        userService.resetPassword(pwuser);
        System.out.println("reset password for user " + pwuser.getUsername());
        return "yay";
    }

}                    