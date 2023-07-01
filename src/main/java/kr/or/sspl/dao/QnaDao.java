package kr.or.sspl.dao;

import java.util.List;
import java.util.Map;

import kr.or.sspl.dto.QnaDto;
import kr.or.sspl.dto.QnaReplyDto;

public interface QnaDao {
	
	// 글 작성
	public void qnaWrite(QnaDto qnaDto);
	
	// 글 출력
	public List<QnaDto> qnaList();
	
	// 상세 페이지 출력
	public QnaDto qna(String qna_seq);
	
	// 글 삭제
	public void qnaDelete(int qna_seq);
	
	// 댓글 작성
	public void qnaReply(Map<String, String> replyHash);
	
	// 댓글 출력
	public List<QnaReplyDto> qnaReplyList(int qna_seq);
}
