package kr.or.sspl.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommunityReplyDto {
	private int comm_reply_seq;
	private int comm_seq;
	private String user_id;
	private String comm_reply_content;
	private String comm_reply_writen_date;
	private int step;
	private int refer;
	private int depth;
}
