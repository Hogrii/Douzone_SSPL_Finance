package kr.or.sspl.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.dto.CommunitySearchData;
import kr.or.sspl.dto.SaveReqDto;

public interface CommunityReplyDao {
	 
		// 게시물 입력
		int communityReplyInsert(SaveReqDto saveReqDto) throws ClassNotFoundException, SQLException;

		// 게시물 삭제(순번 선택하여 삭제)
		void communityReplyDelete(int comm_seq) throws ClassNotFoundException, SQLException;
	 
}
