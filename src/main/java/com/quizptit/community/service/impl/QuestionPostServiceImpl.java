package com.quizptit.community.service.impl;

import com.quizptit.community.dto.QuestionPostRequest;
import com.quizptit.community.dto.QuestionPostResponse;
import com.quizptit.community.entity.PostLike;
import com.quizptit.community.entity.QuestionPost;
import com.quizptit.community.exception.ResourceNotFoundException;
import com.quizptit.community.repository.CommentRepository;
import com.quizptit.community.repository.PostLikeRepository;
import com.quizptit.community.repository.QuestionPostRepository;
import com.quizptit.community.service.ModerationRecordService;
import com.quizptit.community.service.QuestionPostService;
import com.quizptit.content.repository.TopicRepository;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class QuestionPostServiceImpl implements QuestionPostService {

    private final QuestionPostRepository questionPostRepository;
    private final UserRepository userRepository;
    private final TopicRepository topicRepository;
    private final PostLikeRepository postLikeRepository;
    private final CommentRepository commentRepository;
    private final ModerationRecordService moderationRecordService;

    public QuestionPostServiceImpl(QuestionPostRepository questionPostRepository,
                                   UserRepository userRepository,
                                   TopicRepository topicRepository,
                                   PostLikeRepository postLikeRepository,
                                   CommentRepository commentRepository,
                                   ModerationRecordService moderationRecordService) {
        this.questionPostRepository = questionPostRepository;
        this.userRepository = userRepository;
        this.topicRepository = topicRepository;
        this.postLikeRepository = postLikeRepository;
        this.commentRepository = commentRepository;
        this.moderationRecordService = moderationRecordService;
    }

    @Override
    @Transactional
    public QuestionPostResponse createPost(QuestionPostRequest request, Long userId, Long topicId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Người dùng không tồn tại ID: " + userId));

        if (topicId == null || !topicRepository.existsById(topicId)) {
            throw new ResourceNotFoundException("Chủ đề không hợp lệ ID: " + topicId);
        }

        QuestionPost post = QuestionPost.builder()
                .title(request.getTitle())
                .content(request.getContent())
                .user(user)
                .topicId(topicId)
                .status("VISIBLE")
                .viewCount(0)
                .likeCount(0)
                .commentCount(0)
                .themeColor(request.getThemeColor() != null ? request.getThemeColor() : "#ffffff")
                .build();

        QuestionPost savedPost = questionPostRepository.save(post);
        return mapToResponse(savedPost);
    }

    @Override
    @Transactional
    public QuestionPostResponse updatePost(Long postId, QuestionPostRequest request, Long userId) {
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bài viết ID: " + postId));

        if (!post.getUser().getUserId().equals(userId)) {
            throw new RuntimeException("Bạn không có quyền chỉnh sửa bài viết này");
        }

        post.setTitle(request.getTitle());
        post.setContent(request.getContent());

        return mapToResponse(questionPostRepository.save(post));
    }

    @Transactional
    public void deletePost(Long postId, Long userId, String userRole) {
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy bài viết!"));

        if (userRole.equals("ADMIN") || post.getUser().getUserId().equals(userId)) {
            post.setStatus("HIDDEN");
            questionPostRepository.save(post);
        } else {
            throw new RuntimeException("Bạn không có quyền xóa bài này!");
        }
    }

    @Override
    public List<QuestionPostResponse> getPublicPosts() {
        return questionPostRepository.findByStatusOrderByCreatedAtDesc("VISIBLE").stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<QuestionPostResponse> getAllPostsForAdmin() {
        List<QuestionPost> posts = questionPostRepository.findAllByOrderByCreatedAtDesc();

        return posts.stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public QuestionPostResponse getPostById(Long postId, Long currentUserId, String role) {
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bài viết ID: " + postId));

        boolean isAdmin = "ADMIN".equals(role);
        boolean isOwner = (currentUserId != null && post.getUser() != null)
                && post.getUser().getUserId().equals(currentUserId);
        boolean isVisible = "VISIBLE".equals(post.getStatus());

        if (!isAdmin && !isOwner && !isVisible) {
            throw new ResourceNotFoundException("Bài viết này hiện không khả dụng.");
        }

        return mapToResponse(post);
    }

    public List<QuestionPostResponse> getPosts(Long topicId, int page) {
        int size = 5;
        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());

        Page<QuestionPost> postPage;
        if (topicId != null && topicId > 0) {
            postPage = questionPostRepository.findByTopicIdAndStatus(topicId, "VISIBLE", pageable);
        } else {
            postPage = questionPostRepository.findByStatus("VISIBLE", pageable);
        }

        return postPage.getContent().stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void updatePostStatus(Long postId, String newStatus, String reason, String adminEmail) {
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bài viết ID: " + postId));

        User admin = userRepository.findByEmail(adminEmail)
                .orElseThrow(() -> new ResourceNotFoundException("Admin không tồn tại với email: " + adminEmail));

        String normalizedStatus = normalizePostStatus(newStatus);
        String action = mapModerationAction(normalizedStatus);

        post.setStatus(normalizedStatus);
        questionPostRepository.saveAndFlush(post);

        if ("HIDDEN".equalsIgnoreCase(normalizedStatus) || "DELETED".equalsIgnoreCase(normalizedStatus)) {
            try {
                commentRepository.updateStatusByPostId(postId, "HIDDEN");
            } catch (Exception e) {
                System.err.println("Lỗi đồng bộ comment: " + e.getMessage());
            }
        }

        try {
            moderationRecordService.logPostModeration(postId, admin.getUserId(), action, reason);
        } catch (Exception e) {
            System.err.println("LOG_ERROR: Không thể lưu nhật ký: " + e.getMessage());
        }
    }

    @Transactional
    @Override
    public void toggleLike(Long postId, Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Người dùng không tồn tại"));
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Bài viết không tồn tại"));

        Optional<PostLike> existingLike = postLikeRepository.findByUserAndPost(user, post);

        if (existingLike.isPresent()) {
            postLikeRepository.delete(existingLike.get());
            int currentLikes = post.getLikeCount() != null ? post.getLikeCount() : 0;
            post.setLikeCount(Math.max(0, currentLikes - 1));
        } else {
            PostLike newLike = new PostLike();
            newLike.setUser(user);
            newLike.setPost(post);
            postLikeRepository.save(newLike);

            int currentLikes = post.getLikeCount() != null ? post.getLikeCount() : 0;
            post.setLikeCount(currentLikes + 1);
        }

        questionPostRepository.save(post);
    }

    @Override
    public List<String> getLikersByPostId(Long postId) {
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Bài viết không tồn tại"));

        return postLikeRepository.findByPost(post).stream()
                .map(like -> like.getUser().getFullName())
                .collect(Collectors.toList());
    }

    private String normalizePostStatus(String status) {
        if (status == null || status.isBlank()) {
            return "HIDDEN";
        }

        String value = status.trim().toUpperCase();

        if ("VISIBLE".equals(value)) {
            return "VISIBLE";
        }

        if ("HIDDEN".equals(value) || "DELETED".equals(value) || "DELETE".equals(value)) {
            return "HIDDEN";
        }

        return "HIDDEN";
    }

    private String mapModerationAction(String status) {
        if (status == null || status.isBlank()) {
            return "HIDE";
        }

        String value = status.trim().toUpperCase();

        if ("VISIBLE".equals(value)) {
            return "RESTORE";
        }
        if ("DELETED".equals(value) || "DELETE".equals(value)) {
            return "DELETE";
        }
        if ("HIDDEN".equals(value)) {
            return "HIDE";
        }
        return "HIDE";
    }

    private QuestionPostResponse mapToResponse(QuestionPost post) {
        if (post == null) return null;

        String tName = "Chung";
        try {
            if (post.getTopicId() != null) {
                tName = topicRepository.findById(post.getTopicId())
                        .map(t -> t.getTopicName())
                        .orElse("Chung");
            }
        } catch (Exception e) {
            System.err.println("Lỗi lấy Topic: " + e.getMessage());
        }

        long totalComments = 0;
        try {
            if (post.getComments() != null) {
                totalComments = post.getComments().stream()
                        .filter(c -> c != null && "VISIBLE".equals(c.getStatus()))
                        .count();
            }
        } catch (Exception e) {
            System.err.println("Lỗi đếm comment: " + e.getMessage());
        }

        return QuestionPostResponse.builder()
                .questionPostId(post.getQuestionPostId())
                .title(post.getTitle())
                .content(post.getContent())
                .topicName(tName)
                .status(post.getStatus())
                .topicId(post.getTopicId())
                .createdAt(post.getCreatedAt())
                .updatedAt(post.getUpdatedAt())
                .likeCount(post.getLikeCount() != null ? post.getLikeCount() : 0)
                .commentCount(totalComments)
                .themeColor(post.getThemeColor() != null ? post.getThemeColor() : "#ffffff")
                .userId(post.getUser() != null ? post.getUser().getUserId() : null)
                .fullName(post.getUser() != null ? post.getUser().getFullName() : "Người dùng ẩn danh")
                .email(post.getUser() != null ? post.getUser().getEmail() : "N/A")
                .build();
    }
}