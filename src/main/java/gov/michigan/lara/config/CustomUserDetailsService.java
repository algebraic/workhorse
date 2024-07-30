package gov.michigan.lara.config;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import gov.michigan.lara.dao.UserRepository;
import gov.michigan.lara.domain.User;
import org.apache.logging.log4j.*;
import java.util.Collections;
import java.util.Set;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private static Logger log = LogManager.getLogger();

    private final UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.info("looking for username '" + username + "'");
        User user = userRepository.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        } else {
            log.info("found user: " + user.getDisplayName());
            // Determine role based on the bureau field
            String role = "*".equals(user.getBureau()) ? "ROLE_ADMIN" : "ROLE_USER";
            log.info("setting " + user.getUsername() + "'s role to " + role);
            
            GrantedAuthority authority = new SimpleGrantedAuthority(role);
            Set<GrantedAuthority> grantedAuthorities = Collections.singleton(authority);
            
            return new CustomUserDetails(user.getId(), user.getUsername(), user.getPassword(), user.getDisplayName(), user.getBureau(), user.isPasswordChanged(), grantedAuthorities);
        }
    }

}
