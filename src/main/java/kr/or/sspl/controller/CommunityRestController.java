package kr.or.sspl.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.dto.CommunitySearchData;
import kr.or.sspl.service.CommunityService;

@RestController
@RequestMapping("/restcommunity/*")
public class CommunityRestController {
	@Autowired
	private CommunityService communityservice;
	
	@PostMapping("listSearch")
	public ResponseEntity<?> searchList(@RequestBody CommunitySearchData searchData){
		System.out.println("restController 진입");
		System.out.println(searchData.toString());
		try {
			List<CommunityDto> list = communityservice.getSearchList(searchData);
			System.out.println("값들어오냐고"+list);
			return new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>("fail",HttpStatus.BAD_REQUEST);
		}
	}
	
// 	 @GetMapping("listInsert")
// 	    public ResponseEntity<?> communityInsert(@RequestBody CommunityDto communityDto) throws ClassNotFoundException, SQLException{
// 	    	communityservice.communityInsert(communityDto);
//     	return new ResponseEntity<>(HttpStatus.OK);
//     }

	
}
