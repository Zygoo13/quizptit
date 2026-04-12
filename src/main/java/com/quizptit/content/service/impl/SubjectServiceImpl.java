package com.quizptit.content.service.impl;

import com.quizptit.content.entity.Subject;
import com.quizptit.content.repository.SubjectRepository;
import com.quizptit.content.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.quizptit.content.entity.Topic;
import com.quizptit.content.repository.TopicRepository;
import com.quizptit.content.entity.Question;
import com.quizptit.content.repository.QuestionRepository;

@Service
public class SubjectServiceImpl implements SubjectService {

    @Autowired
    private SubjectRepository subjectRepository;

    @Autowired
    private TopicRepository topicRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Override
    public Page<Subject> searchSubjects(String keyword, Boolean isActive, Pageable pageable) {
        return subjectRepository.searchSubjectsWithStatus(keyword, isActive, pageable);
    }

    @Override
    public List<Subject> getActiveSubjects() {
        return subjectRepository.findByIsActiveTrue();
    }

    @Override
    public Subject getSubjectById(Long subjectId) {
        return subjectRepository.findById(subjectId)
                .orElseThrow(() -> new RuntimeException("Subject not found"));
    }

    @Override
    public Subject createSubject(Subject subject) {
        if (subjectRepository.existsBySubjectName(subject.getSubjectName())) {
            throw new RuntimeException("Subject name already exists");
        }
        return subjectRepository.save(subject);
    }

    @Override
    public Subject updateSubject(Long subjectId, Subject subjectDetails) {
        if (subjectRepository.existsBySubjectNameAndSubjectIdNot(subjectDetails.getSubjectName(), subjectId)) {
            throw new RuntimeException("Subject name already exists");
        }
        Subject subject = getSubjectById(subjectId);
        subject.setSubjectName(subjectDetails.getSubjectName());
        subject.setDescription(subjectDetails.getDescription());
        subject.setIsActive(subjectDetails.getIsActive());
        return subjectRepository.save(subject);
    }

    @Override
    @Transactional
    public void toggleStatus(Long subjectId) {
        Subject subject = getSubjectById(subjectId);
        boolean newStatus = !subject.getIsActive();
        subject.setIsActive(newStatus);
        subjectRepository.save(subject);

        if (!newStatus) {
            List<Topic> topics = topicRepository.findBySubject_SubjectId(subjectId);
            for (Topic t : topics) {
                t.setIsActive(false);
                topicRepository.save(t);

                List<Question> questions = questionRepository.findByTopic_TopicId(t.getTopicId());
                for (Question q : questions) {
                    q.setStatus(com.quizptit.common.constant.QuestionStatus.HIDDEN);
                    questionRepository.save(q);
                }
            }
        } else {
            List<Topic> topics = topicRepository.findBySubject_SubjectId(subjectId);
            for (Topic t : topics) {
                t.setIsActive(true);
                topicRepository.save(t);

                List<Question> questions = questionRepository.findByTopic_TopicId(t.getTopicId());
                for (Question q : questions) {
                    q.setStatus(com.quizptit.common.constant.QuestionStatus.APPROVED);
                    questionRepository.save(q);
                }
            }
        }
    }

    @Override
    public List<Subject> getAllSubjects() {
        return subjectRepository.findAll();
    }

}
