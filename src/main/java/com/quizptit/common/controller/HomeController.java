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
        return "index";
    }
}