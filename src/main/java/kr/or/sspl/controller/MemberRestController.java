package kr.or.sspl.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.sspl.dto.MemberDto;
import kr.or.sspl.service.MemberService;

@RestController
@RequestMapping("/member/")
public class MemberRestController {

	@Autowired
	private MemberService memberService;

	@PostMapping("joinOk")
	public ResponseEntity<Map<String, String>> createMember(MemberDto memberDto) {
		Map<String, String> map = null;
		System.out.println(memberDto.toString());
		
		map = memberService.join(memberDto);
		return new ResponseEntity<Map<String, String>>(map, HttpStatus.OK);
	}
	
	@GetMapping("/idcheck/{id}")
	public ResponseEntity<Map<String, String>> idCheck(@PathVariable(value = "id") String id){
		System.out.println(id);
		Map<String, String> map = memberService.idCheck(id);
		
		return new ResponseEntity<Map<String, String>>(map, HttpStatus.OK);
	}
	
	@PostMapping("login")
	public ResponseEntity<Map<String, String>> login(@PathVariable(value = "id") String id){
		//System.out.println(id);
		Map<String, String> map = null;
		
		return new ResponseEntity<Map<String, String>>(map, HttpStatus.OK);
	}
	
	

}
