package kr.or.sspl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommunityController {
	@GetMapping("header.do")
	public String header() {
		System.out.println("??");
		return "common/header";
	}
	
	@GetMapping("/")
	public String test() {
		System.out.println("진입");
		return "common/header";
	}
	
	@GetMapping("list.do")
	public String list() {
		System.out.println("진입");
		return "community/community_list";
	}
}
