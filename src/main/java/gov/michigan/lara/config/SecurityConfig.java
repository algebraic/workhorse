package gov.michigan.lara.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.DelegatingPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import gov.michigan.lara.dao.UserRepository;

import static org.springframework.security.config.Customizer.withDefaults;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity // Enable method level security annotations
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
         http
                 .authorizeHttpRequests(requests -> requests
                         .requestMatchers("/commitId/**", "/resources/**").permitAll()
                         .requestMatchers("/**", "/index/**").authenticated()  // Secure paths starting with "/empapp/api/v1/"
                         .anyRequest().permitAll())
                 .httpBasic(withDefaults())
                 .formLogin(withDefaults()).csrf(csrf -> csrf.disable());
        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService(UserRepository userRepository) {
        return new CustomUserDetailsService(userRepository);
    }

    @Bean
    public AuthenticationManager authenticationManager(UserDetailsService userDetailsService, PasswordEncoder passwordEncoder) {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setUserDetailsService(userDetailsService);
        authenticationProvider.setPasswordEncoder(passwordEncoder);
        return new ProviderManager(Arrays.asList(authenticationProvider));
    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        Map<String,PasswordEncoder> encoders=new HashMap<>();
        encoders.put("bcrypt",new BCryptPasswordEncoder());
        encoders.put("noop",NoOpPasswordEncoder.getInstance());
        return new DelegatingPasswordEncoder("bcrypt",encoders);
    }
}
