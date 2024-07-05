package gov.michigan.lara.config;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class CustomInMemoryUserDetailsManager implements UserDetailsService {

    private final Map<String, CustomUserDetails> users = new HashMap<>();

    public CustomInMemoryUserDetailsManager() {
        // Create some sample users
        users.put("admin", new CustomUserDetails("admin", "{noop}password", "Admin User", "*", Collections.singleton(() -> "ROLE_ADMIN")));
        users.put("bcc", new CustomUserDetails("bcc", "{noop}password", "BCC User", "BCC", Collections.singleton(() -> "ROLE_USER")));
        users.put("bfs", new CustomUserDetails("bfs", "{noop}password", "BFS User", "BFS", Collections.singleton(() -> "ROLE_USER")));
        users.put("bpl", new CustomUserDetails("bpl", "{noop}password", "BPL User", "BPL", Collections.singleton(() -> "ROLE_USER")));
        users.put("cscl", new CustomUserDetails("cscl", "{noop}password", "CSCL User", "CSCL", Collections.singleton(() -> "ROLE_USER")));
    }

    @Override
    public CustomUserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        CustomUserDetails user = users.get(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found: " + username);
        }
        return user;
    }
}
