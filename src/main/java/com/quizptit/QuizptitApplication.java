package com.quizptit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@SpringBootApplication
@org.springframework.scheduling.annotation.EnableScheduling
public class QuizptitApplication {

	public static void main(String[] args) {

		SpringApplication.run(QuizptitApplication.class, args);
	}

}
