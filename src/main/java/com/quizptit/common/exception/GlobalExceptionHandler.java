package com.quizptit.common.exception;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Map;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    // =========================
    // Resource Not Found
    // =========================
    @ExceptionHandler(ResourceNotFoundException.class)
    public Object handleResourceNotFound(
            ResourceNotFoundException ex,
            HttpServletRequest request,
            Model model
    ) {
        log.warn("Resource not found: {}", ex.getMessage());

        if (isApiRequest(request)) {
            return buildApiError(HttpStatus.NOT_FOUND, ex.getMessage(), request);
        }

        model.addAttribute("errorTitle", "Not Found");
        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("path", request.getRequestURI());

        return "error/404";
    }

    // =========================
    // Business Exception
    // =========================
    @ExceptionHandler(BusinessException.class)
    public Object handleBusinessException(
            BusinessException ex,
            HttpServletRequest request,
            Model model
    ) {
        log.warn("Business exception: {}", ex.getMessage());

        if (isApiRequest(request)) {
            return buildApiError(HttpStatus.BAD_REQUEST, ex.getMessage(), request);
        }

        model.addAttribute("errorTitle", "Bad Request");
        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("path", request.getRequestURI());

        return "error/400";
    }

    // =========================
    // Access Denied (custom)
    // =========================
    @ExceptionHandler(AccessDeniedBusinessException.class)
    public Object handleAccessDeniedBusinessException(
            AccessDeniedBusinessException ex,
            HttpServletRequest request,
            Model model
    ) {
        log.warn("Access denied: {}", ex.getMessage());

        if (isApiRequest(request)) {
            return buildApiError(HttpStatus.FORBIDDEN, ex.getMessage(), request);
        }

        model.addAttribute("errorTitle", "Forbidden");
        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("path", request.getRequestURI());

        return "error/403";
    }

    // =========================
    // Validation Exception (Form)
    // =========================
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Object handleValidationException(
            MethodArgumentNotValidException ex,
            HttpServletRequest request,
            Model model
    ) {
        Map<String, String> validationErrors = new LinkedHashMap<>();

        ex.getBindingResult().getFieldErrors().forEach(fieldError ->
                validationErrors.put(fieldError.getField(), fieldError.getDefaultMessage())
        );

        if (isApiRequest(request)) {
            ApiError apiError = ApiError.builder()
                    .timestamp(LocalDateTime.now())
                    .status(HttpStatus.BAD_REQUEST.value())
                    .error(HttpStatus.BAD_REQUEST.getReasonPhrase())
                    .message("Validation failed")
                    .path(request.getRequestURI())
                    .validationErrors(validationErrors)
                    .build();
            return new ResponseEntity<>(apiError, HttpStatus.BAD_REQUEST);
        }

        model.addAttribute("errorTitle", "Validation Error");
        model.addAttribute("errorMessage", "Validation failed.");
        model.addAttribute("validationErrors", validationErrors);
        model.addAttribute("path", request.getRequestURI());

        return "error/400";
    }

    // =========================
    // File Storage Exception
    // =========================
    @ExceptionHandler(FileStorageException.class)
    public Object handleFileStorageException(
            FileStorageException ex,
            HttpServletRequest request,
            Model model
    ) {
        log.warn("File error: {}", ex.getMessage());

        if (isApiRequest(request)) {
            return buildApiError(HttpStatus.BAD_REQUEST, ex.getMessage(), request);
        }

        model.addAttribute("errorTitle", "File Error");
        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("path", request.getRequestURI());

        return "error/400";
    }

    // =========================
    // Illegal Argument
    // =========================
    @ExceptionHandler(IllegalArgumentException.class)
    public Object handleIllegalArgumentException(
            IllegalArgumentException ex,
            HttpServletRequest request,
            Model model
    ) {
        log.warn("Illegal argument: {}", ex.getMessage());

        if (isApiRequest(request)) {
            return buildApiError(HttpStatus.BAD_REQUEST, ex.getMessage(), request);
        }

        model.addAttribute("errorTitle", "Bad Request");
        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("path", request.getRequestURI());

        return "error/400";
    }

    // =========================
    // Generic Exception
    // =========================
    @ExceptionHandler(Exception.class)
    public Object handleGenericException(
            Exception ex,
            HttpServletRequest request,
            Model model
    ) {
        log.error("Unexpected error", ex);

        if (isApiRequest(request)) {
            return buildApiError(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage(), request);
        }

        model.addAttribute("errorTitle", "Internal Server Error");
        model.addAttribute("errorMessage", "An unexpected error occurred.");
        model.addAttribute("path", request.getRequestURI());

        return "error/500";
    }

    private boolean isApiRequest(HttpServletRequest request) {
        String path = request.getRequestURI();
        return path != null && path.startsWith("/api/");
    }

    private ResponseEntity<ApiError> buildApiError(HttpStatus status, String message, HttpServletRequest request) {
        ApiError apiError = ApiError.builder()
                .timestamp(LocalDateTime.now())
                .status(status.value())
                .error(status.getReasonPhrase())
                .message(message)
                .path(request.getRequestURI())
                .build();
        return new ResponseEntity<>(apiError, status);
    }
}