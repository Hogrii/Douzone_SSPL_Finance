package kr.or.sspl.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnaReplyDto {
	private int qna_reply_seq;
	private int qna_seq;
	private String user_id;
	private String qna_reply_content;
	private Date qna_reply_date;
}
