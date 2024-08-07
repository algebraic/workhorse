package gov.michigan.lara.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class UserDetailsUtil {

    public static CustomUserDetails getAuthenticatedUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof CustomUserDetails) {
            return (CustomUserDetails) authentication.getPrincipal();
        }
        return null;
    }

    public static CustomUserDetails getCurrentUserDetails() {
        return getAuthenticatedUser();
    }

    public static String getCurrentUsername() {
        CustomUserDetails userDetails = getAuthenticatedUser();
        return userDetails != null ? userDetails.getUsername() : null;
    }

    public static Long getCurrentUserId() {
        CustomUserDetails userDetails = getAuthenticatedUser();
        return userDetails != null ? userDetails.getId() : null;
    }

    public static String getCurrentUserDisplayName() {
        CustomUserDetails userDetails = getAuthenticatedUser();
        return userDetails != null ? userDetails.getDisplayName() : null;
    }

    public static String getCurrentUserBureau() {
        CustomUserDetails userDetails = getAuthenticatedUser();
        return userDetails != null ? userDetails.getBureau() : null;
    }

    public static Boolean isAdmin() {
        CustomUserDetails userDetails = getAuthenticatedUser();
        if (userDetails != null) {
            return userDetails.getAuthorities().stream()
                .anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_ADMIN"));
        }
        return false;
    }
}
