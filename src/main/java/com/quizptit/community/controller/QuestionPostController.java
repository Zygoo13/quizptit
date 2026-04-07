package com.quizptit.community.controller;

import com.quizptit.community.dto.QuestionPostRequest;
import com.quizptit.community.dto.QuestionPostResponse;
import com.quizptit.community.service.QuestionPostService;
import com.quizptit.user.entity.User;
import com.quizptit.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
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

    // --- PHẦN CHO SINH VIÊN (USER) ---

    // BR-40: Lấy danh sách bài viết hiển thị (VISIBLE) cho người dùng
    @GetMapping("/questions")
    public String getPublicPosts(Model model) {
        List<QuestionPostResponse> posts = postService.getPublicPosts();
        model.addAttribute("posts", posts);
        return "community/question-list";
    }

    // BR-33, 34, 35: Hiển thị form để Sinh viên chuẩn bị đăng bài mới
    @GetMapping("/questions/create")
    public String showCreateForm(Model model) {
        model.addAttribute("postRequest", new QuestionPostRequest());
        return "community/question-create";
    }

    @PostMapping("/questions/create")
    public String createPost(@Valid @ModelAttribute("postRequest") QuestionPostRequest request,
                             Principal principal) { // <--- Spring tự tiêm thông tin người dùng vào đây

        // 1. Lấy Username (thường là Email) của người đang đăng nhập
        String currentUsername = principal.getName();

        // 2. Tìm User trong DB dựa trên Username/Email
        // Bạn cần inject UserRepository hoặc UserService vào Controller này nhé
        User currentUser = userRepository.findByEmail(currentUsername)
                .orElseThrow(() -> new RuntimeException("Chưa đăng nhập hoặc User không tồn tại"));

        // 3. Lấy ID chuẩn từ User đã tìm được (Ví dụ của Quang sẽ là 3)
        Long currentUserId = currentUser.getUserId();

        // 4. Gọi Service để lưu với ID "xịn"
        // Giả sử Topic mặc định là 1, hoặc bạn có thể lấy topicId từ Request/Param
        postService.createPost(request, currentUserId, 1L);

        return "redirect:/community/questions";
    }

    // Xem chi tiết 1 bài viết (Hỗ trợ hiển thị trang chi tiết)
    @GetMapping("/questions/{postId}")
    public String getPostById(@PathVariable Long postId, Model model) {
        // Truyền tham số an toàn để tránh NullPointerException trong Service
        QuestionPostResponse post = postService.getPostById(postId, 0L, "GUEST");
        model.addAttribute("post", post);
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

    // --- PHẦN CHO QUẢN TRỊ VIÊN (ADMIN) ---

    // BR-41: Lấy tất cả bài viết dành cho Admin (Bao gồm cả bài bị ẩn/xóa)
    @GetMapping("/admin/questions")
    public String getAllPostsForAdmin(Model model) {
        List<QuestionPostResponse> allPosts = postService.getAllPostsForAdmin();
        model.addAttribute("allPosts", allPosts);
        return "community/admin/question-list";
    }
}