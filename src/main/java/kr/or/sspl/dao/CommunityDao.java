package kr.or.sspl.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import kr.or.sspl.dto.CommunityDto;
public interface CommunityDao {

	//전체 게시물 갯수 조회 
	int communityCount() throws ClassNotFoundException, SQLException;
	// 전제 게시물 조회 - 완료
	List<CommunityDto> list(Map<String,Integer> map) throws ClassNotFoundException, SQLException;
 
	// 게시물 상세 - 예정
	CommunityDto listDetail(CommunityDto communityDto)throws ClassNotFoundException, SQLException;
	
	// 비동기 조건 검색(form의 value로 조건 검색할 예정)
	List<CommunityDto> searchList(String search) throws ClassNotFoundException, SQLException;
 
	// 게시물 입력
	void communityInsert(CommunityDto communityDto) throws ClassNotFoundException, SQLException;

	// 게시물 수정
	void communityUpdate(CommunityDto communityDto) throws ClassNotFoundException, SQLException;

	// 게시물 삭제(순번 선택하여 삭제)
	void communityDelete(int comm_seq) throws ClassNotFoundException, SQLException;
 

}
