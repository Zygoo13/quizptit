package com.quizptit.auth.security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final UserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;
    private final CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(
                                "/bootstrap/**",
                                "/css/**",
                                "/js/**",
                                "/images/**",
                                "/uploads/**",
                                "/webjars/**",
                                "/favicon.ico",
                                "/auth/login",
                                "/auth/register",
                                "/access-denied"
                        ).permitAll()

                        // Public pages
                        .requestMatchers(HttpMethod.GET, "/").permitAll()
                        .requestMatchers(HttpMethod.GET, "/subjects", "/subjects/*").permitAll()
                        .requestMatchers(HttpMethod.GET, "/subjects/*/topics").permitAll()
                        .requestMatchers(HttpMethod.GET, "/topics/*").permitAll()
                        .requestMatchers(HttpMethod.GET, "/community/questions", "/community/questions/*").permitAll()

                        // Quiz public list only
                        .requestMatchers(HttpMethod.GET, "/quizzes").permitAll()

                        // Quiz detail + learning flow must login
                        .requestMatchers(
                                "/quizzes/*",
                                "/quizzes/random",
                                "/quizzes/history",
                                "/quizzes/attempts/**",
                                "/progress/**",
                                "/review/**",
                                "/profile",
                                "/profile/change-password",
                                "/student/dashboard",
                                "/api/attempts/**",
                                "/api/quizzes/random"
                        ).authenticated()

                        // Admin
                        .requestMatchers("/admin/**").hasRole("ADMIN")

                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/auth/login")
                        .loginProcessingUrl("/auth/login")
                        .usernameParameter("email")
                        .passwordParameter("password")
                        .successHandler(customAuthenticationSuccessHandler)
                        .failureUrl("/auth/login?error")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/auth/logout")
                        .logoutSuccessUrl("/auth/login?logout")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                )
                .exceptionHandling(exception -> exception
                        .accessDeniedPage("/access-denied")
                )
                .authenticationProvider(authenticationProvider())
                .csrf(Customizer.withDefaults());

        return http.build();
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService);
        provider.setPasswordEncoder(passwordEncoder);
        return provider;
    }
}