package com.memo.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.memo.user.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Integer>{
	public UserEntity findByLoginId(String loginId);

	public UserEntity findByLoginIdAndPassword(
			@Param("loginId") String loginId,
			@Param("password") String password);
}