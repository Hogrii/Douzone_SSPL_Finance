package kr.or.sspl.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.or.sspl.dao.QnaDao;
import kr.or.sspl.dto.QnaDto;

@Service
public class QnaService {
	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	// 글쓰기
	public void qnaWriteOk(QnaDto qnaDto, HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println(qnaDto.getUser_id() + " " + qnaDto.getQna_title() + " " + qnaDto.getQna_content() + " " + qnaDto.getQna_category());
			QnaDao qnaDao = sqlsession.getMapper(QnaDao.class);
			qnaDao.qnaWrite(qnaDto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 글출력
	public void qnaList(Model model) {
		List<QnaDto> qnaList = null;
		try {
			QnaDao qnaDao = sqlsession.getMapper(QnaDao.class);
			qnaList = qnaDao.qnaList();
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println(qnaList.toString());
		model.addAttribute("qnaList", qnaList);
	}
	
	// 상세 페이지 출력
	public void qnaDetail(Model model, String qna_title) {
		System.out.println("service : " + qna_title);
		QnaDto qna = null;
		try {
			QnaDao qnaDao = sqlsession.getMapper(QnaDao.class);
			qna = qnaDao.qna(qna_title);
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("qna : " + qna);
		model.addAttribute("qna", qna);
	}

}
