package com.quizptit.community.service.impl;

import com.quizptit.community.dto.QuestionPostRequest;
import com.quizptit.community.dto.QuestionPostResponse;
import com.quizptit.community.entity.Comment;
import com.quizptit.community.entity.PostLike;
import com.quizptit.community.entity.QuestionPost;
import com.quizptit.community.exception.ResourceNotFoundException;
import com.quizptit.community.repository.CommentRepository;
import com.quizptit.community.repository.ModerationRecordRepository;
import com.quizptit.community.repository.PostLikeRepository;
import com.quizptit.community.repository.QuestionPostRepository;
import com.quizptit.community.service.ModerationRecordService;
import com.quizptit.community.service.QuestionPostService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import com.quizptit.content.repository.TopicRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.springframework.data.domain.Pageable;
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
                .likeCount(0)
                .themeColor(request.getThemeColor() != null ? request.getThemeColor() : "#ffffff")
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

    @Transactional
    public void deletePost(Long postId, Long userId, String userRole) {
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy bài viết!"));

        // Kiểm tra: Nếu là Admin HOẶC là chủ bài viết (userId trùng nhau) thì mới được xóa
        if (userRole.equals("ADMIN") || post.getUser().getUserId().equals(userId)) {
            post.setStatus("DELETED");
            questionPostRepository.save(post);
        } else {
            throw new RuntimeException("Bạn không có quyền xóa bài này!");
        }
    }

    @Override
    public List<QuestionPostResponse> getPublicPosts() {
        try {
            // Gọi hàm đã có OrderBy mới ở đây
            return questionPostRepository.findByStatusOrderByCreatedAtDesc("VISIBLE").stream()
                    .map(this::mapToResponse)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
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
        // 1. Tìm bài viết, nếu không thấy thì ném lỗi 404 (chứ không phải 500)
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bài viết ID: " + postId));

        // 2. Logic kiểm tra quyền xem bài (Giữ nguyên ý tưởng Facebook của bạn)
        boolean isAdmin = "ADMIN".equals(role);
        boolean isOwner = (currentUserId != null && post.getUser() != null)
                && post.getUser().getUserId().equals(currentUserId);
        boolean isVisible = "VISIBLE".equals(post.getStatus());

        // Nếu không phải ADMIN, cũng không phải chủ bài, mà bài lại bị ẨN/XÓA -> Chặn
        if (!isAdmin && !isOwner && !isVisible) {
            throw new ResourceNotFoundException("Bài viết này hiện không khả dụng.");
        }

        // 3. Trả về DTO
        return mapToResponse(post);
    }

    public List<QuestionPostResponse> getPosts(Long topicId, int page) {
        int size = 5; // Cố định mỗi lần lấy 5 bài
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
        // 1. Tìm bài viết
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bài viết ID: " + postId));

        // 2. Tìm ID Admin từ Email
        User admin = userRepository.findByEmail(adminEmail)
                .orElseThrow(() -> new RuntimeException("Admin không tồn tại"));

        // 3. Cập nhật trạng thái bài viết
        post.setStatus(newStatus);
        questionPostRepository.save(post);

        // 4. LOGIC ĐỒNG BỘ: Nếu bài viết bị ẨN hoặc XÓA, ta cũng xử lý các comment bên trong
        // Điều này ngăn việc comment của bài đã bị xóa vẫn xuất hiện ở nơi khác (nếu có)
        if ("DELETED".equals(newStatus) || "HIDDEN".equals(newStatus)) {
            try {
                // Bạn có thể viết query này trong CommentRepository:
                // @Modifying @Query("UPDATE Comment c SET c.status = :status WHERE c.questionPost.questionPostId = :postId")
                commentRepository.updateStatusByPostId(postId, newStatus);
            } catch (Exception e) {
                System.err.println("Lưu ý: Bài viết không có comment hoặc lỗi đồng bộ comment: " + e.getMessage());
            }
        }

        // 5. Lưu nhật ký kiểm duyệt (Moderation Log)
        try {
            // Sử dụng hàm log dành cho Post mà bạn đã có (hoặc tương tự hàm log comment)
            moderationRecordService.logPostModeration(postId, admin.getUserId(), newStatus, reason);
        } catch (Exception e) {
            System.err.println("LOG_ERROR: Không thể lưu nhật ký kiểm duyệt bài viết: " + e.getMessage());
        }
    }

    @Transactional
    @Override
    public void toggleLike(Long postId, Long userId) {
        // 1. Tìm User và Bài viết
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Người dùng không tồn tại"));
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Bài viết không tồn tại"));

        // 2. Kiểm tra xem User này đã Like bài này chưa
        Optional<PostLike> existingLike = postLikeRepository.findByUserAndPost(user, post);

        if (existingLike.isPresent()) {
            // Nếu ĐÃ LIKE rồi -> Giờ bấm lại là UNLIKE (Xóa bản ghi)
            postLikeRepository.delete(existingLike.get());

            // Giảm số lượng like trong bảng QuestionPost (nếu bạn có dùng field likeCount)
            int currentLikes = post.getLikeCount() != null ? post.getLikeCount() : 0;
            post.setLikeCount(Math.max(0, currentLikes - 1));
        } else {
            // Nếu CHƯA LIKE -> Tạo mới bản ghi Like
            PostLike newLike = new PostLike();
            newLike.setUser(user);
            newLike.setPost(post);
            postLikeRepository.save(newLike);

            // Tăng số lượng like
            int currentLikes = post.getLikeCount() != null ? post.getLikeCount() : 0;
            post.setLikeCount(currentLikes + 1);
        }

        // 3. Lưu lại trạng thái bài viết
        questionPostRepository.save(post);
    }

    @Override
    public List<String> getLikersByPostId(Long postId) {
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Bài viết không tồn tại"));

        // Lấy từ bảng PostLike, sau đó map sang tên User
        return postLikeRepository.findByPost(post).stream()
                .map(like -> like.getUser().getFullName())
                .collect(Collectors.toList());
    }

    // Hàm phụ để map Entity sang DTO, tránh lặp code
    private QuestionPostResponse mapToResponse(QuestionPost post) {
        if (post == null) return null;

        // Tìm tên Topic an toàn
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

        // TÍNH TOÁN COMMENT COUNT AN TOÀN
        long totalComments = 0;
        try {
            if (post.getComments() != null) {
                // Chỉ đếm những comment không bị DELETED (Giữ lại HIDDEN theo yêu cầu Facebook của bạn)
                totalComments = post.getComments().stream()
                        .filter(c -> c != null && !"DELETED".equals(c.getStatus()))
                        .count();
            }
        } catch (Exception e) {
            System.err.println("Lỗi đếm comment: " + e.getMessage());
        }

        // Build Response
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