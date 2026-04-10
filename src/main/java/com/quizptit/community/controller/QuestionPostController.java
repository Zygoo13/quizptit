package com.quizptit.community.controller;

import com.quizptit.community.dto.QuestionPostRequest;
import com.quizptit.community.dto.QuestionPostResponse;
import com.quizptit.community.service.CommentService;
import com.quizptit.community.service.QuestionPostService;
import com.quizptit.content.entity.Topic;
import com.quizptit.content.repository.TopicRepository;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/community")
@RequiredArgsConstructor
public class QuestionPostController {

    private final QuestionPostService postService;
    private final UserRepository userRepository;
    private final TopicRepository topicRepository;
    private final CommentService commentService;

    // --- PHẦN CHO SINH VIÊN (USER) ---

    // BR-40: Lấy danh sách bài viết hiển thị (VISIBLE) cho người dùng
    @GetMapping("/questions")
    public String getPublicPosts(
            @RequestParam(required = false) Long topicId,
            @RequestParam(defaultValue = "0") int page,
            Model model) {

        List<QuestionPostResponse> posts = postService.getPosts(topicId, page);
        model.addAttribute("posts", posts);
        model.addAttribute("topics", topicRepository.findAll()); // Để hiện menu lọc
        model.addAttribute("currentTopic", topicId);
        model.addAttribute("currentPage", page);

        return "community/question-list";
    }

    // BR-33, 34, 35: Hiển thị form để Sinh viên chuẩn bị đăng bài mới
    @GetMapping("/questions/create")
    public String showCreateForm(Model model) {
        // 1. Gửi object để hứng data từ form
        model.addAttribute("postRequest", new QuestionPostRequest());

        // 2. QUAN TRỌNG: Phải gửi danh sách topics sang thì HTML mới có dữ liệu để lặp
        // Nhớ inject TopicRepository vào Controller này nhé
        List<Topic> topics = topicRepository.findAll();
        model.addAttribute("topics", topics);

        return "community/question-create"; // Đường dẫn file html của bạn
    }

    @PostMapping("/questions/create")
    public String createPost(@Valid @ModelAttribute("postRequest") QuestionPostRequest request,
                             Principal principal) {

        // 1. Lấy email người dùng hiện tại
        String currentUsername = principal.getName();

        // 2. Tìm User
        User currentUser = userRepository.findByEmail(currentUsername)
                .orElseThrow(() -> new RuntimeException("Người dùng không tồn tại"));

        // 3. Gọi Service lưu bài viết
        // Truyền request (có chứa themeColor và topicId) cùng với UserId
        postService.createPost(request, currentUser.getUserId(), request.getTopicId());

        return "redirect:/community/questions";
    }

    // 2. Sửa lại hàm xem chi tiết (Dòng 82)
    @GetMapping("/questions/{postId}")
    public String getPostById(@PathVariable Long postId, Model model) {
        // Lấy thông tin bài viết
        QuestionPostResponse post = postService.getPostById(postId, 0L, "GUEST");
        model.addAttribute("post", post);

        // --- KHÚC NÀY QUAN TRỌNG ĐỂ HẾT LỖI 500 ---
        // Lấy danh sách bình luận của bài viết này
        var comments = commentService.getPublicCommentsByPost(postId);

        // Nếu danh sách null thì gán list rỗng để HTML không bị lỗi .size()
        if (comments == null) {
            comments = new java.util.ArrayList<>();
        }

        model.addAttribute("comments", comments);
        // ------------------------------------------

        return "community/question-detail";
    }

