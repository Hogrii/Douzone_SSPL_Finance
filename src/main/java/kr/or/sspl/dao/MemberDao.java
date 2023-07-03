package kr.or.sspl.dao;



import java.util.Map;

import kr.or.sspl.dto.MemberDto;


public interface MemberDao {
	
	String idCheck(String id);

	//회원가입
	void join(MemberDto memberdto) ;
	
	//로그인
	void login(String user_id, String password);
	
	//유저 비밀번호 검사
	String userSelect(String id);
	
	//로그인 유저 정보 검색
	MemberDto userData(String id);
	
	//중복 데이터 체크
	String dupDataCheck(MemberDto dto);
	
	//유저 정보 갱신
	void userModify(MemberDto dto);
	
	
}
