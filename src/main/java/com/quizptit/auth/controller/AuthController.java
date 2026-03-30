package com.quizptit.auth.controller;

import com.quizptit.auth.dto.RegisterForm;
import com.quizptit.auth.service.AuthService;
import com.quizptit.common.exception.BusinessException;
import com.quizptit.common.util.CurrentUserUtils;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @GetMapping("/auth/login")
    public String loginPage() {
        if (CurrentUserUtils.isLoggedIn()) {
            return "redirect:/";
        }
        return "auth/login";
    }

    @GetMapping("/auth/register")
    public String registerPage(Model model) {
        if (CurrentUserUtils.isLoggedIn()) {
            return "redirect:/";
        }

        if (!model.containsAttribute("registerForm")) {
            model.addAttribute("registerForm", new RegisterForm());
        }

        return "auth/register";
    }

    @PostMapping("/auth/register")
    public String register(
            @Valid @ModelAttribute("registerForm") RegisterForm registerForm,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
        if (bindingResult.hasErrors()) {
            return "auth/register";
        }

        try {
            authService.register(registerForm);
        } catch (BusinessException ex) {
            model.addAttribute("errorMessage", ex.getMessage());
            return "auth/register";
        }

        redirectAttributes.addFlashAttribute("successMessage", "Register successful. Please login.");
        return "redirect:/auth/login";
    }
}