package com.memo.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.memo.post.model.Post;

@Repository
public interface PostDAO {
	public List<Post> selectPostList(
			@Param("userId") int userId
			, @Param("direction") String direction
			, @Param("standardId") Integer standardId
			, @Param("limit") int limit);
	
	public int selectIdByUserIdAndSort(
			@Param("userId") int userId
			, @Param("sort") String sort);
	
	public int insertPost(
			@Param("userId") int userId
			, @Param("subject") String subject
			, @Param("content") String content
			, @Param("imagePath") String imagePath);
	
	public Post selectPost(int postId);
	
	public void updatePost(
			@Param("id") int id
			, @Param("subject") String subject
			, @Param("content") String content
			, @Param("imagePath") String imagePath);
	
	public void deletePost(int id);
}
