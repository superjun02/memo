package com.memo.post.bo;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.common.FileManagerService;
import com.memo.post.domain.Post;
import com.memo.post.mapper.PostMapper;


@Service
public class PostBO {
	
	// private Logger logger = LoggerFactory.getLogger(PostBO.class);
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PostMapper postMapper;
	
	@Autowired
	private FileManagerService fileManager;
	
	public List<Post> getPostListByUserId(int userId) {
		return postMapper.selectPostListByUserId(userId);
	}

	public int addPost(int userId, String loginId, String subject, String content,  MultipartFile file) {
		String imagePath = null;
		
		// 업로드 할 이미지가 있을 때 업로드
		if (file != null) {
			imagePath = fileManager.saveFile(loginId, file);
		}
		
		return postMapper.insertPost(userId, subject, content, imagePath);
	}

	public Post getPostByPostIdAndUserId(int postId, Integer userId) {
		return postMapper.selectPostByPostIdAndUserId(postId, userId);
	}

	public void updatePostByIdUserId(int userId, String loginId, int postId, String subject, String content,
			MultipartFile file) {
		
		// 기존글을 가져온다. (1. 기존 이미지 교체시 삭제 2. 업데이트 대상이 있는지 확인)
		Post post = getPostByPostIdAndUserId(postId, userId);
		if (post == null) {
			logger.info("[### post update] Post is null. postId:{}", postId);
			return;
		}
		// 파일이 존재하면
		// 1) 새 이미지를 업로드 한다.
		// 2) 1번 단계가 성공하면 기존 이미지 제거(기존 이미지가 있었다면), 1번 실패시 기존 이미지 그대로
		String imagePath = null;
		if (file != null) {
			imagePath = fileManager.saveFile(loginId, file);
			
			if (imagePath != null && post.getImagePath() != null) {
				// 서버의 파일 제거
				fileManager.deleteFile(post.getImagePath());
			}
		}
		// DB 업데이트
		postMapper.updatePostByPostId(postId, subject, content, imagePath);
	}

	public void deletePostByPostIdUserId(int userId, int postId) {
		Post post = getPostByPostIdAndUserId(postId, userId);
		if (post == null) {
			logger.info("[### post update] Post is null. postId:{}", postId);
			return;
		}
		
		if (post.getImagePath() != null) {
			// 서버의 파일 제거
			fileManager.deleteFile(post.getImagePath());
		}
		postMapper.deletePostByPostId(postId);
	}

}
