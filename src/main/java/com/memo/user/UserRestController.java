package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.common.EncryptUtils;
import com.memo.user.bo.UserBO;
import com.memo.user.model.User;

@RequestMapping("/user")
@RestController
public class UserRestController {
	@Autowired
	private UserBO userBo;
	
	/**
	 * 아이디 중복확인 체크
	 *  @param loginId
	 * 
	 */
	@RequestMapping("/is_duplicated_id")
	public Map<String, Boolean> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		// 중복 여부에 대한 결과 Map 생성
		Map<String, Boolean> result = new HashMap<>();
		
		result.put("result", userBo.existLoginId(loginId));
		// return map
		return result;
	}
	
	
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email) {
		// 비밀번호 해싱
		String encryptPassword = EncryptUtils.md5(password);
		
		// DB user insert
		User user = new User();
		user.setLoginId(loginId);
		user.setPassword(encryptPassword);
		user.setEmail(email);
		user.setName(name);
		
		userBo.addUser(user);
		// 응답값 생성 후 리턴
		Map<String, Object> result = new HashMap<>();
		
		result.put("result", "success");
		return result;
	}
	
	/**
	 * 로그인
	 * @param request
	 * @param loginId
	 * @param password
	 * @return
	 */
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			HttpServletRequest request,
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password) {
		// 파라미터로 받은 비번을 해싱한다.
		String encryptPassword = EncryptUtils.md5(password);
		
		// DB SELECT - 아이디, 해싱된 암호
		User user = userBo.getUserByLoginIdAndPassword(loginId, encryptPassword);
		
		Map<String, Object> result = new HashMap<>();
		
		if (user != null) {
			// 있으면 로그인 성공   (세션)
			result.put("result", "success");
			
			// 로그인 처리 = 세션에 저장 (로그인 상태 유지)
			HttpSession session = request.getSession();
		    session.setAttribute("userId", user.getId());
		    session.setAttribute("userName", user.getName());
		    session.setAttribute("userLoginId", user.getLoginId());
		} else {
			// 없으면 로그인 실패
			
			result.put("result", "error");
		}	
		
		return result;
	}
}







