package com.memo.post;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.util.CollectionUtils;

import com.memo.post.bo.PostBO;
import com.memo.post.model.Post;

@RequestMapping("/post")
@Controller
public class PostController {
	
	private Logger logger = LoggerFactory.getLogger(PostController.class);
	
	@Autowired
	private PostBO postBo;
	
	/**
	 * 글 목록 화면
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/post_list_view")
	public String postListView(Model model,
			HttpServletRequest request,
			@RequestParam(value="prevId", required = false) Integer prevIdParam,
			@RequestParam(value="nextId", required = false) Integer nextIdParam) {
		// 글 목록들을 가져온다.
		HttpSession session = request.getSession();
		
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			logger.info("[post_list_view] userId is null. " + userId);
			return "redirect:/user/sign_in_view";
		}
		List<Post> postList = postBo.getPostList(userId, prevIdParam, nextIdParam);
		
		int prevId = 0;
		int nextId = 0;
		
		if (CollectionUtils.isEmpty(postList) == false) {
			prevId = postList.get(0).getId();
			nextId = postList.get(postList.size()-1).getId();
			
			// 이전이나 다음이 없는 경우 0으로 세팅한다.
			
			// 마지막페이지(다음 기준) 인 경우 0 으로 세팅
			if (postBo.isLastPage(userId, nextId)) {
				nextId = 0;
			}
			
			// 첫번째페이지 (이전 기준)인 경우 0으로 세팅
			if (postBo.isFirstPage(userId, prevId)) {
				prevId = 0;
			}
		}
		
		// 모델에 담는다
		model.addAttribute("prevId", prevId);
		model.addAttribute("nextId", nextId);
		model.addAttribute("postList", postList);
		model.addAttribute("viewName", "post/post_list");
		
		return "template/layout";
	}
	
	@RequestMapping("/post_create_view")
	public String postCreateView(Model model,
			HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			// 세션에 id가 없으면 로그인 하는 페이지로 이동(redirect)
			return "redirect:/user/sign_in_view";
		}
		
		model.addAttribute("viewName", "post/post_create");
		return "template/layout";
	}
	
	@RequestMapping("/post_detail_view")
	public String postDetailView(
			@RequestParam("postId") int postId,
			Model model,
			HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			// 세션에 id가 없으면 로그인 하는 페이지로 이동(redirect)
			return "redirect:/user/sign_in_view";
		}
		
		// postId에 해당하는 게시물을 가져와서 model에 담는다.
		Post post = postBo.getPost(postId);
		
		model.addAttribute("viewName", "post/post_detail");
		model.addAttribute("post", post);
		
		return "template/layout";
	}
}
