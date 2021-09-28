package com.memo.user.dao;

import org.springframework.stereotype.Repository;

import com.memo.user.model.User;

@Repository
public interface UserDAO {
	public boolean existLoginId(String loginId);
	
	public void insertUser(User user);
}
