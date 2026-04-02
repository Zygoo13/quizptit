package com.quizptit.community.service.impl;

import com.quizptit.community.entity.Comment;
import com.quizptit.community.entity.QuestionPost;
import com.quizptit.community.repository.CommentRepository;
import com.quizptit.community.repository.QuestionPostRepository;
import com.quizptit.community.service.CommentService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {

    private final CommentRepository commentRepository;
    private final QuestionPostRepository questionPostRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional
    public Comment addComment(Long postId, Comment comment, Long userId) {
        // BR-33: Kiểm tra người dùng đã đăng nhập
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("BR-33: Bạn cần đăng nhập để bình luận"));

        // BR-36: Kiểm tra bài viết tồn tại để gắn bình luận vào
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new RuntimeException("BR-36: Bài viết không tồn tại"));

        comment.setUser(user);
        comment.setQuestionPost(post);
        comment.setStatus("VISIBLE"); // Mặc định hiển thị

        return commentRepository.save(comment);
    }

    @Override
    public List<Comment> getCommentsByPost(Long postId) {
        // BR-40: Sinh viên chỉ xem được comment không bị ẩn (Logic này có thể thêm vào Repository)
        return commentRepository.findByQuestionPost_QuestionPostId(postId);
    }

    @Override
    @Transactional
    public void deleteComment(Long commentId, Long userId, String userRole) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new RuntimeException("Bình luận không tồn tại"));

        // BR-37: Kiểm tra quyền sở hữu hoặc quyền Admin
        boolean isOwner = comment.getUser().getUserId().equals(userId);
        boolean isAdmin = "ADMIN".equals(userRole);

        if (!isOwner && !isAdmin) {
            throw new RuntimeException("BR-37: Bạn không có quyền xóa bình luận này");
        }

        commentRepository.delete(comment);
    }
}