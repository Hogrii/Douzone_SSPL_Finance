package kr.or.sspl.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String searchList(String stock_name, Model model) {
		model.addAttribute("stock_name",stock_name);
		return "search/search_list";
	}
	
	@GetMapping("searchKeyword.do")
	@ResponseBody
	public List<StockDto> searchStockList(String stock_name) {
		List<StockDto> stockList = new ArrayList<StockDto>();
		stockList = searchService.searchList(stock_name);
		return stockList;
	}
	
	@GetMapping("searchByCode.do")
	@ResponseBody
	public String searchByCode(String stock_code) {
		String jsonResponse = searchService.searchByCode(stock_code);
		return jsonResponse;
	}
	
	@GetMapping("searchDetail.do")
	public String searchDetail(String stock_code, String stock_name, Model model) {
		model.addAttribute("stock_code", stock_code);
		model.addAttribute("stock_name", stock_name);
		return "search/search_detail";
	}
	
	@GetMapping("searchForChart.do")
	@ResponseBody
	public String searchForChart(String stock_code, String category, String start_date, String end_date) {
		String jsonResponse = searchService.searchForChart(stock_code, category, start_date, end_date);
		return jsonResponse;
	}
	
	@GetMapping("searchForMainRankTable.do")
	@ResponseBody
	public String searchForMainRankTable() {
		String jsonResponse = searchService.searchForMainRankTable();
		return jsonResponse;
	}
	
	@GetMapping("searchForMainChart.do")
	@ResponseBody
	public String searchForMainChart(String industry_code, String start_date, String end_date) {
		System.out.println(industry_code);
		System.out.println(start_date);
		System.out.println(end_date);
		String jsonResponse = searchService.searchForMainChart(industry_code, start_date, end_date);
		return jsonResponse;
	}
	
	
}
