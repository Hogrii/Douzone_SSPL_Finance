package kr.or.sspl.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.service.CommunityService;

@Controller
@RequestMapping("/community/")
public class CommunityController {	
	
	@Autowired
	private CommunityService communityservice;
	
	@GetMapping("list.do")
	public String CommunityList(String ps, String cp, Model model) throws ClassNotFoundException, SQLException {
		
		System.out.println("진입1");
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		communityservice.getCommunityList(ps,cp,model);
		return "community/community_list";
		
	}
	@GetMapping("detail.do")
	public String detail() {
		System.out.println("진입2");
		return "community/community_detail";
	}
	
	@GetMapping("modify.do")
	public String modify() {
		System.out.println("진입3");
		return "community/community_modify";
	}
	
	@GetMapping("write.do")
	public String write() {
		System.out.println("진입4");
		return "community/community_write";
	}
}