    // BR-37: Hiển thị Form cập nhật bài viết (Chỉ chính chủ)
    @GetMapping("/questions/{postId}/edit")
    public String showEditForm(@PathVariable Long postId, Model model, Principal principal) {
        // Lấy dữ liệu bài viết hiện tại (currentUserId tạm để 0 vì Service của bạn sẽ check sau)
        QuestionPostResponse post = postService.getPostById(postId, 0L, "GUEST");

        // Đưa dữ liệu vào object 'postRequest' để Thymeleaf bind vào form
        QuestionPostRequest editRequest = new QuestionPostRequest();
        editRequest.setTitle(post.getTitle());
        editRequest.setContent(post.getContent());

        model.addAttribute("postRequest", editRequest);
        model.addAttribute("postId", postId); // Giữ ID để biết là đang sửa bài nào
        return "community/question-edit";
    }

    // Xử lý lưu bài viết sau khi sửa
    @PostMapping("/questions/{postId}/edit")
    public String updatePost(@PathVariable Long postId,
                             @Valid @ModelAttribute("postRequest") QuestionPostRequest request,
                             Principal principal) {
        // Lấy ID người dùng hiện tại (Như cách bạn vừa làm ở hàm Create)
        String email = principal.getName();
        User currentUser = userRepository.findByEmail(email).orElseThrow();

        postService.updatePost(postId, request, currentUser.getUserId());
        return "redirect:/community/questions";
    }

    // BR-37, 38: Xử lý Xóa bài viết
    @PostMapping("/questions/{postId}/delete")
    public String deletePost(@PathVariable Long postId, Principal principal) {
        // 1. Lấy email từ người đang đăng nhập
        String email = principal.getName();

        // 2. Tìm User để lấy ID và Role (Vì Service của bạn đang yêu cầu 2 cái này)
        User currentUser = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // 3. Truyền ĐÚNG 3 tham số vào Service
        postService.deletePost(postId, currentUser.getUserId(), currentUser.getRole().getRoleName().name());

        return "redirect:/community/questions";
    }

    @PostMapping("/questions/{postId}/like")
    @ResponseBody // Trả về text/json thay vì chuyển trang (để giữ nguyên giao diện Facebook)
    public ResponseEntity<?> toggleLike(@PathVariable Long postId, Principal principal) {
        // 1. Lấy email từ người đang đăng nhập
        String email = principal.getName();

        // 2. Tìm User để lấy ID (Vì Service của bạn đang dùng userId)
        User currentUser = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // 3. Gọi Service xử lý logic Like/Unlike
        postService.toggleLike(postId, currentUser.getUserId());

        // 4. Trả về thông báo thành công
        return ResponseEntity.ok("Toggled Like Successfully");
    }

    @GetMapping("/questions/{postId}/likers")
    @ResponseBody
    public ResponseEntity<List<String>> getLikers(@PathVariable Long postId) {
        // Gọi Service lấy danh sách tên
        List<String> likers = postService.getLikersByPostId(postId);
        return ResponseEntity.ok(likers);
    }

    // --- PHẦN CHO QUẢN TRỊ VIÊN (ADMIN) ---

    // BR-41: Lấy tất cả bài viết dành cho Admin (Bao gồm cả bài bị ẩn/xóa)
    @GetMapping("/admin/questions")
    public String getAllPostsForAdmin(Model model) {
        List<QuestionPostResponse> allPosts = postService.getAllPostsForAdmin();
        model.addAttribute("allPosts", allPosts);
        return "community/admin/question-list";
    }

    @PostMapping("/admin/questions/{postId}/hide")
    public String hidePostAdmin(
            @PathVariable Long postId,
            Principal principal,
            @RequestParam String reason) {

        // Gọi service xử lý ẩn bài
        postService.updatePostStatus(postId, "HIDDEN", reason, principal.getName());

        return "redirect:/community/questions";
    }

    @PostMapping("/admin/questions/{postId}/delete")
    public String deletePostAdmin(
            @PathVariable Long postId,
            Principal principal,
            @RequestParam String reason) {

        // Gọi service xử lý xóa bài (Xóa mềm)
        postService.updatePostStatus(postId, "DELETED", reason, principal.getName());

        return "redirect:/community/questions";
    }
}