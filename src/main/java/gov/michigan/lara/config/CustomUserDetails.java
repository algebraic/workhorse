package gov.michigan.lara.config;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Collection;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString()
@EqualsAndHashCode(callSuper=false)
public class CustomUserDetails implements UserDetails {
    private Long id;
    private String username;
    private String password;
    private String displayName;
    private String bureau;
    private String email;
    private Boolean passwordChanged;
    private Collection<? extends GrantedAuthority> authorities;

}
