package com.memo.post.bo;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.common.FileManagerService;
import com.memo.post.dao.PostDAO;
import com.memo.post.model.Post;

@Service
public class PostBO {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private static final int POST_MAX_SIZE = 3;
	
	@Autowired
	private PostDAO postDao;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	public List<Post> getPostList(int userId, Integer prevId, Integer nextId) {
		String direction = null;  // null || next || prev
		Integer standardId = null;
		
		if (prevId != null) {
			// 이전 클릭
			direction = "prev";
			standardId = prevId;
			
			// 7보다 큰 3개 => 8 9 10 reverse => 10 9 8
			List<Post> postList = postDao.selectPostList(userId, direction, standardId, POST_MAX_SIZE);
			Collections.reverse(postList);
			
			return postList;
		} else if (nextId != null) {
			// 다음 클릭
			direction = "next";
			standardId = nextId;
		}
		
		return postDao.selectPostList(userId, direction, standardId, POST_MAX_SIZE);
	}
	
	// 다음 기준으로 마지막 페이지 인가?
	public boolean isLastPage(int userId, int nextId) {
		// 오름차순 limit 1 제일 작은 값   nextId가 같으면 마지막 페이지
		return nextId == postDao.selectIdByUserIdAndSort(userId, "ASC");
	}
	
	public boolean isFirstPage(int userId, int prevId) {
		// 내림차순 limit 1 제일 큰 값    prevId랑 같으면 첫번째 페이지
		return prevId == postDao.selectIdByUserIdAndSort(userId, "DESC");
	}
	
	public int createPost(int userId, String userLoginId, String subject, String content, MultipartFile file) {
		String imagePath = null;
		
		if (file != null) {
			try {
				imagePath = fileManagerService.saveFile(userLoginId, file);
			} catch (IOException e) {
				imagePath = null;
			}
		}
		
		return postDao.insertPost(userId, subject, content, imagePath);
	}
	
	public Post getPost(int postId) {
		return postDao.selectPost(postId);
	}
	
	public void updatePost(int postId, String loginId, String subject, String content, MultipartFile file) {
		// postId로 게시물이 있는지 확인
		Post post = getPost(postId);
		
		if (post == null) {
			logger.error("[글 수정} post is null. postId:{}", postId);
			return;
		}
		
		// file이 있으면 업로드 후 imagePath 얻어온다
		String imagePath = null;
		if (file != null) {
			// 파일 업로드
			try {
				imagePath = fileManagerService.saveFile(loginId, file);
				
				// 기존에 있던 파일 제거 - imagePath가 존재(업로드 성공) && 기존에 파일 있으면
				if (imagePath != null && post.getImagePath() != null) {
					// 업로드가 실패할 수 있으므로 업로드 성공 후 제거
					fileManagerService.deleteFile(post.getImagePath());
				}
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// db update
		postDao.updatePost(postId, subject, content, imagePath);
	}
	
	public void deletePost(int postId) {
		// postId로 post를 가져온다.
		Post post = getPost(postId);
		if (post == null) {
			logger.error("[delete post] 삭제할 게시물이 없습니다. {}", postId);
			return;
		}
		
		// 그림이 있으면 삭제한다.
		String imagePath = post.getImagePath();
		
		if (imagePath != null) {
			try {
				fileManagerService.deleteFile(imagePath);
			} catch (IOException e) {
				logger.error("[delete post] 그림 삭제 실패 postId: {}, imagePath: {}", postId, imagePath);
			}
		}
		
		// 포스트를 삭제한다.
		postDao.deletePost(postId);
	}
}
