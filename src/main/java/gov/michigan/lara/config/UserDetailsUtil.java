package gov.michigan.lara.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class UserDetailsUtil {

    private static final CustomUserDetails userDetails=(CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

    public static CustomUserDetails getCurrentUserDetails() {
        CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userDetails;
    }

    public static String getCurrentUsername() {
        return userDetails != null ? userDetails.getUsername() : null;
    }

    public static Long getCurrentUserId() {
        return userDetails != null ? userDetails.getId() : null;
    }

    public static String getCurrentUserDisplayName() {
        return userDetails != null ? userDetails.getDisplayName() : null;
    }

    public static String getCurrentUserBureau() {
        return userDetails != null ? userDetails.getBureau() : null;
    }

    public static Boolean isAdmin() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        boolean isAdmin = auth.getAuthorities().stream().anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_ADMIN"));
        return isAdmin;
    }
}
