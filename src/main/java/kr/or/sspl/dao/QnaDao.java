package kr.or.sspl.dao;

import java.util.List;

import kr.or.sspl.dto.QnaDto;

public interface QnaDao {
	
	// 글 작성
	public void qnaWrite(QnaDto qnaDto);
	
	// 글 출력
	public List<QnaDto> qnaList();
}
