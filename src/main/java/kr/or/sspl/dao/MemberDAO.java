package kr.or.sspl.dao;



import kr.or.sspl.dto.MemberDTO;


public interface MemberDAO {

	//회원가입
	int join(MemberDTO memberdto) ;
	
	//로그인
	void login(String user_id, String password);
	
	//유저 검색
	void userSelect(String password);
	
	//유저 정보 수정
	void userUpdate(MemberDTO memberdto);
	
}
