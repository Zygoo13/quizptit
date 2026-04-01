package com.quizptit.content.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.quizptit.content.entity.Subject;

public interface SubjectRepository extends JpaRepository<Subject, Long> {

}
