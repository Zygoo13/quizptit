package com.quizptit.community.service.impl;

import com.quizptit.community.entity.QuestionPost;
import com.quizptit.community.repository.QuestionPostRepository;
import com.quizptit.community.service.QuestionPostService;
import com.quizptit.user.repository.UserRepository; // Repository của bạn Long
import com.quizptit.content.repository.TopicRepository; // Giả định Repository Topic của team
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class QuestionPostServiceImpl implements QuestionPostService {

    private final QuestionPostRepository questionPostRepository;
    private final UserRepository userRepository;
    private final TopicRepository topicRepository;

    @Override
    @Transactional
    public QuestionPost createPost(QuestionPost post, Long userId, Long topicId) {
        // BR-33: Kiểm tra người dùng (phải tồn tại/đã đăng nhập)
        var user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("BR-33: Bạn cần đăng nhập để thực hiện thao tác này"));

        // BR-35: Phải gắn với đúng một chủ đề
        var topic = topicRepository.findById(topicId)
                .orElseThrow(() -> new RuntimeException("BR-35: Câu hỏi phải thuộc một chủ đề hợp lệ"));

        // BR-34: Kiểm tra tiêu đề và nội dung
        if (post.getTitle() == null || post.getTitle().trim().isEmpty() ||
                post.getContent() == null || post.getContent().trim().isEmpty()) {
            throw new RuntimeException("BR-34: Tiêu đề và nội dung không được để trống");
        }

        post.setUser(user);
        post.setTopicId(topicId); // Hoặc post.setTopic(topic) nếu bạn đã sửa Entity
        post.setStatus("VISIBLE"); // BR-39: Mặc định hiển thị
        post.setViewCount(0);

        return questionPostRepository.save(post);
    }

    @Override
    public List<QuestionPost> getPublicPosts() {
        // BR-40: Chỉ lấy những bài không bị ẩn hoặc xóa (VISIBLE)
        return questionPostRepository.findByStatus("VISIBLE");
    }

    @Override
    @Transactional
    public void deletePost(Long postId, Long userId, String userRole) {
        QuestionPost post = questionPostRepository.findById(postId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy bài viết"));

        // BR-37: Người dùng chỉ xóa được nội dung của mình, trừ Admin
        boolean isOwner = post.getUser().getUserId().equals(userId);
        boolean isAdmin = "ADMIN".equals(userRole);

        if (!isOwner && !isAdmin) {
            throw new RuntimeException("BR-37: Bạn không có quyền xóa bài viết này");
        }

        questionPostRepository.delete(post);
    }
}