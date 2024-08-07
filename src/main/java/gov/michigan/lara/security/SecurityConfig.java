package gov.michigan.lara.security;

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
                .requestMatchers("/auth/*", "/logout", "/img/**", "/css/**", "/js/**", "/resources/**", "/commitId/**").permitAll() // Permit access to these paths
                .requestMatchers("/WEB-INF/jsp/**").permitAll() // Exclude JSP view paths
                .anyRequest().authenticated()) // Require authentication for other requests
            .formLogin(form -> form
                .loginPage("/auth/login")
                .failureHandler(new CustomAuthenticationFailureHandler())
                .permitAll())
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/auth/login")
                .permitAll())
            .csrf(csrf -> csrf
                .ignoringRequestMatchers("/auth/*", "/logout", "/img/**", "/css/**", "/js/**", "/resources/**", "/commitId/**")); // Exclude CSRF for these paths

        return http.build();
    }

    // // zj: use default spring security login/logout, comment out other bean to swap
    // @Bean
    // public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    //     http
    //         .authorizeHttpRequests(requests -> requests
    //             .requestMatchers("/commitId/**", "/resources/**").permitAll()
    //             .requestMatchers("/testlogin/**").permitAll() // Ensure this path is permitted
    //             .anyRequest().authenticated())
    //         .httpBasic(withDefaults())
    //         .formLogin(withDefaults())
    //         .csrf(csrf -> csrf.disable());
    //     return http.build();
    // }

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

    @SuppressWarnings("deprecation")
    @Bean
    public PasswordEncoder passwordEncoder(){
        Map<String,PasswordEncoder> encoders=new HashMap<>();
        encoders.put("bcrypt",new BCryptPasswordEncoder());
        encoders.put("noop",NoOpPasswordEncoder.getInstance());
        return new DelegatingPasswordEncoder("bcrypt",encoders);
    }
}
