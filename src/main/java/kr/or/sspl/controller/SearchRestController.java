package kr.or.sspl.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.sspl.service.SearchService;

@RestController
@RequestMapping("/main/")
public class SearchRestController {
	
	private SearchService searchService;
	
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
		System.out.println(industry_code);
		System.out.println(start_date);
		System.out.println(end_date);
		String jsonResponse = searchService.searchForMainChart(industry_code, start_date, end_date);
		return jsonResponse;
	}
}
