package kr.or.sspl.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;



import kr.or.sspl.dao.MemberDAO;
import kr.or.sspl.dto.MemberDTO;

@Service
public class MemberService {
	

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	private SqlSession sqlsession;
	
	@Autowired
	public void setSession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	
	public int join(MemberDTO memberdto) {
		
		int loginResult = 0;
		memberdto.setEnabled(1);
		memberdto.setPassword(this.bCryptPasswordEncoder.encode(memberdto.getPassword()));
		try {
			
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			loginResult =dao.join(memberdto);
			System.out.println(loginResult);
			
		} catch (Exception e) {
			System.out.println(loginResult);
			System.out.println("오류");
			System.out.println(e.getMessage());
		}
		
		return loginResult;
		
	}

}
