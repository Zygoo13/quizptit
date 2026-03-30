package com.quizptit.user.controller;

import com.quizptit.common.constant.RoleName;
import com.quizptit.common.exception.BusinessException;
import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.user.dto.AdminUserFilterForm;
import com.quizptit.user.dto.ChangeUserRoleForm;
import com.quizptit.user.entity.User;
import com.quizptit.user.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Arrays;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class AdminController {

    private final UserService userService;

    @GetMapping("/admin")
    public String adminDashboard(Model model) {
        model.addAttribute("currentUserEmail", CurrentUserUtils.getCurrentUserEmail());
        return "admin/dashboard";
    }

    @GetMapping("/admin/users")
    public String userListPage(
            @ModelAttribute("filterForm") AdminUserFilterForm filterForm,
            Model model
    ) {
        List<User> users = userService.searchUsers(filterForm);
        model.addAttribute("users", users);
        model.addAttribute("currentUserEmail", CurrentUserUtils.getCurrentUserEmail());
        model.addAttribute("statuses", Arrays.asList("ACTIVE", "INACTIVE", "BANNED"));
        return "admin/user-list";
    }

    @GetMapping("/admin/users/{userId}")
    public String userDetailPage(@PathVariable Long userId, Model model) {
        User user = userService.getUserById(userId);

        if (!model.containsAttribute("changeUserRoleForm")) {
            ChangeUserRoleForm form = new ChangeUserRoleForm();
            form.setRoleName(user.getRole().getRoleName().name());
            model.addAttribute("changeUserRoleForm", form);
        }

        model.addAttribute("selectedUser", user);
        model.addAttribute("currentUserEmail", CurrentUserUtils.getCurrentUserEmail());
        model.addAttribute("availableRoles", RoleName.values());
        return "admin/user-detail";
    }

    @PostMapping("/admin/users/{userId}/ban")
    public String banUser(@PathVariable Long userId, RedirectAttributes redirectAttributes) {
        preventSelfModification(userId);
        userService.banUser(userId);
        redirectAttributes.addFlashAttribute("successMessage", "User has been banned.");
        return "redirect:/admin/users/" + userId;
    }

    @PostMapping("/admin/users/{userId}/activate")
    public String activateUser(@PathVariable Long userId, RedirectAttributes redirectAttributes) {
        preventSelfModification(userId);
        userService.activateUser(userId);
        redirectAttributes.addFlashAttribute("successMessage", "User has been activated.");
        return "redirect:/admin/users/" + userId;
    }

    @PostMapping("/admin/users/{userId}/deactivate")
    public String deactivateUser(@PathVariable Long userId, RedirectAttributes redirectAttributes) {
        preventSelfModification(userId);
        userService.deactivateUser(userId);
        redirectAttributes.addFlashAttribute("successMessage", "User has been deactivated.");
        return "redirect:/admin/users/" + userId;
    }

    @PostMapping("/admin/users/{userId}/change-role")
    public String changeUserRole(
            @PathVariable Long userId,
            @Valid @ModelAttribute("changeUserRoleForm") ChangeUserRoleForm changeUserRoleForm,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
        preventSelfModification(userId);

        if (bindingResult.hasErrors()) {
            User user = userService.getUserById(userId);
            model.addAttribute("selectedUser", user);
            model.addAttribute("currentUserEmail", CurrentUserUtils.getCurrentUserEmail());
            model.addAttribute("availableRoles", RoleName.values());
            return "admin/user-detail";
        }

        try {
            userService.changeUserRole(userId, RoleName.valueOf(changeUserRoleForm.getRoleName()));
        } catch (IllegalArgumentException ex) {
            User user = userService.getUserById(userId);
            model.addAttribute("selectedUser", user);
            model.addAttribute("currentUserEmail", CurrentUserUtils.getCurrentUserEmail());
            model.addAttribute("availableRoles", RoleName.values());
            model.addAttribute("roleErrorMessage", "Invalid role.");
            return "admin/user-detail";
        } catch (BusinessException ex) {
            User user = userService.getUserById(userId);
            model.addAttribute("selectedUser", user);
            model.addAttribute("currentUserEmail", CurrentUserUtils.getCurrentUserEmail());
            model.addAttribute("availableRoles", RoleName.values());
            model.addAttribute("roleErrorMessage", ex.getMessage());
            return "admin/user-detail";
        }

        redirectAttributes.addFlashAttribute("successMessage", "User role has been updated.");
        return "redirect:/admin/users/" + userId;
    }

    private void preventSelfModification(Long targetUserId) {
        Long currentUserId = CurrentUserUtils.getCurrentUserId();
        if (currentUserId != null && currentUserId.equals(targetUserId)) {
            throw new IllegalArgumentException("You cannot modify your own account from admin actions.");
        }
    }
}