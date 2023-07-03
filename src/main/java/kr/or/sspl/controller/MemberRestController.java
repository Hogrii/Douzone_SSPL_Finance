package kr.or.sspl.controller;

import java.lang.reflect.Member;
import java.security.Principal;
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
		
		System.out.println(map);
		return new ResponseEntity<Map<String, String>>(map, HttpStatus.OK);
	}
	
	@GetMapping("/idcheck/{id}")
	public ResponseEntity<Map<String, String>> idCheck(@PathVariable(value = "id") String id){
		System.out.println(id);
		Map<String, String> map = memberService.idCheck(id);
		
		return new ResponseEntity<Map<String, String>>(map, HttpStatus.OK);
	}
	
	@PostMapping("passwordCheck")
	public ResponseEntity<Boolean> passwordCheck(String id, String password){
		
		boolean result = false;
				
		result = memberService.userSelect(id, password);
		
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	@GetMapping("userData")
	public ResponseEntity<MemberDto> userData(String id){
		
		MemberDto dto = null;
		
		dto = memberService.userData(id);
		
		return new ResponseEntity<MemberDto>(dto, HttpStatus.OK);
	}
	
	@PostMapping("dupDataCheck")
	public ResponseEntity<Map<String, String>> dupDataCheck(MemberDto dto){
		
		System.out.println(dto);
		
		Map<String, String> map = memberService.dupDataCheck(dto);
		
		System.out.println("DB중복체크");
		System.out.println(map);
		
		return new ResponseEntity<Map<String, String>>(map, HttpStatus.OK);
	}
	
	@PostMapping("userModify")
	public ResponseEntity<Map<String, String>> userModify(MemberDto dto){
		
		System.out.println("갱신 전 :"+dto.toString());
		
		Map<String, String> map =  memberService.userModify(dto);
		
		System.out.println(map);
		
		return new ResponseEntity<Map<String, String>>(map, HttpStatus.OK);
	}
	
	

	
	

}
