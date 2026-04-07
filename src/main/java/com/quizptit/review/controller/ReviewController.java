package com.quizptit.review.controller;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.quizptit.auth.security.CustomUserDetails;
import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.content.service.SubjectService;
import com.quizptit.progress.dto.QuestionReviewDTO;
import com.quizptit.progress.service.ProgressService;
import com.quizptit.review.dto.ReviewSubjectDTO;
import com.quizptit.review.dto.ReviewSubmissionDTO;
import com.quizptit.review.dto.ReviewSuggestionDTO;
import com.quizptit.review.dto.ReviewQuestionDTO;
import com.quizptit.review.service.ReviewService;
import com.quizptit.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.security.Principal;

@Controller
@RequestMapping("/review")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;
    private final CurrentUserUtils currentUserUtils;
    private final ProgressService progressService;
    private final SubjectService subjectService;

    @GetMapping
    public String showReviewDashboard(Model model) {
        Long userId = CurrentUserUtils.getCurrentUserId();
        if (userId == null) return "redirect:/auth/login";

        List<ReviewSubjectDTO> subjects = reviewService.getSubjectsReviewStatus(userId);
        model.addAttribute("subjects", subjects);
        return "review/dashboard";
    }

    @GetMapping("/suggestions")
    public String viewReviewSuggestions(Authentication authentication, Model model) {
        // Lấy userId từ CustomUserDetails thay vì dùng CurrentUserUtils nếu class đó chưa ổn định
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        Long userId = userDetails.getUserId();

        List<ReviewSuggestionDTO> suggestions = reviewService.getReviewSuggestions(userId);
        model.addAttribute("suggestions", suggestions);
        
        return "review/suggestions";
    }

    // Xử lý nộp bài
   @PostMapping("/session/submit")
    public String submitReview(@ModelAttribute ReviewSubmissionDTO submission, Authentication authentication) {
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        
        // Gọi đúng 3 tham số Long, Long, Long như ReviewService yêu cầu
        reviewService.processReviewResponse(
            userDetails.getUserId(), 
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
    
    @GetMapping("/subject/{subjectId}")
    public String showQuestionsToReview(@PathVariable Long subjectId, Model model) {
        Long userId = CurrentUserUtils.getCurrentUserId();
        if (userId == null) return "redirect:/auth/login";

        List<QuestionReviewDTO> questions = reviewService.getQuestionsBySubject(userId, subjectId);
        String subjectName = subjectService.getSubjectById(subjectId).getSubjectName();

        model.addAttribute("questions", questions);
        model.addAttribute("subjectName", subjectName);
        return "review/question-list";
    }

    private Long getUserIdFromPrincipal(Principal principal) {
        if (principal == null) return 1L; // Trả về ID mặc định để test nếu chưa có login
        
        // Logic thực tế: Bạn nên inject UserRepository để tìm user theo email
        // String email = principal.getName();
        // return userRepository.findByEmail(email).getUserId();
        
        return 1L; 
    }
}