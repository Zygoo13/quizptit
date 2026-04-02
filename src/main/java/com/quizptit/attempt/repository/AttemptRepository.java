package com.quizptit.attempt.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.quizptit.attempt.entity.Attempt;

public interface AttemptRepository extends JpaRepository<Attempt, Long> {

}
