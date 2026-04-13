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

    @GetMapping("/questions")
    public String getPublicPosts(@RequestParam(required = false) Long topicId,
                                 @RequestParam(defaultValue = "0") int page,
                                 Model model) {

        List<QuestionPostResponse> posts = postService.getPosts(topicId, page);
        model.addAttribute("posts", posts);
        model.addAttribute("topics", topicRepository.findAll());
        model.addAttribute("currentTopic", topicId);
        model.addAttribute("currentPage", page);

        return "community/question-list";
    }

    @GetMapping("/questions/create")
    public String showCreateForm(Model model) {
        model.addAttribute("postRequest", new QuestionPostRequest());
        List<Topic> topics = topicRepository.findAll();
        model.addAttribute("topics", topics);
        return "community/question-create";
    }

    @PostMapping("/questions/create")
    public String createPost(@Valid @ModelAttribute("postRequest") QuestionPostRequest request,
                             Principal principal) {

        String currentUsername = principal.getName();

        User currentUser = userRepository.findByEmail(currentUsername)
                .orElseThrow(() -> new RuntimeException("Người dùng không tồn tại"));

        postService.createPost(request, currentUser.getUserId(), request.getTopicId());
        return "redirect:/community/questions";
    }

    @GetMapping("/questions/{postId}")
    public String getPostById(@PathVariable Long postId,
                              @RequestParam(required = false) Long commentId,
                              Model model,
                              Principal principal) {
        String role = "GUEST";
        Long userId = null;

        if (principal != null) {
            User user = userRepository.findByEmail(principal.getName()).orElse(null);
            if (user != null) {
                userId = user.getUserId();
                String rawRole = user.getRole().getRoleName().name();
                role = rawRole.replace("ROLE_", "");
            }
        }

        QuestionPostResponse post = postService.getPostById(postId, userId, role);
        model.addAttribute("post", post);

        var comments = "ADMIN".equals(role)
                ? commentService.getAllCommentsByPost(postId)
                : commentService.getPublicCommentsByPost(postId);

        model.addAttribute("comments", comments != null ? comments : new java.util.ArrayList<>());
        model.addAttribute("targetCommentId", commentId);

        return "community/question-detail";
    }

    @GetMapping("/questions/{postId}/edit")
    public String showEditForm(@PathVariable Long postId, Model model, Principal principal) {
        QuestionPostResponse post = postService.getPostById(postId, 0L, "GUEST");

        QuestionPostRequest editRequest = new QuestionPostRequest();
        editRequest.setTitle(post.getTitle());
        editRequest.setContent(post.getContent());

        model.addAttribute("postRequest", editRequest);
        model.addAttribute("postId", postId);
        return "community/question-edit";
    }

    @PostMapping("/questions/{postId}/edit")
    public String updatePost(@PathVariable Long postId,
                             @Valid @ModelAttribute("postRequest") QuestionPostRequest request,
                             Principal principal) {
        String email = principal.getName();
        User currentUser = userRepository.findByEmail(email).orElseThrow();

        postService.updatePost(postId, request, currentUser.getUserId());
        return "redirect:/community/questions";
    }

    @PostMapping("/questions/{postId}/delete")
    public String deletePost(@PathVariable Long postId, Principal principal) {
        String email = principal.getName();

        User currentUser = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        postService.deletePost(postId, currentUser.getUserId(), currentUser.getRole().getRoleName().name());
        return "redirect:/community/questions";
    }

    @PostMapping("/questions/{postId}/like")
    @ResponseBody
    public ResponseEntity<?> toggleLike(@PathVariable Long postId, Principal principal) {
        String email = principal.getName();

        User currentUser = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        postService.toggleLike(postId, currentUser.getUserId());
        return ResponseEntity.ok("Toggled Like Successfully");
    }

    @GetMapping("/questions/{postId}/likers")
    @ResponseBody
    public ResponseEntity<List<String>> getLikers(@PathVariable Long postId) {
        List<String> likers = postService.getLikersByPostId(postId);
        return ResponseEntity.ok(likers);
    }

    @GetMapping("/admin/questions")
    public String getAllPostsForAdmin(Model model) {
        List<QuestionPostResponse> allPosts = postService.getAllPostsForAdmin();
        model.addAttribute("allPosts", allPosts);
        return "community/admin/question-list";
    }

    @PostMapping("/admin/questions/{postId}/hide")
    public String hidePostAdmin(@PathVariable Long postId,
                                Principal principal,
                                @RequestParam String reason) {
        postService.updatePostStatus(postId, "HIDDEN", reason, principal.getName());
        return "redirect:/community/questions";
    }

    @PostMapping("/admin/questions/{postId}/delete")
    public String deletePostAdmin(@PathVariable Long postId,
                                  Principal principal,
                                  @RequestParam String reason) {
        postService.updatePostStatus(postId, "HIDDEN", reason, principal.getName());
        return "redirect:/community/questions";
    }
}