package com.quizptit.content.repository;

<<<<<<< HEAD
import org.springframework.data.jpa.repository.JpaRepository;

import com.quizptit.content.entity.Subject;

public interface SubjectRepository extends JpaRepository<Subject, Long> {

=======
import com.quizptit.content.entity.Subject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SubjectRepository extends JpaRepository<Subject, Long> {
    
    boolean existsBySubjectName(String subjectName);
    
    boolean existsBySubjectNameAndSubjectIdNot(String subjectName, Long subjectId);
    
    @Query("SELECT s FROM Subject s WHERE LOWER(s.subjectName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(s.description) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<Subject> searchSubjects(String keyword, Pageable pageable);

    Page<Subject> findByIsActive(Boolean isActive, Pageable pageable);
    
    @Query("SELECT s FROM Subject s WHERE (:keyword IS NULL OR :keyword = '' OR LOWER(s.subjectName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(s.description) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND (:isActive IS NULL OR s.isActive = :isActive)")
    Page<Subject> searchSubjectsWithStatus(String keyword, Boolean isActive, Pageable pageable);

    List<Subject> findByIsActiveTrue();
>>>>>>> parent of e92009e (Revert "Merge remote-tracking branch 'origin/feat/long' into lam")
}
