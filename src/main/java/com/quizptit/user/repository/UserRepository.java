package com.quizptit.user.repository;

import com.quizptit.common.constant.UserStatus;
import com.quizptit.user.entity.User;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    @EntityGraph(attributePaths = {"role"})
    Optional<User> findByEmail(String email);

    @EntityGraph(attributePaths = {"role"})
    Optional<User> findByUserId(Long userId);

    @Override
    @EntityGraph(attributePaths = {"role"})
    List<User> findAll();

    @EntityGraph(attributePaths = {"role"})
    List<User> findByEmailContainingIgnoreCaseOrFullNameContainingIgnoreCase(
            String emailKeyword,
            String nameKeyword
    );

    @EntityGraph(attributePaths = {"role"})
    List<User> findByStatus(UserStatus status);

    @EntityGraph(attributePaths = {"role"})
    List<User> findByEmailContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndStatus(
            String emailKeyword,
            String nameKeyword,
            UserStatus status
    );

    boolean existsByEmail(String email);
}