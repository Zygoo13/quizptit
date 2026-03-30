package com.quizptit.common.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Getter
@Setter
@ConfigurationProperties(prefix = "app.file")
public class FileStorageProperties {

    private String uploadDir = "uploads";
    private long maxImageSizeBytes = 5 * 1024 * 1024;
}