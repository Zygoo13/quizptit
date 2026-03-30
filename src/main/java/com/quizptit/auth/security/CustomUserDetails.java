package com.quizptit.auth.security;

import com.quizptit.common.constant.UserStatus;
import com.quizptit.user.entity.User;
import lombok.Getter;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Getter
public class CustomUserDetails implements UserDetails {

    private final Long userId;
    private final String email;
    private final String password;
    private final UserStatus status;
    private final Collection<SimpleGrantedAuthority> authorities;

    public CustomUserDetails(User user) {
        this.userId = user.getUserId();
        this.email = user.getEmail();
        this.password = user.getPasswordHash();
        this.status = user.getStatus();
        this.authorities = List.of(
                new SimpleGrantedAuthority("ROLE_" + user.getRole().getRoleName().name())
        );
    }

    @Override
    public Collection<SimpleGrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return status != UserStatus.BANNED;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return status == UserStatus.ACTIVE;
    }
}