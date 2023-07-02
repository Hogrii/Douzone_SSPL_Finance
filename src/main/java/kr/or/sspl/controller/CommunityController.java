package kr.or.sspl.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.dto.SaveReqDto;
import kr.or.sspl.service.CommunityService;

@Controller
@RequestMapping("/community/")
public class CommunityController {

	@Autowired
	private CommunityService communityservice;

	@GetMapping("list.do")
	public String CommunityList(String ps, String cp, Model model) throws ClassNotFoundException, SQLException {

		communityservice.getCommunityList(ps, cp, model);
		return "community/community_list";

	}

	@GetMapping("detail.do")
	public String detail(int comm_seq,Model model) throws ClassNotFoundException, SQLException {
		System.out.println("comm_seq : " + comm_seq);
		System.out.println("진입2");
		communityservice.getDetailList(comm_seq,model);

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

	// 글쓰기
	@RequestMapping("writeOk.do")
 	public String communityInsert(CommunityDto communityDto,HttpServletRequest request) throws ClassNotFoundException, SQLException {
	  request.setAttribute("user_id", "shs1993");
	  String user_id = (String) request.getAttribute("user_id");
	  System.out.println("communityInsert 진입");
	  String comm_title = request.getParameter("comm_title"); 
	  System.out.println("comm_title:"+comm_title);
	  String comm_category = request.getParameter("comm_category");
	  System.out.println("comm_category:"+comm_category);
	  String comm_content = request.getParameter("comm_content");
	  SaveReqDto saveReqDto = new SaveReqDto();
	  saveReqDto.setComm_category(comm_category);
	  saveReqDto.setComm_content(comm_content);
	  saveReqDto.setComm_title(comm_title);
	  saveReqDto.setUser_id(user_id);
	  
	  System.out.println("comm_content:"+comm_content);
	   
	  communityservice.communityInsert(saveReqDto);
      
 	  return "redirect:/community/list.do";
 	}
  
	//파일업로드
	@RequestMapping(value = "/image", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {
		System.out.println("servlet call");
		JsonObject jsonObject = new JsonObject();

		/*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */

		// 내부경로로 저장
		String fileRoot = request.getServletContext().getRealPath("/fileupload");
		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
		String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명
        
		
		System.out.println("path : "+fileRoot+savedFileName);
		File targetFile = new File(fileRoot + savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);// 파일 저장
			jsonObject.addProperty("url", "/resources/fileupload/" + savedFileName); // contextroot +
																								// resources + 저장할 내부
			jsonObject.addProperty("responseCode", "success");

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;

	}
	 
}