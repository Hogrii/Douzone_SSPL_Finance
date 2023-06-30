package kr.or.sspl.controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.service.CommunityService;

@RestController
@RequestMapping("restcommunity")
public class CommunityRestController {
	@Autowired
	private CommunityService communityservice;
	
	
	
}
