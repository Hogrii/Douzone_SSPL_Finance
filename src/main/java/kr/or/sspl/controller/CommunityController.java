package kr.or.sspl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("Community")
public class CommunityController {	
	@GetMapping("/list.do")
	public String list() {
		System.out.println("진입1");
		return "community/community_list";
	}
	
	@GetMapping("/detail.do")
	public String detail() {
		System.out.println("진입2");
		return "community/community_detail";
	}
	
	@GetMapping("/modify.do")
	public String modify() {
		System.out.println("진입3");
		return "community/community_modify";
	}
	
	@GetMapping("/write.do")
	public String write() {
		System.out.println("진입4");
		return "community/community_write";
	}
}
