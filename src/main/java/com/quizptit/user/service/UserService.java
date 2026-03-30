package com.quizptit.user.service;

import com.quizptit.common.constant.RoleName;
import com.quizptit.common.constant.UserStatus;
import com.quizptit.common.exception.BusinessException;
import com.quizptit.common.exception.ResourceNotFoundException;
import com.quizptit.common.service.FileStorageService;
import com.quizptit.user.dto.AdminUserFilterForm;
import com.quizptit.user.dto.ChangePasswordForm;
import com.quizptit.user.dto.UpdateProfileForm;
import com.quizptit.user.entity.Role;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.RoleRepository;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final FileStorageService fileStorageService;

    @Transactional(readOnly = true)
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found."));
    }

    @Transactional(readOnly = true)
    public User getUserById(Long userId) {
        return userRepository.findByUserId(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found."));
    }

    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<User> searchUsers(AdminUserFilterForm filterForm) {
        String keyword = normalizeKeyword(filterForm.getKeyword());
        UserStatus status = parseStatus(filterForm.getStatus());

        if (keyword == null && status == null) {
            return userRepository.findAll();
        }

        if (keyword != null && status == null) {
            return userRepository
                    .findByEmailContainingIgnoreCaseOrFullNameContainingIgnoreCase(keyword, keyword);
        }

        if (keyword == null) {
            return userRepository.findByStatus(status);
        }

        return userRepository
                .findByEmailContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndStatus(
                        keyword, keyword, status
                );
    }

    @Transactional
    public void updateProfile(Long userId, UpdateProfileForm form, MultipartFile avatarFile) {
        User user = getUserById(userId);

        user.setFullName(form.getFullName().trim());

        if (avatarFile != null && !avatarFile.isEmpty()) {
            String avatarUrl = fileStorageService.storeImage(avatarFile, "avatars");
            user.setAvatarUrl(avatarUrl);
        }

        userRepository.save(user);
    }

    @Transactional
    public void changePassword(Long userId, ChangePasswordForm form) {
        User user = getUserById(userId);

        if (!passwordEncoder.matches(form.getCurrentPassword(), user.getPasswordHash())) {
            throw new BusinessException("Current password is incorrect.");
        }

        if (!form.getNewPassword().equals(form.getConfirmNewPassword())) {
            throw new BusinessException("Confirm new password does not match.");
        }

        if (passwordEncoder.matches(form.getNewPassword(), user.getPasswordHash())) {
            throw new BusinessException("New password must be different from current password.");
        }

        user.setPasswordHash(passwordEncoder.encode(form.getNewPassword()));
        userRepository.save(user);
    }

    @Transactional
    public void updateUserStatus(Long userId, UserStatus newStatus) {
        User user = getUserById(userId);
        user.setStatus(newStatus);
        userRepository.save(user);
    }

    @Transactional
    public void changeUserRole(Long userId, RoleName roleName) {
        User user = getUserById(userId);

        Role role = roleRepository.findByRoleName(roleName)
                .orElseThrow(() -> new BusinessException("Role not found."));

        user.setRole(role);
        userRepository.save(user);
    }

    @Transactional
    public void banUser(Long userId) {
        updateUserStatus(userId, UserStatus.BANNED);
    }

    @Transactional
    public void activateUser(Long userId) {
        updateUserStatus(userId, UserStatus.ACTIVE);
    }

    @Transactional
    public void deactivateUser(Long userId) {
        updateUserStatus(userId, UserStatus.INACTIVE);
    }

    private String normalizeAvatarUrl(String avatarUrl) {
        if (avatarUrl == null || avatarUrl.isBlank()) {
            return null;
        }
        return avatarUrl.trim();
    }

    private String normalizeKeyword(String keyword) {
        if (keyword == null || keyword.isBlank()) {
            return null;
        }
        return keyword.trim();
    }

    private UserStatus parseStatus(String status) {
        if (status == null || status.isBlank()) {
            return null;
        }

        try {
            return UserStatus.valueOf(status.trim().toUpperCase());
        } catch (IllegalArgumentException ex) {
            throw new BusinessException("Invalid user status filter.");
        }
    }
}