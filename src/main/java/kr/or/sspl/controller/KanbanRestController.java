package kr.or.sspl.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.sspl.dto.LookupListDto;
import kr.or.sspl.service.KanbanService;

@RestController
@RequestMapping("/kanban/")
public class KanbanRestController {
	
	
	@Autowired
	private KanbanService kanbanService;
	
	@GetMapping("/kanban-board/{id}")
	public ResponseEntity<List<LookupListDto>> lookupList(@PathVariable(value = "id") String user_id) {
		
		System.out.println(user_id);
		
		List<LookupListDto> list = kanbanService.selectAll(user_id);
		
			
		return new ResponseEntity<List<LookupListDto>>(list, HttpStatus.OK);
	}
	
	@PutMapping("kanban-board")
	public ResponseEntity<String> kanbanUpdate(@RequestBody List<LookupListDto> list){
		
		
		
		System.out.println(list);
		kanbanService.kanbanUpdate(list);
		String msg = "성공";
		
		return new ResponseEntity<String>(msg, HttpStatus.OK);
		
	}
	
	@DeleteMapping("/kanban-board/{lookupListNo}")
	public ResponseEntity<String> kanbanDelete(@PathVariable(value = "lookupListNo") String lookup_list_num){
		
		System.out.println(lookup_list_num);
		String msg = kanbanService.kanbanDelete(lookup_list_num);
		
		return new ResponseEntity<String>(msg, HttpStatus.OK);
	}
	
}
