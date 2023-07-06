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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.service.CommunityService;

@Controller
@RequestMapping("/community/")
public class CommunityController {

	@Autowired
	private CommunityService communityservice;

	@GetMapping("list.do")
	public String CommunityList(String cp, String ps, Model model) throws ClassNotFoundException, SQLException {
		communityservice.getCommunityList(cp, ps, model);
		return "community/community_list";
	}

	//상세페이지 넘어가는 동시에 조회수 증가 
	@GetMapping("detail.do")
	public String detail(int comm_seq, Model model, String cp, String ps) throws ClassNotFoundException, SQLException {
		communityservice.addViewCount(comm_seq); //게시글 조회수 증가 
		communityservice.getDetailList(comm_seq, model, cp, ps);		
		return "community/community_detail";
	}

	@GetMapping("write.do")
	public String write(Model model,String cp, String ps) {
		model.addAttribute("cp",cp);
		model.addAttribute("ps",ps);
		return "community/community_write";
	}

	// 글쓰기
	@PostMapping("writeOk.do")

	public String communityInsert(CommunityDto communityDto) throws ClassNotFoundException, SQLException {	  
		communityservice.communityInsert(communityDto);
		return "redirect:/community/list.do";
	}

	@GetMapping("modify.do")
	public String modify(int comm_seq, Model model, String cp, String ps) throws ClassNotFoundException, SQLException {
		communityservice.getDetailList(comm_seq, model, cp, ps);
		return "community/community_modify";
	}

	@PostMapping("modifyOk.do")
	public String modifyOk(CommunityDto communityDto) throws ClassNotFoundException, SQLException {
		communityservice.communityUpdate(communityDto);
		return "redirect:/community/list.do";
	}

	// 파일업로드
	@RequestMapping(value = "/image", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {
		// 내부경로로 저장
		String fileRoot = request.getSession().getServletContext().getRealPath("/fileupload");
		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		String savedFileName = originalFileName; // 저장될 파일 명

		File targetFile = new File(fileRoot + "\\" + savedFileName);
		JsonObject jsonObject = new JsonObject();
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);// 파일 저장
			jsonObject.addProperty("url", "/sspl_finance/fileupload/" + savedFileName); // contextroot +
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

	@GetMapping("delete.do")
	public String CommunityDelete(int comm_seq) throws ClassNotFoundException, SQLException {
		int result = communityservice.communityDelete(comm_seq);
		return "redirect:/community/list.do";
	}
}