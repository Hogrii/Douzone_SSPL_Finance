package kr.or.sspl.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import kr.or.sspl.dao.CommunityDao;
import kr.or.sspl.dto.CommunityDto;
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
	public ResponseEntity<?> searchList(@RequestBody CommunitySearchData searchData,Model model) throws ClassNotFoundException, SQLException{
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
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("start", Integer.toString(start));
		map.put("end", Integer.toString(end));
		map.put("field", field); 		
		map.put("query", query);
		System.out.println("map값 :" +map.toString());
		CommunityDao comunityDao = sqlsession.getMapper(CommunityDao.class);
		List<CommunityDto> searchList = comunityDao.searchList(searchData);
        /*시간 부족으로 조회는 전체 데이터 출력으로 변경 */
		// System.out.println(list.toString());
		//model.addAttribute("list", searchList);
		//model.addAttribute("pagesize", pagesize);
		//model.addAttribute("pagecount", pagecount);
		//model.addAttribute("cpage", cpage);
		
		System.out.println(searchList.toString());
		
		try {
			List<CommunityDto> list = communityservice.getSearchList(searchData);
			System.out.println("값들어오냐고"+list);
			return new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>("fail",HttpStatus.BAD_REQUEST);
		}
	}
	
	 

// 	 @GetMapping("listInsert")
// 	    public ResponseEntity<?> communityInsert(@RequestBody CommunityDto communityDto) throws ClassNotFoundException, SQLException{
// 	    	communityservice.communityInsert(communityDto);
//     	return new ResponseEntity<>(HttpStatus.OK);
//     }

	
}
