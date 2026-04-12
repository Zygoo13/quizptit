package com.quizptit.community.repository;

import com.quizptit.community.entity.PostLike;
import com.quizptit.community.entity.QuestionPost;
import com.quizptit.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PostLikeRepository extends JpaRepository<PostLike, Long> {

    Optional<PostLike> findByUserAndPost(User user, QuestionPost post);

    List<PostLike> findByPost(QuestionPost post);
}
