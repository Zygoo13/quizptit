package com.quizptit.content.controller;

import com.quizptit.common.constant.DifficultyLevel;
import com.quizptit.common.constant.QuestionStatus;
import com.quizptit.content.entity.AnswerOption;
import com.quizptit.content.entity.Question;
import com.quizptit.content.entity.Topic;
import com.quizptit.content.service.QuestionService;
import com.quizptit.content.service.SubjectService;
import com.quizptit.content.service.TopicService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequestMapping("/admin/questions")
public class AdminQuestionController {

    @Autowired
    private QuestionService questionService;

    @Autowired
    private SubjectService subjectService;

    @Autowired
    private TopicService topicService;

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String listQuestions(@RequestParam(required = false) Long subjectId,
                                @RequestParam(required = false) Long topicId,
                                @RequestParam(required = false) QuestionStatus status,
                                @RequestParam(required = false) DifficultyLevel difficulty,
                                @RequestParam(required = false) String keyword,
                                @RequestParam(defaultValue = "0") int page,
                                Model model) {
        Page<Question> questions = questionService.searchQuestions(subjectId, topicId, status, difficulty, keyword, PageRequest.of(page, 50));
        model.addAttribute("questions", questions);
        model.addAttribute("subjects", subjectService.getAllSubjects());
        model.addAttribute("topics", topicService.searchTopics(null, null, true, PageRequest.of(0, 1000)).getContent());
        model.addAttribute("subjectId", subjectId);
        model.addAttribute("topicId", topicId);
        model.addAttribute("status", status);
        model.addAttribute("difficulty", difficulty);
        model.addAttribute("keyword", keyword);
        return "content/admin/question-list";
    }

    @GetMapping("/create")
    public String showCreateForm(@RequestParam(required = false) Long topicId, Model model) {
        Question question = new Question();
        if (topicId != null) {
            Topic topic = new Topic();
            topic.setTopicId(topicId);
            question.setTopic(topic);
        }
        
        String[] labels = {"A", "B", "C", "D"};
        for (String label : labels) {
            AnswerOption option = new AnswerOption();
            option.setOptionLabel(label);
            question.getOptions().add(option);
        }

        model.addAttribute("question", question);
        model.addAttribute("subjects", subjectService.getAllSubjects());
        model.addAttribute("topics", topicService.searchTopics(null, null, true, PageRequest.of(0, 1000)).getContent());
        model.addAttribute("difficultyLevels", DifficultyLevel.values());
        model.addAttribute("questionStatuses", QuestionStatus.values());
        return "content/admin/question-create";
    }

    @PostMapping("/create")
    public String createQuestion(@ModelAttribute Question question, 
                                 @RequestParam(value = "correctOptionIndex", required = false) Integer correctOptionIndex,
                                 Principal principal, RedirectAttributes redirectAttributes) {
        try {
            // Simplified user retrieval
            String email = principal != null ? principal.getName() : "admin@quizptit.com";
            User user = userRepository.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));
            
            if (correctOptionIndex != null && question.getOptions() != null) {
                for (int i = 0; i < question.getOptions().size(); i++) {
                    question.getOptions().get(i).setIsCorrect(i == correctOptionIndex);
                }
            }

            questionService.createQuestion(question, user.getUserId());
            redirectAttributes.addFlashAttribute("successMessage", "Tạo câu hỏi thành công");
            return "redirect:/admin/questions";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/questions/create";
        }
    }

    @GetMapping("/{questionId}/edit")
    public String showEditForm(@PathVariable Long questionId, Model model) {
        Question question = questionService.getQuestionById(questionId);
        model.addAttribute("question", question);
        model.addAttribute("subjects", subjectService.getAllSubjects());
        model.addAttribute("topics", topicService.searchTopics(null, null, true, PageRequest.of(0, 1000)).getContent());
        model.addAttribute("difficultyLevels", DifficultyLevel.values());
        model.addAttribute("questionStatuses", QuestionStatus.values());
        return "content/admin/question-edit";
    }

    @PostMapping("/{questionId}/edit")
    public String updateQuestion(@PathVariable Long questionId, @ModelAttribute Question question,
                                 @RequestParam(value = "correctOptionIndex", required = false) Integer correctOptionIndex,
                                 RedirectAttributes redirectAttributes) {
        try {
            if (correctOptionIndex != null && question.getOptions() != null) {
                for (int i = 0; i < question.getOptions().size(); i++) {
                    question.getOptions().get(i).setIsCorrect(i == correctOptionIndex);
                }
            }
            questionService.updateQuestion(questionId, question);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật câu hỏi thành công");
            return "redirect:/admin/questions";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/questions/" + questionId + "/edit";
        }
    }

    @PostMapping("/{questionId}/change-status")
    public String changeStatus(@PathVariable Long questionId, @RequestParam QuestionStatus status, RedirectAttributes redirectAttributes) {
        questionService.changeStatus(questionId, status);
        redirectAttributes.addFlashAttribute("successMessage", "Đổi trạng thái thành công");
        return "redirect:/admin/questions";
    }
}
