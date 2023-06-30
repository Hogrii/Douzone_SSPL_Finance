package kr.or.sspl.dao;



import kr.or.sspl.dto.MemberDto;


public interface MemberDao {

	//회원가입
	int join(MemberDto memberdto) ;
	
	//로그인
	void login(String user_id, String password);
	
	//유저 검색
	void userSelect(String password);
	
	//유저 정보 수정
	void userUpdate(MemberDto memberdto);
	
}