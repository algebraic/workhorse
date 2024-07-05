package gov.michigan.lara.config;

import org.springframework.security.core.context.SecurityContextHolder;

public class UserDetailsUtil {

    public static CustomUserDetails getCurrentUserDetails() {
        CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userDetails;
    }

    public static String getCurrentUsername() {
        CustomUserDetails userDetails = getCurrentUserDetails();
        return userDetails != null ? userDetails.getUsername() : null;
    }

    public static String getCurrentUserDisplayName() {
        CustomUserDetails userDetails = getCurrentUserDetails();
        return userDetails != null ? userDetails.getDisplayName() : null;
    }

    public static String getCurrentUserBureau() {
        CustomUserDetails userDetails = getCurrentUserDetails();
        return userDetails != null ? userDetails.getBureau() : null;
    }
}
