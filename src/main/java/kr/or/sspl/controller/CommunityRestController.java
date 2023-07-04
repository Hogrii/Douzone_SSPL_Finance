package kr.or.sspl.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.sspl.dao.CommunityDao;
import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.dto.CommunityReplyDto;
import kr.or.sspl.dto.CommunitySearchData;
import kr.or.sspl.service.CommunityService;

@RestController
@RequestMapping("/restcommunity/*")
public class CommunityRestController {
	@Autowired
	private CommunityService communityservice;

	private SqlSession sqlsession;

	@Autowired
	public void setSession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	@PostMapping("listSearch")
	public ResponseEntity<?> searchList(@RequestBody CommunitySearchData searchData, Model model)
			throws ClassNotFoundException, SQLException {
		System.out.println("restController 진입");
		String cp = searchData.getCpage();
		String ps = searchData.getPagesize();
		String field = searchData.getField();
		String query = searchData.getQuery();
		System.out.println("조회 field " + field);
		System.out.println("조회 query " + query);
		if (cp == null || cp.trim().equals("")) {
			cp = "1";
		}
		if (ps == null || ps.trim().equals("")) {
			ps = "5";
		}

		int pagesize = Integer.parseInt(ps);
		int cpage = Integer.parseInt(cp);

		int start = cpage * pagesize - (pagesize - 1); // 1*5 -(5-1) = 1
		int end = cpage * pagesize; // 1 * 5 = 5

		int searchTotalCount = communityservice.searchListTotal(model); // 전체 데이터\

		System.out.println("조회 총갯수 " + searchTotalCount);

		int pagecount = 0;

		if (searchTotalCount % pagesize == 0) {
			pagecount = searchTotalCount / pagesize;
		} else {
			pagecount = (searchTotalCount / pagesize) + 1;
		}

		Map<String, String> map = new HashMap<String, String>();
		map.put("start", Integer.toString(start));
		map.put("end", Integer.toString(end));
		map.put("field", field);
		map.put("query", query);
		System.out.println("map값 :" + map.toString());
		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		List<CommunityDto> searchList = comunityDao.searchList(searchData);
		/* 시간 부족으로 조회는 전체 데이터 출력으로 변경 */
		// System.out.println(list.toString());
		// model.addAttribute("list", searchList);
		// model.addAttribute("pagesize", pagesize);
		// model.addAttribute("pagecount", pagecount);
		// model.addAttribute("cpage", cpage);

		System.out.println(searchList.toString());

		try {
			List<CommunityDto> list = communityservice.getSearchList(searchData);
			System.out.println("값들어오냐고" + list);
			return new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
	}

	// 댓글조회
	@GetMapping("replySelect/{comm_seq}")
	public ResponseEntity<List<CommunityReplyDto>> ReplyList(@PathVariable int comm_seq) {
		List<CommunityReplyDto> list = new ArrayList<CommunityReplyDto>();
		try {
			System.out.println("정상실행");
			System.out.println("comm_seq 값: " + comm_seq);
			list = communityservice.communityReplyList(comm_seq);
			
			return new ResponseEntity<List<CommunityReplyDto>>(list, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<List<CommunityReplyDto>>(list, HttpStatus.BAD_REQUEST);
		}
	}

	//댓글 작성
	@PostMapping("replyInsert")
	public ResponseEntity<?> communityReplyInsert(@RequestBody CommunityReplyDto communityReplyDto,
			HttpServletRequest request) throws ClassNotFoundException, SQLException {
		int result = communityservice.communityReplyInsert(communityReplyDto);
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//댓글 삭제
	@GetMapping("replyDelete/{comm_reply_seq}")
	public ResponseEntity<?> communityReplyDelete(@PathVariable int comm_reply_seq) throws ClassNotFoundException, SQLException {
		System.out.println("댓글 삭제 컨트롤러 진입");
		//System.out.println(communityReplyDto.toString());
		int result = communityservice.ReplyDelete(comm_reply_seq);

		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	
	//대댓글 작성완료
	@PostMapping("reReplyInsert")
	public ResponseEntity<?> communityReReplyInsert(@RequestBody CommunityReplyDto communityReplyDto,
			HttpServletRequest request) throws ClassNotFoundException, SQLException {
		System.out.println("댓댓입력컨트롤러 진입");
		System.out.println(communityReplyDto.toString());
		int comm_seq = communityservice.getCommSeq(communityReplyDto.getComm_reply_seq()); //원본comm_seq 받아오기
		System.out.println("원본 글번호 "+comm_seq);
		communityReplyDto.setComm_seq(comm_seq);   
		System.out.println();
		int result = communityservice.communityReReplyInsert(communityReplyDto); //원본 25번 글과 댓글의 번호 가져가기
		System.out.println("입력갯수: "+result);
		 
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//대댓글 조회
	@GetMapping("reReplySelect/{comm_seq}")
	public ResponseEntity<List<CommunityReplyDto>> ReReplyList(@PathVariable int comm_seq) {
		List<CommunityReplyDto> list = new ArrayList<CommunityReplyDto>();
		try {
			System.out.println("rereply조회 정상실행");
			System.out.println("refer 값: " + comm_seq);
			
			list = communityservice.reReplyList(comm_seq);
			
			return new ResponseEntity<List<CommunityReplyDto>>(list, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<List<CommunityReplyDto>>(list, HttpStatus.BAD_REQUEST);
		}
	}
	 
	
	

}
