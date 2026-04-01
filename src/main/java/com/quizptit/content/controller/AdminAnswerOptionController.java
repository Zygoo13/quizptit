package com.quizptit.content.controller;

import com.quizptit.content.entity.AnswerOption;
import com.quizptit.content.entity.Question;
import com.quizptit.content.service.AnswerOptionService;
import com.quizptit.content.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/questions/{questionId}/options")
public class AdminAnswerOptionController {

    @Autowired
    private AnswerOptionService answerOptionService;

    @Autowired
    private QuestionService questionService;

    @GetMapping
    public String manageOptions(@PathVariable Long questionId, Model model) {
        Question question = questionService.getQuestionById(questionId);
        List<AnswerOption> options = answerOptionService.getOptionsByQuestionId(questionId);
        model.addAttribute("question", question);
        model.addAttribute("options", options);
        model.addAttribute("newOption", new AnswerOption());
        return "content/admin/answer-option-manage";
    }

    @PostMapping("/create")
    public String createOption(@PathVariable Long questionId, @ModelAttribute AnswerOption option, RedirectAttributes redirectAttributes) {
        try {
            Question question = new Question();
            question.setQuestionId(questionId);
            option.setQuestion(question);
            answerOptionService.createOption(option);
            redirectAttributes.addFlashAttribute("successMessage", "Thêm đáp án thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/questions/" + questionId + "/options";
    }

    @PostMapping("/{optionId}/edit")
    public String updateOption(@PathVariable Long questionId, @PathVariable Long optionId, @ModelAttribute AnswerOption option, RedirectAttributes redirectAttributes) {
        try {
            Question question = new Question();
            question.setQuestionId(questionId);
            option.setQuestion(question);
            answerOptionService.updateOption(optionId, option);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật đáp án thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/questions/" + questionId + "/options";
    }

    @PostMapping("/{optionId}/delete")
    public String deleteOption(@PathVariable Long questionId, @PathVariable Long optionId, RedirectAttributes redirectAttributes) {
        try {
            answerOptionService.deleteOption(optionId);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa đáp án thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/questions/" + questionId + "/options";
    }
}
