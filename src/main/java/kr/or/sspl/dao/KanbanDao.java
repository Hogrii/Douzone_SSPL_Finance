package kr.or.sspl.dao;

import java.util.List;

import kr.or.sspl.dto.LookupListDto;

public interface KanbanDao {

	
	List<LookupListDto> selectAll(String user_id);
}

