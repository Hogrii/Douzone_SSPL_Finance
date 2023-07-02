package kr.or.sspl.dto;

import lombok.Data;

@Data
public class SaveReqDto {
	private int comm_seq;
	private String comm_category;
	private String comm_title;
	private String comm_content;
	private String user_id;
}
