package kr.or.sspl.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.sspl.dao.KanbanDao;
import kr.or.sspl.dao.MemberDao;
import kr.or.sspl.dto.LookupListDto;

@Service
public class KanbanService {
	
	private SqlSession sqlsession;

	@Autowired
	public void setSession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	public List<LookupListDto> selectAll(String user_id){
		
			List<LookupListDto> list = null; 
		try {
			
			KanbanDao dao = sqlsession.getMapper(KanbanDao.class);
			list = dao.selectAll(user_id);
			System.out.println(list);

		} catch (Exception e) {
		
			System.out.println(e.getMessage());
		}
		
		return list;
		
	}
	
	public String kanbanUpdate(List<LookupListDto> list) {
		
		String msg = null;
		try {
			
			System.out.println("서비스:"+list);
			KanbanDao dao = sqlsession.getMapper(KanbanDao.class);
			dao.kanbanUpdate(list);
			msg = "성공";

		} catch (Exception e) {
		
			System.out.println(e.getMessage());
		}
		
		return msg;
	}

}
