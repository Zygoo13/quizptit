package com.quizptit.common.exception;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.LinkedHashMap;
import java.util.Map;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    // =========================
    // Resource Not Found
    // =========================
    @ExceptionHandler(ResourceNotFoundException.class)
    public String handleResourceNotFound(
            ResourceNotFoundException ex,
            HttpServletRequest request,
            Model model
    ) {
        log.warn("Resource not found: {}", ex.getMessage());

        model.addAttribute("errorTitle", "Not Found");
        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("path", request.getRequestURI());

        return "error/404";
    }

    // =========================
    // Business Exception
    // =========================
    @ExceptionHandler(BusinessException.class)
    public String handleBusinessException(
            BusinessException ex,
            HttpServletRequest request,
            Model model
    ) {
        log.warn("Business exception: {}", ex.getMessage());

        model.addAttribute("errorTitle", "Bad Request");
        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("path", request.getRequestURI());

        return "error/400";
    }

    // =========================
    // Access Denied (custom)
    // =========================
    @ExceptionHandler(AccessDeniedBusinessException.class)
    public String handleAccessDeniedBusinessException(
            AccessDeniedBusinessException ex,
            HttpServletRequest request,
            Model model
    ) {
        log.warn("Access denied: {}", ex.getMessage());

        model.addAttribute("errorTitle", "Forbidden");
        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("path", request.getRequestURI());

        return "error/403";
    }

    // =========================
    // Validation Exception (Form)
    // =========================
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public String handleValidationException(
            MethodArgumentNotValidException ex,
            HttpServletRequest request,
            Model model
    ) {
        Map<String, String> validationErrors = new LinkedHashMap<>();

        ex.getBindingResult().getFieldErrors().forEach(fieldError ->
                validationErrors.put(fieldError.getField(), fieldError.getDefaultMessage())
        );

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
    public String handleFileStorageException(
            FileStorageException ex,
            HttpServletRequest request,
            Model model
    ) {
        log.warn("File error: {}", ex.getMessage());

        model.addAttribute("errorTitle", "File Error");
        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("path", request.getRequestURI());

        return "error/400";
    }

    // =========================
    // Illegal Argument
    // =========================
    @ExceptionHandler(IllegalArgumentException.class)
    public String handleIllegalArgumentException(
            IllegalArgumentException ex,
            HttpServletRequest request,
            Model model
    ) {
        log.warn("Illegal argument: {}", ex.getMessage());

        model.addAttribute("errorTitle", "Bad Request");
        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("path", request.getRequestURI());

        return "error/400";
    }

    // =========================
    // Generic Exception
    // =========================
    @ExceptionHandler(Exception.class)
    public String handleGenericException(
            Exception ex,
            HttpServletRequest request,
            Model model
    ) {
        log.error("Unexpected error", ex);

        model.addAttribute("errorTitle", "Internal Server Error");
        model.addAttribute("errorMessage", "An unexpected error occurred.");
        model.addAttribute("path", request.getRequestURI());

        return "error/500";
    }
}