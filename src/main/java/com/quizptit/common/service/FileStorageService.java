package com.quizptit.common.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileStorageService {

    String storeImage(MultipartFile file, String subDirectory);
}