package com.quizptit.community.service;

import com.quizptit.community.dto.CommentRequest;
import com.quizptit.community.dto.CommentResponse;
import com.quizptit.community.entity.Comment;

import jakarta.validation.Valid;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface CommentService {

    CommentResponse addComment(Long postId, Long userId, CommentRequest request);

    List<CommentResponse> getPublicCommentsByPost(Long postId);

    void deleteComment(Long commentId, Long userId, String userRole);

    CommentResponse updateComment(Long commentId, CommentRequest request, String email);

    void updateCommentStatus(Long commentId, String newStatus, String reason, Long adminId);

    @Transactional
    void syncCommentCount(Long postId);

    // Sửa void thành CommentResponse
    CommentResponse addCommentByEmail(Long postId, String email, CommentRequest request);

    void deleteCommentByEmail(Long commentId, String email);

    Optional<Comment> findById(Long id);

    void update(Long id, Comment comment);

    List<CommentResponse> getAllCommentsForAdmin();

    List<CommentResponse> getAllCommentsByPost(Long postId);

}