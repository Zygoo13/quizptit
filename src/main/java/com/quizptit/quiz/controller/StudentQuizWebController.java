package com.quizptit.quiz.controller;

import com.quizptit.attempt.entity.Attempt;
import com.quizptit.attempt.entity.enums.AttemptStatus;
import com.quizptit.attempt.service.impl.AttemptServiceImpl;
import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.quiz.entity.Quiz;
import com.quizptit.quiz.service.impl.QuizServiceImpl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/quizzes") // Đường dẫn cho sinh viên (không có chữ /admin)
@RequiredArgsConstructor
public class StudentQuizWebController {

    private final QuizServiceImpl quizService;
    private final AttemptServiceImpl attemptService;

    @GetMapping("/attempts/{attemptId}/result")
    public String showQuizResult(@PathVariable Long attemptId, Model model) {
        Long userId = CurrentUserUtils.getCurrentUserId();

        // Lấy chi tiết bài làm đã được chấm điểm từ Database
        Attempt attempt = attemptService.getAttemptResultDetail(attemptId, userId);

        model.addAttribute("attempt", attempt);
        return "quiz/student/quiz-result";
    }

    @GetMapping("/{quizId}")
    public String showQuizDetail(@PathVariable Long quizId, Model model) {
        Quiz quiz = quizService.getQuizDetail(quizId);
        model.addAttribute("quiz", quiz);
        return "quiz/student/quiz-detail";
    }

    // 2. VÀO PHÒNG THI (Đang làm bài)
    @GetMapping("/attempts/{attemptId}/take")
    public String takeQuiz(@PathVariable Long attemptId, Model model) {
        // Tạm giả sử bạn có hàm lấy Attempt theo ID trong AttemptService
        Attempt attempt = attemptService.getAttemptById(attemptId);
        if (attempt.getStatus() != AttemptStatus.IN_PROGRESS) {
            return "redirect:/quizzes/attempts/" + attemptId + "/result";
        }
        model.addAttribute("remainingSeconds", attemptService.getRemainingSeconds(attempt));
        model.addAttribute("attempt", attempt);
        return "quiz/student/quiz-take";
    }

    @GetMapping
    public String showStudentQuizList(
            @RequestParam(required = false) Long subjectId,
            Model model) {

        // 1. Lấy danh sách các đề thi ĐÃ XUẤT BẢN (có thể lọc theo môn học)
        List<Quiz> availableQuizzes = quizService.getAvailableQuizzes(subjectId);

        // 2. Ném vào hộp "quizzes" cho Thymeleaf in ra
        model.addAttribute("quizzes", availableQuizzes);

        // 3. Trả về file HTML của sinh viên
        return "quiz/student/quiz-list";
    }
}