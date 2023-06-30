package kr.or.sspl.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.sspl.dto.StockDto;
import kr.or.sspl.service.SearchService;

@Controller
@RequestMapping("/search/")
public class SearchController {
	
	private SearchService searchService;
	
	@Autowired
	public void setSearchService(SearchService searchService) {
		this.searchService = searchService;
	}
	
	@GetMapping("searchList.do")
	public String searchList() {
		return "search/search_list";
	}
	
	@GetMapping("searchKeyword.do")
	@ResponseBody
	public List<StockDto> searchList(String stock_name) {
		List<StockDto> stockList = new ArrayList<StockDto>();
		stockList = searchService.searchList(stock_name);
		System.out.println(stockList);
		return stockList;
	}
	
	@GetMapping("searchByCode.do")
	@ResponseBody
	public String searchByCode(String stock_code) {
		String jsonResponse = searchService.searchByCode(stock_code);
		return jsonResponse;
	}
	
	@GetMapping("searchDetail.do")
	public String searchDetail() {
		return "search/search_detail";
	}
}
