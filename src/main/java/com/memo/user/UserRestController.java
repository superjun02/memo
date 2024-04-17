package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.user.bo.UserBO;

@RequestMapping("/user")
@RestController
public class UserRestController {
	@Autowired
	private UserBO userBO;
	
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
			result.put("date", userBO.getUserEntityByLoginId(loginId).getCreatedAt());
		}
		
		return result;
	}
}
