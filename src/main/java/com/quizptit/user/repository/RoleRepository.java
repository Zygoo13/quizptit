package com.quizptit.user.repository;

import com.quizptit.common.constant.RoleName;
import com.quizptit.user.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoleRepository extends JpaRepository<Role, Long> {

    Optional<Role> findByRoleName(RoleName roleName);

    boolean existsByRoleName(RoleName roleName);
}