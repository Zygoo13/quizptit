package com.quizptit.content.service.impl;

import com.quizptit.content.entity.Subject;
import com.quizptit.content.repository.SubjectRepository;
import com.quizptit.content.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SubjectServiceImpl implements SubjectService {

    @Autowired
    private SubjectRepository subjectRepository;

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
    public void toggleStatus(Long subjectId) {
        Subject subject = getSubjectById(subjectId);
        subject.setIsActive(!subject.getIsActive());
        subjectRepository.save(subject);
    }

    @Override
    public List<Subject> getAllSubjects() {
        return subjectRepository.findAll();
    }

}
