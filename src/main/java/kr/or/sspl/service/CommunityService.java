package kr.or.sspl.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import kr.or.sspl.dao.CommunityDao;
import kr.or.sspl.dao.CommunityReplyDao;
import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.dto.CommunityReplyDto;
import kr.or.sspl.dto.CommunitySearchData;

@Service
public class CommunityService {

	private SqlSession sqlsession;

	@Autowired
	public void setSession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	// 전체 데이터 갯수
	public int CommunityCount(Model model) throws ClassNotFoundException, SQLException {
		int result = 0;
		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		result = comunityDao.communityCount();
		model.addAttribute("total", result);
		return result;
	}

	// 전체 게시판 보기
	public List<CommunityDto> getCommunityList(String cp, String ps, Model model) throws ClassNotFoundException, SQLException {

		if (cp == null || cp.trim().equals("")) {
			cp = "1";
		}
		if (ps == null || ps.trim().equals("")) {
			ps = "5";
		}
		int cpage = Integer.parseInt(cp); 
		int pagesize = Integer.parseInt(ps);
		
		int start = cpage * pagesize - (pagesize - 1); // 1*5 -(5-1) = 1
		int end = cpage * pagesize; // 1 * 5 = 5

		int totalcount = CommunityCount(model); // 전체 데이터
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

		for(int i=0; i<list.size(); i++) {
			System.out.println("그림포함 : " + list.get(i).getComm_content());
		}
		model.addAttribute("cp", cpage);
		model.addAttribute("ps", pagesize);
		model.addAttribute("list", list);
		model.addAttribute("pagecount", pagecount);
		
		System.out.println("cp : " +cp );
		System.out.println("ps : " +ps );
		 
		return list;
	}

	// 상세페이지
	public void getDetailList(int comm_seq, Model model, String cp, String ps) throws ClassNotFoundException, SQLException {
		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		CommunityDto communityDto = comunityDao.getDetailList(comm_seq);
		
		model.addAttribute("detaillist", communityDto);
		model.addAttribute("cp", cp);
		model.addAttribute("ps", ps);
		
	}
	
	public int addViewCount(int comm_seq) {
		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		int viewCount= comunityDao.addViewCount(comm_seq);
		return viewCount;
	}
	
	public int searchListTotal(Model model) throws ClassNotFoundException, SQLException {
		int result = 0;
		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		result = comunityDao.communityCount();
		model.addAttribute("searchTotal", result);
		return result;
	}

	// 비동기 조건 검색
	public List<CommunityDto> getSearchList(CommunitySearchData searchData)
			throws ClassNotFoundException, SQLException {
		System.out.println("여기타?");
		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		List<CommunityDto> list = comunityDao.searchList(searchData);
		System.out.println("왜 리스트 안받아와" + list);
		return list;
	}

	// 게시물 입력
	public int communityInsert(CommunityDto communityDto) throws ClassNotFoundException, SQLException {
		System.out.println(communityDto.toString());
		CommunityDao communityDao = sqlsession.getMapper(CommunityDao.class);
		int result = communityDao.communityInsert(communityDto);
		return result;

	}

	// 게시물 수정
	public int communityUpdate(CommunityDto communityDto) throws ClassNotFoundException, SQLException {
		System.out.println("업데이트 서비스 진입");
		CommunityDao communityDao = sqlsession.getMapper(CommunityDao.class);
		int result = communityDao.communityUpdate(communityDto);
		return result;
	}

	// 게시물 삭제
	public int communityDelete(int comm_seq) throws ClassNotFoundException, SQLException {
		System.out.println("삭제 서비스 진입");

		CommunityReplyDao communityReplyDao = sqlsession.getMapper(CommunityReplyDao.class);
		communityReplyDao.communityReplyDelete(comm_seq); // 댓글 우선 삭제
		CommunityDao communityDao = sqlsession.getMapper(CommunityDao.class);
		int result = communityDao.communityDelete(comm_seq); // 본 글 삭제
		System.out.println("무사귀가");
		return result;
	}

	// 댓글 조회
	public List<CommunityReplyDto> communityReplyList(int comm_seq) {
		System.out.println("댓글 서비스 옴");
		CommunityReplyDao communityReplyDao = sqlsession.getMapper(CommunityReplyDao.class);
		System.out.println("왜 안오냐");// 여기 안탐....
		List<CommunityReplyDto> list = communityReplyDao.communityReplyList(comm_seq);
		System.out.println(list.toString());
		return list;
	}

	// 댓글 입력
	public int communityReplyInsert(CommunityReplyDto communityReplyDto) throws ClassNotFoundException, SQLException {

		CommunityReplyDao communityReplyDao = sqlsession.getMapper(CommunityReplyDao.class);
		int result = communityReplyDao.communityReplyInsert(communityReplyDto);
		System.out.println(result + "입력완료");
		return result;

	}

	// 댓글 삭제
	public int ReplyDelete(int comm_reply_seq) throws ClassNotFoundException, SQLException {
		System.out.println("댓글 삭제 커트롤러");
		CommunityReplyDao communityReplyDao = sqlsession.getMapper(CommunityReplyDao.class);
		int result = communityReplyDao.ReplyDelete(comm_reply_seq);
		System.out.println(result + "삭제완료");
		return result;

	}

	// 대댓글 입력
	public int communityReReplyInsert(CommunityReplyDto communityReplyDto) throws ClassNotFoundException, SQLException {

		CommunityReplyDao communityReplyDao = sqlsession.getMapper(CommunityReplyDao.class);
		int result = communityReplyDao.communityReReplyInsert(communityReplyDto);
		System.out.println(result + "입력완료");
		return result;

	}
 
	// comm_seq 조회
	public int getCommSeq(int comm_reply_seq) throws ClassNotFoundException, SQLException {
		CommunityReplyDao communityReplyDao = sqlsession.getMapper(CommunityReplyDao.class);
		int result = communityReplyDao.getCommSeq(comm_reply_seq);
		return result;
	}

}