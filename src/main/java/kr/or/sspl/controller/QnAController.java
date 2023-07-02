package kr.or.sspl.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.sspl.dto.QnaDto;
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
	public String qnaDetail(Model model, String qna_seq) {
		qnaService.qnaDetail(model, qna_seq);
		return "qna/qna_detail";
	}
	
	// 수정 페이지 이동
	@RequestMapping("qnaModify.do")
	public String qnaModify(String qna_seq, HttpServletRequest request) {
		qnaService.qnaModify(qna_seq, request);
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
	
	// 이미지
	@RequestMapping(value="qnaImage.do" , produces = "application/text;charset=utf-8")
	@ResponseBody
	public String imageUpload(MultipartFile[] file) throws Exception{	
		String sysName = null;
		String realPath = null;
		System.out.println("파일처리하러 왓어요~");
		for (MultipartFile mf : file) {
			// 파일이 비어있지 않다면 for문을 돌리라는 의미이다. 빈 파일을 업로드하지 못하게 막는 코드이다.
			if (!mf.isEmpty()) {
				// cos.jar를 통해 request를 multipart request로 업그레이드 시켜 데이터를 뽑아내어 사용했다.
				// spring은 apachi fileupload를 사용하기 때문에 maven repository에서 다운로드 받아온다.

				realPath = session.getServletContext().getRealPath("")+"\\resources\\img";
				// Servers -> Tomcat 우클릭 -> Browse Deployment Location... : realPath의 위치

				// realPath 객체를 만들고 만약에 realPathFile 폴더가 없으면 폴더를 만들라는 이야기
				File realPathFile = new File(realPath);
				if (!realPathFile.exists()) {
					realPathFile.mkdir();
				}

				// oriName : 사용자가 업로드한 파일의 원본 이름
				String oriName = mf.getOriginalFilename();

				// sysName : 서버에 저장할 파일 이름
				// UUID.randomUUID() : 절대 겹치지 않는 문자배열을 만들어준다.
				sysName = UUID.randomUUID() + "_" + oriName;

				// 서버에 업로드되어 메모리에 적재된 파일의 내용을 어디에 저장할지 결정하는 부분
				mf.transferTo(new File(realPath + "/" + sysName));
			}
		}
		return "\\img\\" + sysName;
	}
	
	// 검색하기
	@RequestMapping("searchKeyword.do")
	@ResponseBody
	public List<QnaDto> qnaSearch(String qna_title) {
		System.out.println("Conkeyword : " + qna_title);
		List<QnaDto> qnaList = new ArrayList<QnaDto>();
		qnaList = qnaService.searchList(qna_title);
		System.out.println(qnaList.toString());
		return qnaList;
	}
	
}
