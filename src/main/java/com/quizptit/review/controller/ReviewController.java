package com.quizptit.review.controller;

import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.review.dto.ReviewSuggestionDTO;
import com.quizptit.review.service.ReviewService;
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

    // Mở trang làm bài ôn tập
    @GetMapping("/session/start")
    public String startReviewSession(@RequestParam Long questionId, Model model) {
        ReviewQuestionDTO question = reviewService.getQuestionForReview(questionId);
        model.addAttribute("question", question);
        model.addAttribute("submission", new ReviewSubmissionDTO());
        return "review/review-session"; // Tên file HTML sẽ tạo ở bước 3.3
    }

    // Xử lý nộp bài
    @PostMapping("/session/submit")
    public String submitReview(@ModelAttribute ReviewSubmissionDTO submission) {
        // 1. Lấy thông tin User đang đăng nhập
        User user = currentUserUtils.getCurrentUser();

        // 2. Xử lý logic đúng/sai và cập nhật trí nhớ
        reviewService.processReviewResponse(user, submission);

        // 3. Chuyển hướng về trang danh sách gợi ý kèm thông báo thành công
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