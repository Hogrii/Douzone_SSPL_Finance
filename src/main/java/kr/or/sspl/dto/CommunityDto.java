package kr.or.sspl.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommunityDto {
	private int comm_seq;
	private String user_id;
	private String comm_title;
	private String comm_content;
	private String comm_writen_date;
	private String comm_category;
	private int comm_view_count;	
}
