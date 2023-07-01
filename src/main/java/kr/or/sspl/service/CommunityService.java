package kr.or.sspl.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.or.sspl.dao.CommunityDao;
import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.dto.CommunitySearchData;

@Service
public class CommunityService {

	private SqlSession sqlsession;
	
	@Autowired
	public void setSession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	public int CommunityCount(Model model) throws ClassNotFoundException, SQLException {
		int result=0;
		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		result = comunityDao.communityCount();
		model.addAttribute("total", result);
		return result;
	}
	// 전체 게시판 보기
	public void getCommunityList(String ps, String cp, Model model) throws ClassNotFoundException, SQLException {

		if (cp == null || cp.trim().equals("")) {
			cp = "1";
		}
		if (ps == null || ps.trim().equals("")) {
			ps = "5";
		}
		int pagesize = Integer.parseInt(ps);
		int cpage = Integer.parseInt(cp);

		//System.out.println("pagesize : " + pagesize);
		//System.out.println("cpage : " + cpage);
		int start = cpage * pagesize - (pagesize - 1); // 1*5 -(5-1) = 1
		int end = cpage * pagesize; // 1 * 5 = 5

		int totalcount =  CommunityCount(model); // 전체 데이터
		int pagecount = 0;

		if (totalcount % pagesize == 0) {
			pagecount = totalcount / pagesize;
		} else {
			pagecount = (totalcount / pagesize) + 1;
		}

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);

		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		List<CommunityDto> list = comunityDao.list(map);

		//System.out.println(list.toString());
		model.addAttribute("list", list);
		model.addAttribute("pagesize", pagesize);
		model.addAttribute("pagecount", pagecount);
		model.addAttribute("cpage", cpage);
	}
	
	public void getDetailList(int comm_seq,Model model) throws ClassNotFoundException, SQLException {
		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		CommunityDto communityDto= comunityDao.getDetailList(comm_seq);
		model.addAttribute("detaillist", communityDto);
	}
	

	// 비동기 조건 검색 
	public List<CommunityDto> getSearchList(CommunitySearchData searchData) throws Exception  {
		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		Map<String, String> map = new HashMap<String, String>();
		map.put("field", searchData.getField());
		map.put("query", searchData.getQuery());
		List<CommunityDto> list = comunityDao.searchList(map);
		return list;
	}
//	// 게시물 입력
//	public void communityInsert(CommunityDto communityDto) throws ClassNotFoundException, SQLException{
//		CommunityDao comunityDao = sqlSession.getMapper(CommunityDao.class);
//		comunityDao.communityInsert(communityDto);
//	}
//	

}
