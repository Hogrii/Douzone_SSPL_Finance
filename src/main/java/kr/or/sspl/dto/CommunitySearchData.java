package kr.or.sspl.dto;

import lombok.Data;

@Data
public class CommunitySearchData {
	private String field;
	private String query;
	private String cpage;
	private String pagesize;
}
