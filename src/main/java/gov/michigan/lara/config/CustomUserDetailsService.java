package gov.michigan.lara.config;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import gov.michigan.lara.dao.UserRepository;
import gov.michigan.lara.domain.User;

import java.util.Collections;
import java.util.Set;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        // Determine role based on the bureau field
        String role = "*".equals(user.getBureau()) ? "ROLE_ADMIN" : "ROLE_USER";
        GrantedAuthority authority = new SimpleGrantedAuthority(role);
        Set<GrantedAuthority> grantedAuthorities = Collections.singleton(authority);
        
        return new CustomUserDetails(user.getUsername(), user.getPassword(), user.getFullName(), user.getBureau(), grantedAuthorities);
    }
}
