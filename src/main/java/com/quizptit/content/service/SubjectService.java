package com.quizptit.content.service;

import com.quizptit.content.entity.Subject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface SubjectService {
    Page<Subject> searchSubjects(String keyword, Boolean isActive, Pageable pageable);

    List<Subject> getActiveSubjects();

    Subject getSubjectById(Long subjectId);

    Subject createSubject(Subject subject);

    Subject updateSubject(Long subjectId, Subject subjectDetails);

    void toggleStatus(Long subjectId);

    List<Subject> getAllSubjects();

}
