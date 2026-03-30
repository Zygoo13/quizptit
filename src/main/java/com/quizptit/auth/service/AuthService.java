package com.quizptit.auth.service;

import com.quizptit.auth.dto.RegisterForm;
import com.quizptit.common.constant.RoleName;
import com.quizptit.common.constant.UserStatus;
import com.quizptit.common.exception.BusinessException;
import com.quizptit.user.entity.Role;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.RoleRepository;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public void register(RegisterForm form) {
        validateRegisterForm(form);

        String normalizedEmail = form.getEmail().trim().toLowerCase();
        String normalizedFullName = form.getFullName().trim();

        if (userRepository.existsByEmail(normalizedEmail)) {
            throw new BusinessException("Email already exists.");
        }

        Role studentRole = roleRepository.findByRoleName(RoleName.STUDENT)
                .orElseThrow(() -> new BusinessException("Default STUDENT role not found."));

        User user = new User();
        user.setRole(studentRole);
        user.setFullName(normalizedFullName);
        user.setEmail(normalizedEmail);
        user.setPasswordHash(passwordEncoder.encode(form.getPassword()));
        user.setAvatarUrl(null);
        user.setStatus(UserStatus.ACTIVE);

        userRepository.save(user);
    }

    private void validateRegisterForm(RegisterForm form) {
        if (!form.getPassword().equals(form.getConfirmPassword())) {
            throw new BusinessException("Confirm password does not match.");
        }
    }
}