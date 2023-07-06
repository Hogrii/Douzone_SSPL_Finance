package kr.or.sspl.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import kr.or.sspl.dto.QnaDto;
import kr.or.sspl.dto.QnaReplyDto;
import kr.or.sspl.service.QnaService;

@Controller
@RequestMapping("/qna/")
public class QnAController {
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private HttpSession session;

	// 리스트 페이지 이동
	@GetMapping("qnaList.do")
	public String qnaList(Model model, HttpServletRequest request) {
		qnaService.qnaList(model, request);
		return "qna/qna_list";
	}
	
	// 상세 페이지 이동
	@GetMapping("qnaDetail.do")
	public String qnaDetail(Model model, String qna_seq, String ps, String cp) {
		qnaService.qnaDetail(model, qna_seq, ps, cp);
		return "qna/qna_detail";
	}
	
	// 수정 페이지 이동
	@RequestMapping("qnaModify.do")
	public String qnaModify(String qna_seq, HttpServletRequest request, String cp, String ps) {
		qnaService.qnaModify(qna_seq, request, cp, ps);
		return "qna/qna_modify";
	}
	
	// 글쓰기 페이지 이동
	@GetMapping("qnaWrite.do")
	public String qnaWrite() {
		return "qna/qna_write";
	}
	
	// 글쓰기
	@RequestMapping("qnaWriteOk.do")
	public String qnaWriteOk(QnaDto qnaDto, HttpServletRequest request, HttpServletResponse response) {
		qnaService.qnaWriteOk(qnaDto, request, response);
		return "redirect:/qna/qnaList.do";		
	}
	
	// 글삭제
	@RequestMapping("delete.do")
	public String delete(String qna_seq) {
		qnaService.qnadelete(qna_seq);
		return "redirect:/qna/qnaList.do";
	}
	
	// 글수정
	@RequestMapping("qnaModifyOk.do")
	public String qnaModifyOk(QnaDto qnaDto) {
		qnaService.qnaModifyOk(qnaDto);
		return "redirect:/qna/qnaDetail.do?qna_seq="+qnaDto.getQna_seq();
	}
	
	// 댓글 작성
	@RequestMapping("qnaReplyOk.do")
	public String qnaReplyOk(String user_id, String qna_seq, String qna_reply_content) {
		qnaService.qnaReply(user_id, qna_seq, qna_reply_content);
		return "redirect:/qna/qnaDetail.do?qna_seq="+qna_seq;
	}
	
	// 댓글 수정
	@RequestMapping("updateOkReply.do")
	@ResponseBody
	public QnaReplyDto updateOkReply(String qna_reply_seq, String qna_reply_content) {
		QnaReplyDto replyDto = qnaService.qnaModifyReply(qna_reply_seq, qna_reply_content);
		return replyDto;
	}
	
	//파일업로드
	@RequestMapping(value = "/image", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {
		// 내부경로로 저장
		String fileRoot = request.getSession().getServletContext().getRealPath("/fileupload");
		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		System.out.println("originalFileName : "+ originalFileName);
		String savedFileName = originalFileName; // 저장될 파일 명        
		
		File targetFile = new File(fileRoot +"\\"+ savedFileName);
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
	
	// 검색하기
	@RequestMapping("searchKeyword.do")
	@ResponseBody
	public List<QnaDto> qnaSearch(String qna_title) {
		List<QnaDto> qnaList = new ArrayList<QnaDto>();
		qnaList = qnaService.searchList(qna_title);
		return qnaList;
	}
	
	// 댓글 삭제
	@RequestMapping("deleteReply.do")
	public String deleteReply(String qna_seq, String qna_reply_seq) {
		qnaService.deleteReply(qna_reply_seq);
		return "redirect:/qna/qnaDetail.do?qna_seq="+qna_seq;
	}
	
}
