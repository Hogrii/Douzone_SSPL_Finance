package kr.or.sspl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommunityController {
	@GetMapping("list.do")
	public String list() {
		System.out.println("진입");
		return "community/community_list";
	}
	
	@GetMapping("/")
	public String test() {
		System.out.println("진입");
		return "common/header";
	}
	
	@GetMapping("modify.do")
	public String modify() {
		System.out.println("진입");
		return "community/community_modify";
	}
	
	@GetMapping("write.do")
	public String write() {
		System.out.println("진입");
		return "community/community_write";
	}
}
