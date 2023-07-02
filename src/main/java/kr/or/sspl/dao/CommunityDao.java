package kr.or.sspl.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.dto.CommunitySearchData;
import kr.or.sspl.dto.SaveReqDto;
public interface CommunityDao {

	//전체 게시물 갯수 조회 
	int communityCount() throws ClassNotFoundException, SQLException;
	// 전제 게시물 조회
	List<CommunityDto> list(Map<String,Integer> map) throws ClassNotFoundException, SQLException;
 
	// 게시물 상세 - 예정
	CommunityDto getDetailList(int comm_seq)throws ClassNotFoundException, SQLException;
	
	//조건 검색 갯수
	int searchListTotal() throws ClassNotFoundException, SQLException;
	
	// 비동기 조건 검색(form의 value로 조건 검색할 예정)
	List<CommunityDto> searchList(CommunitySearchData SearchData) throws ClassNotFoundException, SQLException;
 
	// 게시물 입력
	int communityInsert(SaveReqDto saveReqDto) throws ClassNotFoundException, SQLException;

	// 게시물 수정
	int communityUpdate(SaveReqDto saveReqDto) throws ClassNotFoundException, SQLException;

	// 게시물 삭제(순번 선택하여 삭제)
	int communityDelete(int comm_seq) throws ClassNotFoundException, SQLException;
 

}
