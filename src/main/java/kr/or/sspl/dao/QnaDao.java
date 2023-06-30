package kr.or.sspl.dao;

import kr.or.sspl.dto.QnaDto;

public interface QnaDao {
	
	// 글 작성
	public void qnaWrite(QnaDto qnaDto);
}
