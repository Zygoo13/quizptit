package com.quizptit.user.controller;

import com.quizptit.common.exception.BusinessException;
import com.quizptit.common.exception.FileStorageException;
import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.user.dto.ChangePasswordForm;
import com.quizptit.user.dto.UpdateProfileForm;
import com.quizptit.user.entity.User;
import com.quizptit.user.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/profile")
    public String profilePage(Model model) {
        Long currentUserId = CurrentUserUtils.getCurrentUserId();
        User user = userService.getUserById(currentUserId);

        if (!model.containsAttribute("updateProfileForm")) {
            UpdateProfileForm updateProfileForm = new UpdateProfileForm();
            updateProfileForm.setFullName(user.getFullName());
            model.addAttribute("updateProfileForm", updateProfileForm);
        }

        if (!model.containsAttribute("changePasswordForm")) {
            model.addAttribute("changePasswordForm", new ChangePasswordForm());
        }

        model.addAttribute("currentUserId", user.getUserId());
        model.addAttribute("currentUserEmail", user.getEmail());
        model.addAttribute("currentUserStatus", user.getStatus().name());
        model.addAttribute("currentUserRole", user.getRole().getRoleName().name());
        model.addAttribute("currentAvatarUrl", user.getAvatarUrl());

        return "user/profile";
    }

    @PostMapping("/profile")
    public String updateProfile(
            @Valid @ModelAttribute("updateProfileForm") UpdateProfileForm updateProfileForm,
            BindingResult bindingResult,
            @ModelAttribute("avatarFile") MultipartFile avatarFile,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("changePasswordForm", new ChangePasswordForm());
            populateCurrentUserInfo(model);
            return "user/profile";
        }

        try {
            Long currentUserId = CurrentUserUtils.getCurrentUserId();
            userService.updateProfile(currentUserId, updateProfileForm, avatarFile);
        } catch (FileStorageException ex) {
            model.addAttribute("changePasswordForm", new ChangePasswordForm());
            model.addAttribute("profileErrorMessage", ex.getMessage());
            populateCurrentUserInfo(model);
            return "user/profile";
        }

        redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully.");
        return "redirect:/profile";
    }

    @PostMapping("/profile/change-password")
    public String changePassword(
            @Valid @ModelAttribute("changePasswordForm") ChangePasswordForm changePasswordForm,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
        if (bindingResult.hasErrors()) {
            Long currentUserId = CurrentUserUtils.getCurrentUserId();
            User user = userService.getUserById(currentUserId);

            UpdateProfileForm updateProfileForm = new UpdateProfileForm();
            updateProfileForm.setFullName(user.getFullName());

            model.addAttribute("updateProfileForm", updateProfileForm);
            populateCurrentUserInfo(model);
            return "user/profile";
        }

        try {
            Long currentUserId = CurrentUserUtils.getCurrentUserId();
            userService.changePassword(currentUserId, changePasswordForm);
        } catch (BusinessException ex) {
            Long currentUserId = CurrentUserUtils.getCurrentUserId();
            User user = userService.getUserById(currentUserId);

            UpdateProfileForm updateProfileForm = new UpdateProfileForm();
            updateProfileForm.setFullName(user.getFullName());

            model.addAttribute("updateProfileForm", updateProfileForm);
            model.addAttribute("passwordErrorMessage", ex.getMessage());
            populateCurrentUserInfo(model);
            return "user/profile";
        }

        redirectAttributes.addFlashAttribute("successMessage", "Password changed successfully.");
        return "redirect:/profile";
    }

    private void populateCurrentUserInfo(Model model) {
        Long currentUserId = CurrentUserUtils.getCurrentUserId();
        User user = userService.getUserById(currentUserId);

        model.addAttribute("currentUserId", user.getUserId());
        model.addAttribute("currentUserEmail", user.getEmail());
        model.addAttribute("currentUserStatus", user.getStatus().name());
        model.addAttribute("currentUserRole", user.getRole().getRoleName().name());
        model.addAttribute("currentAvatarUrl", user.getAvatarUrl());
    }
}