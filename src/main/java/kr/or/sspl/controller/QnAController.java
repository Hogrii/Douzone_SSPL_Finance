package kr.or.sspl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/qna/")
public class QnAController {

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
}
