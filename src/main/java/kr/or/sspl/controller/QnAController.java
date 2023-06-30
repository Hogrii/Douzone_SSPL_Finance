package kr.or.sspl.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.sspl.dto.QnaDto;
import kr.or.sspl.service.QnaService;

@Controller
@RequestMapping("/qna/")
public class QnAController {
	@Autowired
	private QnaService qnaService;

	// 이동
	@GetMapping("qnaList.do")
	public String qnaList() {
		return "qna/qna_list";
	}
	
	@GetMapping("qnaDetail.do")
	public String qnaDetail() {
		return "qna/qna_detail";
	}
	
	@GetMapping("qnaModify.do")
	public String qnaModify() {
		return "qna/qna_modify";
	}
	
	@GetMapping("qnaWrite.do")
	public String qnaWrite() {
		return "qna/qna_write";
	}
	
	// 글쓰기
	@RequestMapping("/qnaWriteOk.do")
	public String qnaWriteOk(QnaDto qnaDto, HttpServletRequest request, HttpServletResponse response) {
		qnaService.qnaWriteOk(qnaDto, request, response);
		return "qna/qna_list";		
	}
}
