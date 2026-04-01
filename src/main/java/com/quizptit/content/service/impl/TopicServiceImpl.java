package com.quizptit.content.service.impl;

import com.quizptit.content.entity.Topic;
import com.quizptit.content.repository.SubjectRepository;
import com.quizptit.content.repository.TopicRepository;
import com.quizptit.content.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TopicServiceImpl implements TopicService {

    @Autowired
    private TopicRepository topicRepository;

    @Autowired
    private SubjectRepository subjectRepository;

    @Override
    public Page<Topic> searchTopics(Long subjectId, String keyword, Boolean isActive, Pageable pageable) {
        return topicRepository.searchTopics(subjectId, keyword, isActive, pageable);
    }

    @Override
    public List<Topic> getActiveTopicsBySubject(Long subjectId) {
        return topicRepository.findBySubjectSubjectIdAndIsActiveTrueOrderByOrderNoAsc(subjectId);
    }

    @Override
    public Topic getTopicById(Long topicId) {
        return topicRepository.findById(topicId)
                .orElseThrow(() -> new RuntimeException("Topic not found"));
    }

    @Override
    public Topic createTopic(Topic topic) {
        if (topicRepository.existsBySubjectSubjectIdAndTopicName(topic.getSubject().getSubjectId(), topic.getTopicName())) {
            throw new RuntimeException("Topic name already exists for this subject");
        }
        return topicRepository.save(topic);
    }

    @Override
    public Topic updateTopic(Long topicId, Topic topicDetails) {
        if (topicRepository.existsBySubjectSubjectIdAndTopicNameAndTopicIdNot(
                topicDetails.getSubject().getSubjectId(), topicDetails.getTopicName(), topicId)) {
            throw new RuntimeException("Topic name already exists for this subject");
        }
        Topic topic = getTopicById(topicId);
        topic.setTopicName(topicDetails.getTopicName());
        topic.setDescription(topicDetails.getDescription());
        topic.setOrderNo(topicDetails.getOrderNo());
        topic.setIsActive(topicDetails.getIsActive());
        
        // Subject may be moved
        if (topicDetails.getSubject() != null && !topic.getSubject().getSubjectId().equals(topicDetails.getSubject().getSubjectId())) {
             topic.setSubject(subjectRepository.findById(topicDetails.getSubject().getSubjectId()).orElseThrow());
        }
        return topicRepository.save(topic);
    }

    @Override
    public void toggleStatus(Long topicId) {
        Topic topic = getTopicById(topicId);
        topic.setIsActive(!topic.getIsActive());
        topicRepository.save(topic);
    }
}
