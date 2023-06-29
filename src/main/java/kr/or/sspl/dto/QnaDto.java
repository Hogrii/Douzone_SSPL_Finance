package kr.or.sspl.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnaDto {
	private int qna_seq;
	private String user_id;
	private String qna_title;
	private String qna_content;
	private Date qna_date;
	private String qna_category;
	private String qna_status;

}
