package com.quizptit.common.service;

import com.quizptit.common.config.FileStorageProperties;
import com.quizptit.common.exception.FileStorageException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Set;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class LocalFileStorageService implements FileStorageService {

    private static final Set<String> ALLOWED_CONTENT_TYPES = Set.of(
            "image/jpeg",
            "image/png",
            "image/gif",
            "image/webp"
    );

    private final FileStorageProperties fileStorageProperties;

    @Override
    public String storeImage(MultipartFile file, String subDirectory) {
        validateImage(file);

        try {
            Path uploadRoot = Paths.get(fileStorageProperties.getUploadDir()).toAbsolutePath().normalize();
            Path targetDirectory = uploadRoot.resolve(subDirectory).normalize();

            Files.createDirectories(targetDirectory);

            String extension = extractExtension(file.getOriginalFilename());
            String generatedFileName = UUID.randomUUID() + extension;

            Path targetFile = targetDirectory.resolve(generatedFileName).normalize();

            Files.copy(file.getInputStream(), targetFile, StandardCopyOption.REPLACE_EXISTING);

            return "/uploads/" + subDirectory + "/" + generatedFileName;
        } catch (IOException ex) {
            throw new FileStorageException("Failed to store file.", ex);
        }
    }

    private void validateImage(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new FileStorageException("Image file is required.");
        }

        if (file.getSize() > fileStorageProperties.getMaxImageSizeBytes()) {
            throw new FileStorageException("Image size exceeds the allowed limit.");
        }

        String contentType = file.getContentType();
        if (!StringUtils.hasText(contentType) || !ALLOWED_CONTENT_TYPES.contains(contentType)) {
            throw new FileStorageException("Only JPG, PNG, GIF, and WEBP images are allowed.");
        }
    }

    private String extractExtension(String originalFilename) {
        if (!StringUtils.hasText(originalFilename) || !originalFilename.contains(".")) {
            throw new FileStorageException("Invalid file name.");
        }

        String extension = originalFilename.substring(originalFilename.lastIndexOf(".")).toLowerCase();

        if (!Set.of(".jpg", ".jpeg", ".png", ".gif", ".webp").contains(extension)) {
            throw new FileStorageException("Invalid image extension.");
        }

        return extension;
    }
}