package kr.or.sspl.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.sspl.dto.MemberDto;
import kr.or.sspl.service.MemberService;

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	@Autowired
	public MemberService memberService;

	@GetMapping("join")
	public String join() {
		return "/member/member_join";
	}
	
//	@PostMapping("joinOk")
//	public String joinOk(MemberDto memberdto) {
//		System.out.println(memberdto.toString());
//		String msg = memberService.join(memberdto);
//		System.out.println(msg);
//	
//		return "/main/main";
//	}
	
	@GetMapping("login")
	public String login() {
		System.out.println("로그인");
		return "/member/member_login";
	}
	
	@GetMapping("mypage")
	public String myPage() {
		return "/member/member_mypage";
	}
	
	@GetMapping("member_modify")
	public String modify() {
		
		return "/member/member_modify";
	}
	
	
}
