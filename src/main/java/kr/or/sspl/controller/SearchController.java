package kr.or.sspl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/search/")
public class SearchController {
	
	@GetMapping("searchList.do")
	public String searchList() {
		return "search/search_list";
	}
	
	@GetMapping("searchDetail.do")
	public String searchDetail() {
		return "search/search_detail";
	}
}
