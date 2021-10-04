package com.memo.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.memo.user.model.User;

@Repository
public interface UserDAO {
	public boolean existLoginId(String loginId);
	
	public void insertUser(User user);
	
	public User selectUserByLoginIdAndPassword(
			@Param("loginId") String loindId, 
			@Param("password") String password);
}
