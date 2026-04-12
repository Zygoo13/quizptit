package com.quizptit.attempt.scheduler;

import com.quizptit.attempt.entity.Attempt;
import com.quizptit.attempt.entity.enums.AttemptStatus;
import com.quizptit.attempt.repository.AttemptRepository;
import com.quizptit.attempt.service.AttemptService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Component
@RequiredArgsConstructor
@Slf4j
public class AttemptScheduler {

    private final AttemptRepository attemptRepository;
    private final AttemptService attemptService;

    @Scheduled(fixedRate = 120000)
    @Transactional
    public void autoSubmitExpiredAttempts() {
        log.info("Bắt đầu quét các bài thi đã quá hạn...");

        List<Attempt> inProgressAttempts = attemptRepository.findByStatus(AttemptStatus.IN_PROGRESS);
        LocalDateTime now = LocalDateTime.now();
        int count = 0;

        for (Attempt attempt : inProgressAttempts) {
            try {
                LocalDateTime startTime = attempt.getStartedAt();
                int durationMinutes = attempt.getQuiz().getDurationMinutes();
                LocalDateTime endTime = startTime.plusMinutes(durationMinutes);

                if (now.isAfter(endTime.plusSeconds(30))) {
                    log.info("Phát hiện bài thi hết hạn: ID={}, User={}, Quiz={}",
                            attempt.getAttemptId(), attempt.getUser().getUserId(), attempt.getQuiz().getTitle());

                    attemptService.submitAttempt(attempt.getAttemptId());
                    count++;
                }
            } catch (Exception e) {
                log.error("Lỗi khi tự động nộp bài thi ID={}: {}", attempt.getAttemptId(), e.getMessage());
            }
        }

        if (count > 0) {
            log.info("Hoàn tất tự động nộp {} bài thi.", count);
        }
    }
}
