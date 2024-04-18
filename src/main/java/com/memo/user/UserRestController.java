package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.common.EncryptUtils;
import com.memo.user.bo.UserBO;
import com.memo.user.entity.UserEntity;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@RestController
public class UserRestController {
	@Autowired
	private UserBO userBO;
	
	/**
	 * 아이디 중복확인 API
	 * @param loginId
	 * @return ajax로 보내는 result json
	 */
	@GetMapping("/is-duplicated-id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		Map<String, Object> result = new HashMap<>();
		
		// DB select
		if (userBO.getUserEntityByLoginId(loginId) == null) {
			result.put("code", 200);
			result.put("is_duplicated_id", false);
		} else {
			result.put("code", 200);
			result.put("is_duplicated_id", true);
		}
		
		return result;
	}
	
	/**
	 * 회원가입 API
	 * @param name
	 * @param loginId
	 * @param password
	 * @param email
	 * @return ajax로 보내는 result json
	 */
	@PostMapping("/sign-up")
	public Map<String, Object> signUp(
			@RequestParam("name") String name,
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("email") String email) {
		Map<String, Object> result = new HashMap<>();
		
		// MD5 알고리즘
		// 암호 hashing
		String hashedPassword = EncryptUtils.md5(password);
		// DB insert
		Integer userId = userBO.addUser(loginId, hashedPassword, name, email);
		
		if (userId != null) {
			result.put("code", 200);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("error_message", "회원가입에 실패했습니다.");
		}
		
		return result;
	}
	
	/**
	 * 로그인 API
	 * @param loginId
	 * @param password
	 * @return ajax로 보내는 result json
	 */
	@PostMapping("/sign-in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		
		
		String hashedPassword = EncryptUtils.md5(password);
		
		UserEntity user = userBO.getUserEntityByLoginIdPassword(loginId, hashedPassword);
		
		if (user != null) {
			// 로그인 처리 => 로그인 정보를 세션에 담는다. (사용자마다 다름)
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
			session.setAttribute("loginId", user.getLoginId());
			session.setAttribute("name", user.getName());
			
			result.put("code", 200);
			result.put("result", "성공");
		} else {
			result.put("code", 300);
			result.put("error_message", "존재하지 않는 사용자입니다.");
		}
		return result;
	}
}
