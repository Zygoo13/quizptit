package com.quizptit.review.controller;

// 1. DTOs và Services nội bộ
import com.quizptit.auth.security.CustomUserDetails;
import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.content.service.SubjectService;
import com.quizptit.progress.dto.QuestionReviewDTO;
import com.quizptit.progress.service.ProgressService;
import com.quizptit.review.dto.*;
import com.quizptit.review.service.ReviewService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;

// 2. Exception (Rất quan trọng cho đoạn xử lý API)
import com.quizptit.common.exception.ResourceNotFoundException;

// 3. Lombok
import lombok.RequiredArgsConstructor;

// 4. Spring Framework & Web
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

// 5. Spring Security
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;

// 6. Java Utility
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
    private final UserRepository userRepository;

    @GetMapping
    public String showReviewDashboard(Model model, Authentication authentication) {
        // 1. Kiểm tra đăng nhập
        if (authentication == null || !(authentication.getPrincipal() instanceof CustomUserDetails)) {
            return "redirect:/auth/login";
        }

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        Long userId = userDetails.getUserId();

        // 2. Log để debug (Xem ở console IntelliJ)
        System.out.println("User " + userId + " đang truy cập dashboard");

        try {
            List<ReviewSubjectDTO> subjects = reviewService.getSubjectsReviewStatus(userId);
            model.addAttribute("subjects", subjects);
            return "review/dashboard";
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi chi tiết ra console để biết dòng nào hỏng
            return "error/500";
        }
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
    public String showReviewSession(@RequestParam Long questionId, 
                                @RequestParam(required = false) Long subjectId, 
                                Model model) {
        ReviewQuestionDTO question = reviewService.getQuestionForReview(questionId);
        model.addAttribute("question", question);
        model.addAttribute("subjectId", subjectId); // Truyền xuống HTML
        return "review/review-session"; 
    }

    @GetMapping("/session/next")
    public String getNextQuestion(@RequestParam Long subjectId) {
        Long userId = CurrentUserUtils.getCurrentUserId();
        // Lấy lại danh sách các câu cần ôn của môn này
        List<QuestionReviewDTO> remainingQuestions = reviewService.getQuestionsBySubject(userId, subjectId);
        
        if (remainingQuestions.isEmpty()) {
            // Nếu hết sạch câu rồi thì về trang danh sách môn
            return "redirect:/review/subject/" + subjectId + "?status=completed";
        }
        
        // Nếu còn, lấy ID của câu đầu tiên trong danh sách còn lại
        return "redirect:/review/session/start?questionId=" + remainingQuestions.get(0).getQuestionId() + "&subjectId=" + subjectId;
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

    @GetMapping("/subject/{subjectId}/all")
    public String startReviewAll(@PathVariable Long subjectId) {
        Long userId = CurrentUserUtils.getCurrentUserId();
        List<QuestionReviewDTO> questions = reviewService.getQuestionsBySubject(userId, subjectId);
        
        if (questions.isEmpty()) return "redirect:/review/subject/" + subjectId;

        // Truyền thêm subjectId để trang Session biết là đang làm theo mạch môn học
        return "redirect:/review/session/start?questionId=" + questions.get(0).getQuestionId() + "&subjectId=" + subjectId;
    }

    @PostMapping("/api/submit")
    @ResponseBody
    public ResponseEntity<ReviewResultResponse> submitReview(
            @RequestBody ReviewRequest request, 
            @AuthenticationPrincipal CustomUserDetails currentUser) { // Đổi UserDetails thành CustomUserDetails
        
        // Lấy trực tiếp userId từ session, không cần findByEmail nữa
        Long userId = currentUser.getUserId(); 

        ReviewResultResponse response = reviewService.processReviewResponse(
                userId, 
                request.getQuestionId(), 
                request.getOptionId()
        );
        
        return ResponseEntity.ok(response);
    }

    private Long getUserIdFromPrincipal(Principal principal) {
        if (principal == null) return 1L; // Trả về ID mặc định để test nếu chưa có login
        
        // Logic thực tế: Bạn nên inject UserRepository để tìm user theo email
        // String email = principal.getName();
        // return userRepository.findByEmail(email).getUserId();
        
        return 1L; 
    }
}