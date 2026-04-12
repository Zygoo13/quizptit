package com.quizptit.common.util;

import com.quizptit.auth.security.CustomUserDetails;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
public final class CurrentUserUtils {

    private CurrentUserUtils() {
    }

    public static CustomUserDetails getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }

        if (authentication instanceof AnonymousAuthenticationToken) {
            return null;
        }

        Object principal = authentication.getPrincipal();

        if (principal instanceof CustomUserDetails customUserDetails) {
            return customUserDetails;
        }

        return null;
    }

    public static Long getCurrentUserId() {
        CustomUserDetails currentUser = getCurrentUser();
        return currentUser != null ? currentUser.getUserId() : null;
    }

    public static String getCurrentUserEmail() {
        CustomUserDetails currentUser = getCurrentUser();
        return currentUser != null ? currentUser.getEmail() : null;
    }

    public static boolean isLoggedIn() {
        return getCurrentUser() != null;
    }

    public static boolean isAdmin() {
        CustomUserDetails currentUser = getCurrentUser();
        if (currentUser == null) {
            return false;
        }

        return currentUser.getAuthorities().stream()
                .anyMatch(a -> "ROLE_ADMIN".equals(a.getAuthority()));
    }

    public static boolean isStudent() {
        CustomUserDetails currentUser = getCurrentUser();
        if (currentUser == null) {
            return false;
        }

        return currentUser.getAuthorities().stream()
                .anyMatch(a -> "ROLE_STUDENT".equals(a.getAuthority()));
    }

    public static String resolveHomeByRole() {
        if (!isLoggedIn()) {
            return "/";
        }
        if (isAdmin()) {
            return "/admin";
        }
        return "/student/dashboard";
    }
}