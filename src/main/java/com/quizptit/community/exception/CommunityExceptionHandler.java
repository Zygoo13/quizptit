package com.quizptit.community.exception;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDateTime;

@RestControllerAdvice(basePackages = "com.quizptit.community") // <--- THÊM CÁI NÀY
@Order(1)
public class CommunityExceptionHandler {

    // Bắt lỗi ResourceNotFoundException (404)
    @ExceptionHandler(SecurityException.class)
    public ModelAndView handleSecurityException(SecurityException ex, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("message", ex.getMessage()); // "Không có quyền xóa bài viết"
        mav.addObject("url", request.getRequestURL());
        mav.setViewName("error/403"); // Bạn cần tạo file templates/error/403.html
        return mav;
    }

    // Bắt các lỗi hệ thống còn lại (500) nhưng trả về JSON thay vì HTML
//    @ExceptionHandler(Exception.class)
//    public ResponseEntity<ErrorResponse> handleGlobalException(Exception ex, WebRequest request) {
//        ErrorResponse errorResponse = new ErrorResponse(
//                LocalDateTime.now(),
//                HttpStatus.INTERNAL_SERVER_ERROR.value(),
//                "Internal Server Error",
//                "Có lỗi hệ thống xảy ra: " + ex.getMessage(),
//                request.getDescription(false).replace("uri=", "")
//        );
//        return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
//    }
}