package kr.or.sspl.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.dto.CommunitySearchData;

public interface CommunityDao {

	//전체 게시물 갯수 조회 
	int communityCount() throws ClassNotFoundException, SQLException;
	
	//전제 게시물 조회
	List<CommunityDto> list(Map<String,Integer> map) throws ClassNotFoundException, SQLException;
 
	//게시물 상세 - 예정
	CommunityDto getDetailList(int comm_seq)throws ClassNotFoundException, SQLException;
	
	//조건 검색 갯수
	int searchListTotal() throws ClassNotFoundException, SQLException;
	
	//조건 검색
	List<CommunityDto> searchList(CommunitySearchData SearchData) throws ClassNotFoundException, SQLException;
 
	//게시물 입력
	int communityInsert(CommunityDto communityDto) throws ClassNotFoundException, SQLException;

	//게시물 수정
	int communityUpdate(CommunityDto communityDto) throws ClassNotFoundException, SQLException;

	//게시물 삭제
	int communityDelete(int comm_seq) throws ClassNotFoundException, SQLException;
 
	//조회 수 증가 
	int addViewCount(int comm_seq);
	
	//comm_content 내에 <img> 유무 확인
	public List<CommunityDto> getCommunityList(boolean commContentContainsImage, String field, String query);
}
