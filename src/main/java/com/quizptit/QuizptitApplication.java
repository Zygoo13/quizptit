package com.quizptit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@org.springframework.scheduling.annotation.EnableScheduling
public class QuizptitApplication {

	public static void main(String[] args) {
		SpringApplication.run(QuizptitApplication.class, args);
	}

}
