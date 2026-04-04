package com.quizptit.community.service.impl;

import com.quizptit.community.dto.QuestionPostRequest;
import com.quizptit.community.dto.QuestionPostResponse;
import com.quizptit.community.entity.QuestionPost;
import com.quizptit.community.exception.ResourceNotFoundException;
import com.quizptit.community.repository.QuestionPostRepository;
import com.quizptit.community.service.QuestionPostService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import com.quizptit.content.repository.TopicRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class QuestionPostServiceImpl implements QuestionPostService {

    private final QuestionPostRepository questionPostRepository;
    private final UserRepository userRepository;
    private final TopicRepository topicRepository;

    public QuestionPostServiceImpl(QuestionPostRepository questionPostRepository,
                                   UserRepository userRepository,
                                   TopicRepository topicRepository) {
        this.questionPostRepository = questionPostRepository;
        this.userRepository = userRepository;
        this.topicRepository = topicRepository;
    }

    @Override
    @Transactional
    public QuestionPostResponse createPost(QuestionPostRequest request, Long userId, Long topicId) {
        // 1. Tìm User (Dùng Custom Exception)
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Người dùng không tồn tại ID: " + userId));

        // 2. Check Topic
        if (topicId == null || !topicRepository.existsById(topicId)) {
            throw new ResourceNotFoundException("Chủ đề không hợp lệ ID: " + topicId);
        }

        // 3. Map từ Request -> Entity
        QuestionPost post = QuestionPost.builder()
                .title(request.getTitle())
                .content(request.getContent())
                .user(user)
                .topicId(topicId)
                .status("VISIBLE")
                .viewCount(0)
                .build();

        QuestionPost savedPost = questionPostRepository.save(post);

        // 4. Trả về Response DTO
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

    @Override
    @Transactional
    public void deletePost(Long postId, Long userId, String userRole) {
        // 1. Tìm bài viết
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bài viết"));

        // 2. Logic Check quyền (BR-37 & BR-38)
        boolean isOwner = post.getUser().getUserId().equals(userId);
        boolean isAdmin = "ADMIN".equals(userRole);

        // Nếu KHÔNG PHẢI chủ bài viết VÀ CŨNG KHÔNG PHẢI Admin thì chặn
        if (!isOwner && !isAdmin) {
            throw new SecurityException("Bạn không có quyền xóa bài viết này!");
        }

        // 3. THỰC HIỆN XÓA MỀM (SOFT DELETE)
        // Thay vì questionPostRepository.delete(post);
        post.setStatus("DELETED");
        questionPostRepository.save(post);

        // Gợi ý: Bạn có thể lưu thêm log vào bảng ModerationRecord ở đây nếu muốn Admin biết ai đã xóa
    }

    @Override
    public List<QuestionPostResponse> getPublicPosts() {
        return questionPostRepository.findByStatus("VISIBLE").stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<QuestionPostResponse> getAllPostsForAdmin() {
        return questionPostRepository.findAll().stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public QuestionPostResponse getPostById(Long postId, Long currentUserId, String role) {
        // 1. Tìm bài viết trong DB
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bài viết hoặc bài viết đã bị gỡ bỏ."));

        // 2. Kiểm tra điều kiện hiển thị
        boolean isAdmin = "ADMIN".equals(role);
        boolean isOwner = post.getUser().getUserId().equals(currentUserId);
        boolean isVisible = "VISIBLE".equals(post.getStatus());

        // LOGIC CHẶN: Nếu không phải Admin, không phải chủ bài, mà bài lại đang bị Ẩn/Xóa -> Chặn luôn
        if (!isAdmin && !isOwner && !isVisible) {
            throw new ResourceNotFoundException("Bài viết này hiện không khả dụng.");
        }

        return mapToResponse(post);
    }

    @Override
    @Transactional
    public void updatePostStatus(Long postId, String newStatus, String reason, Long adminId) {
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bài viết"));
        post.setStatus(newStatus);
        questionPostRepository.save(post);
        // Sau này sẽ gọi thêm ModerationRecordService để lưu reason tại đây
    }

    // Hàm phụ để map Entity sang DTO, tránh lặp code
    private QuestionPostResponse mapToResponse(QuestionPost post) {
        return QuestionPostResponse.builder()
                .questionPostId(post.getQuestionPostId())
                .title(post.getTitle())
                .content(post.getContent())
                .viewCount(post.getViewCount())
                .status(post.getStatus())
                .topicId(post.getTopicId())
                .userId(post.getUser().getUserId())
                .fullName(post.getUser().getFullName())
                .createdAt(post.getCreatedAt())
                .updatedAt(post.getUpdatedAt())
                .build();
    }
}