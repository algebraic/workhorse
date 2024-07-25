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
    private Collection<? extends GrantedAuthority> authorities;

    // public CustomUserDetails(Long id, String username, String password, String displayName, String bureau, Collection<? extends GrantedAuthority> authorities) {
    //     this.id = id;
    //     this.username = username;
    //     this.password = password;
    //     this.displayName = displayName;
    //     this.bureau = bureau;
    //     this.authorities = authorities;
    // }

    // @Override
    // public Collection<? extends GrantedAuthority> getAuthorities() {
    //     return authorities;
    // }

    // @Override
    // public String getPassword() {
    //     return password;
    // }

    // @Override
    // public String getUsername() {
    //     return username;
    // }

    // public String getDisplayName() {
    //     return displayName;
    // }

    // public String getBureau() {
    //     return bureau;
    // }

    // @Override
    // public boolean isAccountNonExpired() {
    //     return true;
    // }

    // @Override
    // public boolean isAccountNonLocked() {
    //     return true;
    // }

    // @Override
    // public boolean isCredentialsNonExpired() {
    //     return true;
    // }

    // @Override
    // public boolean isEnabled() {
    //     return true;
    // }
}
