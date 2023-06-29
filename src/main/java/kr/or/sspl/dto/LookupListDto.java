package kr.or.sspl.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LookupListDto {
	private int lookup_list_num;
	private String user_id;
	private int lookup_category_num;
	private String stock_code;
	private Date lookup_list_date;
	private int lookup_list_order;
}
