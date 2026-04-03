package com.quizptit.review.controller;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.quizptit.auth.security.CustomUserDetails;
import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.review.dto.ReviewSubmissionDTO;
import com.quizptit.review.dto.ReviewSuggestionDTO;
import com.quizptit.review.dto.ReviewQuestionDTO;
import com.quizptit.review.service.ReviewService;
import com.quizptit.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/review")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;
    private final CurrentUserUtils currentUserUtils;

    @GetMapping("/suggestions")
    public String viewReviewSuggestions(Model model) {
        Long userId = CurrentUserUtils.getCurrentUserId();
        
        if (userId == null) {
            return "redirect:/auth/login";
        }

        List<ReviewSuggestionDTO> suggestions = reviewService.getReviewSuggestions(userId);
        model.addAttribute("suggestions", suggestions);
        
        return "review/suggestions";
    }

    // Xử lý nộp bài
    @PostMapping("/session/submit")
    public String submitReview(@ModelAttribute ReviewSubmissionDTO submission, Authentication authentication) {
        // 1. Lấy UserDetails từ authentication
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        Long userId = userDetails.getUserId(); // Lấy ID thay vì ép kiểu cả Object

        // 2. Gọi Service với đúng các tham số Long, Long, Long
        reviewService.processReviewResponse(
            userId, 
            submission.getQuestionId(), 
            submission.getSelectedOptionId()
        );

        return "redirect:/review/suggestions?success";
    }

    @GetMapping("/session/start")
    public String startReviewSession(@RequestParam Long questionId, Model model) {
        // Lấy DTO để hiển thị lên giao diện
        ReviewQuestionDTO questionDTO = reviewService.getQuestionForReview(questionId);
        model.addAttribute("question", questionDTO);
        
        // Tạo object rỗng để hứng dữ liệu khi người dùng chọn đáp án và submit
        model.addAttribute("submission", new ReviewSubmissionDTO());
        
        return "review/review-session"; 
    }
}