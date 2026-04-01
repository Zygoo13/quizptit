package com.quizptit.content.controller;

import com.quizptit.content.entity.Subject;
import com.quizptit.content.entity.Topic;
import com.quizptit.content.service.SubjectService;
import com.quizptit.content.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class TopicController {

    @Autowired
    private TopicService topicService;

    @Autowired
    private SubjectService subjectService;

    @GetMapping("/subjects/{subjectId}/topics")
    public String listTopics(@PathVariable Long subjectId, Model model) {
        Subject subject = subjectService.getSubjectById(subjectId);
        List<Topic> topics = topicService.getActiveTopicsBySubject(subjectId);
        model.addAttribute("subject", subject);
        model.addAttribute("topics", topics);
        return "content/topic-list";
    }

    @GetMapping("/topics/{topicId}")
    public String topicDetail(@PathVariable Long topicId, Model model) {
        Topic topic = topicService.getTopicById(topicId);
        if (!topic.getIsActive() || !topic.getSubject().getIsActive()) {
            return "redirect:/subjects";
        }
        model.addAttribute("topic", topic);
        return "content/topic-detail";
    }
}
