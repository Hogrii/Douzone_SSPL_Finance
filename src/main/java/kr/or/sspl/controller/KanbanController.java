package kr.or.sspl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/kanban/")
public class KanbanController {
	
	@GetMapping("/kanban_board.do")
	public String kanban() {		
		return "/kanban/kanban_board";
	}

}
