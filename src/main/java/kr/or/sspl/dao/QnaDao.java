package kr.or.sspl.dao;

import java.util.List;
import java.util.Map;

import kr.or.sspl.dto.QnaDto;
import kr.or.sspl.dto.QnaReplyDto;

public interface QnaDao {
	
	// 글 작성
	public void qnaWrite(QnaDto qnaDto);
	
	// 글 출력
	public List<QnaDto> qnaList(Map<String, Integer> listMap);
	
	// 상세 페이지 출력
	public QnaDto qna(String qna_seq);
	
	// 글 삭제
	public void qnaDelete(int qna_seq);
	
	// 댓글 작성
	public void qnaReply(Map<String, String> replyHash);
	
	// 댓글 출력
	public List<QnaReplyDto> qnaReplyList(int qna_seq);
	
	// 총 게시글 수
	public int totallistCount();
	
	// 글 수정
	public void qnaModify(QnaDto qnaDto);
	
	// 게시글 상태 변경 -> 답변완료
	public void qnaState(String qna_seq);
	
	// 게시글 상태 변경 -> 답변중
	public void qnaInitState(String qna_seq);
	
	// 검색
	public List<QnaDto> searchList(Map<String, String> searchMap);
	
	// 댓글 삭제
	public void qnaReplyDelete(int qna_reply_seq);
	
	// 게시글 삭제 시 댓글 삭제
	public void qnaReplyAllDelete(int qna_seq);
	
	// 댓글 수정
	public void qnaModifyReply(Map<String, String> replyModifyMap);
	
	// 댓글 가져오기
	public QnaReplyDto getQnaReply(String qna_reply_seq);
}
