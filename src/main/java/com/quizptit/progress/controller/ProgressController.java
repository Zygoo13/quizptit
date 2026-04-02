package com.quizptit.progress.controller;

import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.progress.dto.QuizProgressDTO;
import com.quizptit.progress.service.ProgressService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/my-progress")
@RequiredArgsConstructor
public class ProgressController {

    private final ProgressService progressService;

    @GetMapping
    public String viewMyProgress(Model model) {
        // Lấy ID sinh viên đang đăng nhập từ Utility đã có sẵn
        Long userId = CurrentUserUtils.getCurrentUserId();
        
        if (userId == null) {
            return "redirect:/auth/login";
        }

        // Lấy danh sách DTO từ Service đã viết ở Chặng 1
        List<QuizProgressDTO> progressList = progressService.getMyProgress(userId);
        
        // Đẩy dữ liệu vào Model để Thymeleaf có thể truy cập bằng biến ${quizzes}
        model.addAttribute("quizzes", progressList);
        
        return "progress/my-progress"; // Trỏ đến templates/progress/my-progress.html
    }
}