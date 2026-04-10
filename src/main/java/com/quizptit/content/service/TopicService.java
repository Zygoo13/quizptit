package com.quizptit.content.service;

import com.quizptit.content.entity.Topic;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface TopicService {
    Page<Topic> searchTopics(Long subjectId, String keyword, Boolean isActive, Pageable pageable);

    List<Topic> getActiveTopicsBySubject(Long subjectId);

    Topic getTopicById(Long topicId);

    Topic createTopic(Topic topic);

    Topic updateTopic(Long topicId, Topic topicDetails);

    void toggleStatus(Long topicId);

    List<Topic> getAllTopics();
}
