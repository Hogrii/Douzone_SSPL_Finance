package kr.or.sspl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.sspl.dao.QnaDao;
import kr.or.sspl.dto.QnaDto;

@Service
public class QnaService {
	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	public void qnaWriteOk(QnaDto qnaDto, HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println(qnaDto.getUser_id() + " " + qnaDto.getQna_title() + " " + qnaDto.getQna_content() + " " + qnaDto.getQna_category());
			QnaDao qnaDao = sqlsession.getMapper(QnaDao.class);
			qnaDao.qnaWrite(qnaDto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
