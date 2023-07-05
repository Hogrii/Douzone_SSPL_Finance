package kr.or.sspl.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.dto.CommunityReplyDto;
import kr.or.sspl.dto.CommunitySearchData;
import kr.or.sspl.dto.SaveReqDto;

public interface CommunityReplyDao {

	// 댓글 조회(대댓글 포함)
	List<CommunityReplyDto> communityReplyList(int comm_seq);
	 
	//대댓글 조회 
	//List<CommunityReplyDto> reReplyList(int comm_seq);

	// 댓글 입력
	int communityReplyInsert(CommunityReplyDto communityReplyDto) throws ClassNotFoundException, SQLException;

	// 원본글 삭제시 필요(순번 선택하여 삭제)
	void communityReplyDelete(int comm_seq) throws ClassNotFoundException, SQLException;

	// 댓글 삭제
	int ReplyDelete(int comm_reply_seq) throws ClassNotFoundException, SQLException;

	// 대댓글 입력
	int communityReReplyInsert(CommunityReplyDto communityReplyDto) throws ClassNotFoundException, SQLException;

	// comm_seq 조회
	int getCommSeq(int comm_reply_seq) throws ClassNotFoundException, SQLException;
	
}
