package kr.or.sspl.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.sspl.dto.LookupListDto;

public interface LookupListDao {
	//검색종목 단일 조회(기존에 검색 리스트에 있는지 여부 확인)
	public LookupListDto selectSearchOne(Map<String, String> map) throws ClassNotFoundException, SQLException;
	//검색종목 리스트 조회
	public List<LookupListDto> selectSearchList(LookupListDto lookupList) throws ClassNotFoundException, SQLException;
	//검색종목 추가
	public int insertSearch(LookupListDto lookupList) throws ClassNotFoundException, SQLException;
	//검색종목 삭제
	public int deleteSearch(int lookup_list_num) throws ClassNotFoundException, SQLException;
	//즐겨찾기 등록
	public int updateFavorite(LookupListDto lookupList) throws ClassNotFoundException, SQLException;
}
