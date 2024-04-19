package com.memo.post.bo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.memo.post.mapper.PostMapper;

@Service
public class PostBO {
	@Autowired
	private PostMapper postMapper;
	
	public List<Map<String, Object>> getPostListByUserId(int userId) {
		return postMapper.selectPostListByUserId(userId);
	}

}
