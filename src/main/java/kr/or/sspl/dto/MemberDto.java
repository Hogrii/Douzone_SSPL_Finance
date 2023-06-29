package kr.or.sspl.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberDto {
	private String user_id;
	private String password;
	private String name;
	private String email;
	private Date join_date;
	private int enabled;
	private String phone_number;

}
