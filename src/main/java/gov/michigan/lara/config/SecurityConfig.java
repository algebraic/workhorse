package gov.michigan.lara.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import static org.springframework.security.config.Customizer.withDefaults;

import java.util.Arrays;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true) // Enable method level security annotations
public class SecurityConfig {

     @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
         http
                 .authorizeRequests(requests -> requests
                         .antMatchers("/commitId/**", "/resources/**").permitAll()
                         .antMatchers("/**", "/index/**").authenticated()  // Secure paths starting with "/empapp/api/v1/"
                         .anyRequest().permitAll())
                 .httpBasic(withDefaults())
                 .formLogin(withDefaults()).csrf(csrf -> csrf.disable());
        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        // Define multiple users
        UserDetails user1 = User.withUsername("user1").password("{noop}password").roles("USER").build();
        UserDetails user2 = User.withUsername("user2").password("{noop}password").roles("USER").build();
        UserDetails admin = User.withUsername("admin").password("{noop}password").roles("ADMIN").build();
        
        UserDetails userDetails = User.withDefaultPasswordEncoder()
                .username("user1").password("password").roles("USER")
                .username("user2").password("password").roles("USER")
                .username("admin").password("password").roles("ADMIN")
                .build();

        // Use an InMemoryUserDetailsManager to manage the users
        return new InMemoryUserDetailsManager(Arrays.asList(user1, user2, admin));
    }

    @Bean
    public AuthenticationManager authenticationManager(UserDetailsService userDetailsService, PasswordEncoder passwordEncoder) {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setUserDetailsService(userDetailsService);
        authenticationProvider.setPasswordEncoder(passwordEncoder);
        return new ProviderManager(Arrays.asList(authenticationProvider));
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
}
