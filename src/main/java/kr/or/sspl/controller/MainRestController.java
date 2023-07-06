package kr.or.sspl.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.sspl.dto.CommunityDto;
import kr.or.sspl.dto.QnaDto;
import kr.or.sspl.service.CommunityService;
import kr.or.sspl.service.QnaService;
import kr.or.sspl.service.SearchService;

@RestController
@RequestMapping("/main/")
public class MainRestController {
	
	private SearchService searchService;
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private CommunityService communityservice;
	
	@Autowired
	public void setSearchService(SearchService searchService) {
		this.searchService = searchService;
	}
	
	@GetMapping("searchForMainRankTable.do")
	public String searchForMainRankTable() {
		String jsonResponse = searchService.searchForMainRankTable();
		return jsonResponse;
	}
	
	@GetMapping("searchForMainChart.do")
	public String searchForMainChart(String industry_code, String start_date, String end_date) {
		String jsonResponse = searchService.searchForMainChart(industry_code, start_date, end_date);
		return jsonResponse;
	}
	
	// 메인 페이지 리스트 출력
	@GetMapping("qnaGetList.do")
	public List<QnaDto> qnaGetList(Model model, HttpServletRequest reqeust) {
		List<QnaDto> qnaList = qnaService.qnaList(model, reqeust);
		return  qnaList;
	}
	
	// 메인 페이지 커뮤리스트 출력
	@GetMapping("commGetList.do")
	public List<CommunityDto> CommunityList(String ps, String cp, Model model) throws ClassNotFoundException, SQLException {
		List<CommunityDto> commList = communityservice.getCommunityList(ps, cp, model);
		return commList;
	}
}
