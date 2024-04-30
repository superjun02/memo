package com.memo.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.memo.post.bo.PostBO;
import com.memo.post.domain.Post;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/post")
@Controller
public class PostController {
	@Autowired
	private PostBO postBO;
	
	@GetMapping("/post-list-view")
	public String postListView(Model model, HttpSession session,
			@RequestParam(value = "prevId", required = false) Integer prevIdParam,
			@RequestParam(value = "nextId", required = false) Integer nextIdParam) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/user/sign-in-view";
		}
		
		List<Post> postList = postBO.getPostListByUserId(userId, prevIdParam, nextIdParam);
		int prevId = 0;
		int nextId = 0;
		if (postList.isEmpty() == false) {
			prevId = postList.get(0).getId();
			nextId = postList.get(postList.size() - 1).getId();
		}
		
		model.addAttribute("prevId", prevId);
		model.addAttribute("nextId", nextId);
		model.addAttribute("postList", postList);
		model.addAttribute("viewName", "post/postList");
		return "template/layout";
	}
	
	@GetMapping("/post-create-view")
	public String postCreateView(Model model, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/user/sign-in-view";
		}
		model.addAttribute("viewName", "post/postCreate");
		
		return "template/layout";
	}
	
	@GetMapping("/post-detail-view")
	public String postDetailView(
			@RequestParam("postId") int postId, 
			Model model, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/user/sign-in-view";
		}
		// select DB
		Post post = postBO.getPostByPostIdAndUserId(postId, userId);
		
		model.addAttribute("viewName", "post/postDetail");
		model.addAttribute("post", post);
		
		return "template/layout";
	}
}
