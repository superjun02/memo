package com.memo.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.memo.user.dao.UserDAO;
import com.memo.user.model.User;

@Service
public class UserBO {
	@Autowired
	private UserDAO userDao;
	
	public boolean existLoginId(String loginId) {
		return userDao.existLoginId(loginId);
	}
	
	public void addUser(User user) {
		userDao.insertUser(user);
	}
	
	public User getUserByLoginIdAndPassword(String loginId, String password) {
		return userDao.selectUserByLoginIdAndPassword(loginId, password);
	}
}
