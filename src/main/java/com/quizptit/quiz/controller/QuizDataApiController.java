package com.quizptit.quiz.controller;

import com.quizptit.content.entity.Question;
import com.quizptit.content.entity.Topic;
import com.quizptit.content.repository.QuestionRepository;
import com.quizptit.content.repository.TopicRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/quiz-data")
@RequiredArgsConstructor
public class QuizDataApiController {

    private final TopicRepository topicRepository;
    private final QuestionRepository questionRepository;

    @GetMapping("/topics")
    public ResponseEntity<?> getTopicsBySubject(@RequestParam Long subjectId) {
        List<Topic> topics = topicRepository.findBySubject_SubjectId(subjectId);

        List<Map<String, Object>> response = topics.stream().map(t -> {
            Map<String, Object> map = new HashMap<>();
            map.put("topicId", t.getTopicId());
            map.put("topicName", t.getTopicName());
            return map;
        }).collect(Collectors.toList());

        return ResponseEntity.ok(response);
    }

    @GetMapping("/questions")
    public ResponseEntity<?> getQuestionsByTopic(@RequestParam Long topicId) {
        List<Question> questions = questionRepository.findByTopic_TopicId(topicId);

        List<Map<String, Object>> response = questions.stream().map(q -> {
            Map<String, Object> map = new HashMap<>();
            map.put("questionId", q.getQuestionId());
            map.put("content", q.getContent());
            return map;
        }).collect(Collectors.toList());

        return ResponseEntity.ok(response);
    }
}