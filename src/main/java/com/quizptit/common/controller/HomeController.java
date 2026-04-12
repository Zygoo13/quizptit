package com.quizptit.common.controller;

import com.quizptit.common.util.CurrentUserUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String homePage(Model model) {
        model.addAttribute("currentUserEmail", CurrentUserUtils.getCurrentUserEmail());
        model.addAttribute("isLoggedIn", CurrentUserUtils.isLoggedIn());
        model.addAttribute("isAdmin", CurrentUserUtils.isAdmin());
        model.addAttribute("isStudent", CurrentUserUtils.isStudent());
        return "index";
    }

    @GetMapping("/student/dashboard")
    public String studentDashboard(Model model) {
        if (!CurrentUserUtils.isLoggedIn()) {
            return "redirect:/auth/login";
        }

        if (CurrentUserUtils.isAdmin()) {
            return "redirect:/admin";
        }

        model.addAttribute("currentUserEmail", CurrentUserUtils.getCurrentUserEmail());
        return "student/dashboard";
    }
}