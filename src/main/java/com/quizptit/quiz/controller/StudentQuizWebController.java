package com.quizptit.quiz.controller;

import com.quizptit.attempt.entity.Attempt;
import com.quizptit.attempt.entity.enums.AttemptStatus;
import com.quizptit.common.util.CurrentUserUtils;
import com.quizptit.content.entity.Subject;
import com.quizptit.quiz.entity.Quiz;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/quizzes") 
@RequiredArgsConstructor
public class StudentQuizWebController {

    private final com.quizptit.quiz.service.QuizService quizService;
    private final com.quizptit.attempt.service.AttemptService attemptService;
    private final com.quizptit.content.service.SubjectService subjectService;

    @GetMapping("/attempts/{attemptId}/result")
    public String showQuizResult(@PathVariable Long attemptId, Model model) {
        Long userId = CurrentUserUtils.getCurrentUserId();

        Attempt attempt = attemptService.getAttemptResultDetail(attemptId, userId);

        model.addAttribute("attempt", attempt);
        return "quiz/student/quiz-result";
    }

    @GetMapping("/attempts/{attemptId}/review")
    public String reviewQuizAttempt(@PathVariable Long attemptId, Model model) {
        Long userId = CurrentUserUtils.getCurrentUserId();

        Attempt attempt = attemptService.getAttemptResultDetail(attemptId, userId);
        java.util.Map<Long, com.quizptit.attempt.entity.AttemptAnswer> answerMap = attemptService.getAnswersMapForAttempt(attemptId);

        model.addAttribute("attempt", attempt);
        model.addAttribute("answerMap", answerMap);
        return "quiz/student/quiz-review";
    }

    @GetMapping("/{quizId}")
    public String showQuizDetail(@PathVariable Long quizId, Model model, RedirectAttributes redirectAttributes) {
        Quiz quiz = quizService.getQuizDetail(quizId);
        
        if (!quiz.getIsPublished() && !CurrentUserUtils.isAdmin()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Đề thi này hiện đang tạm ẩn.");
            return "redirect:/quizzes";
        }
        
        model.addAttribute("quiz", quiz);
        return "quiz/student/quiz-detail";
    }

    @GetMapping("/random")
    public String showRandomQuizPage(Model model) {
        List<Subject> subjects = subjectService.getActiveSubjects();
        model.addAttribute("subjects", subjects);
        return "quiz/student/quiz-random";
    }

    @GetMapping("/attempts/{attemptId}/take")
    public String takeQuiz(@PathVariable Long attemptId, Model model) {
        Attempt attempt = attemptService.getAttemptById(attemptId);
        if (attempt.getStatus() != AttemptStatus.IN_PROGRESS) {
            return "redirect:/quizzes/attempts/" + attemptId + "/result";
        }
        model.addAttribute("remainingSeconds", attemptService.getRemainingSeconds(attempt));
        model.addAttribute("attempt", attempt);
        return "quiz/student/quiz-take";
    }

    @GetMapping("/history")
    public String showQuizHistoryPage() {
        return "quiz/student/quiz-history";
    }

    @GetMapping
    public String showStudentQuizList(
            @RequestParam(required = false) Long subjectId,
            Model model) {

        List<Quiz> availableQuizzes = quizService.getAvailableQuizzes(subjectId);
        List<Subject> subjects = subjectService.getActiveSubjects();
        model.addAttribute("quizzes", availableQuizzes);
        model.addAttribute("subjects", subjects);
        model.addAttribute("selectedSubjectId", subjectId);
        return "quiz/student/quiz-list";
    }
}