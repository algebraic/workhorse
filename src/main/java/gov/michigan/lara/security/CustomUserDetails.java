package gov.michigan.lara.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import gov.michigan.lara.domain.User;
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
    public CustomUserDetails(User user){
        //Auto-generated constructor stub
    }
    private Long id;
    private String username;
    private String password;
    private String displayName;
    private String bureau;
    private String email;
    private Boolean passwordExpired;
    private Collection<? extends GrantedAuthority> authorities;
    @Override
    public boolean isAccountNonExpired(){
        throw new UnsupportedOperationException("Unimplemented method 'isAccountNonExpired'");
    }
    @Override
    public boolean isAccountNonLocked(){
        throw new UnsupportedOperationException("Unimplemented method 'isAccountNonLocked'");
    }
    @Override
    public boolean isCredentialsNonExpired(){
        throw new UnsupportedOperationException("Unimplemented method 'isCredentialsNonExpired'");
    }
    @Override
    public boolean isEnabled(){
        throw new UnsupportedOperationException("Unimplemented method 'isEnabled'");
    }

}
