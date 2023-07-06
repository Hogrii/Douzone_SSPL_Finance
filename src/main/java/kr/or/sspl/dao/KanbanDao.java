package kr.or.sspl.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.sspl.dto.LookupListDto;

public interface KanbanDao {

	
	List<LookupListDto> selectAll(String user_id);
	
	void kanbanUpdate(@Param("list") List<LookupListDto> list);
	
	void kanbanDelete(String lookup_list_num);

	
}
