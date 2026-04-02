package com.quizptit.content.repository;

import com.quizptit.content.entity.AnswerOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnswerOptionRepository extends JpaRepository<AnswerOption, Long> {
    List<AnswerOption> findByQuestionQuestionId(Long questionId);
    
    boolean existsByQuestionQuestionIdAndOptionLabel(Long questionId, String optionLabel);
    
    boolean existsByQuestionQuestionIdAndOptionLabelAndOptionIdNot(Long questionId, String optionLabel, Long optionId);
}
