package kr.or.sspl.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;



import kr.or.sspl.dao.MemberDao;
import kr.or.sspl.dto.MemberDto;

@Service
public class MemberService {
	

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	private SqlSession sqlsession;
	
	@Autowired
	public void setSession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	
	public Map<String, String> idCheck(String id){
		Map<String, String> map = new HashMap<String, String>();
		
		String dupId =null;
		
		try {
			
			MemberDao dao = sqlsession.getMapper(MemberDao.class);
			dupId =  dao.idCheck(id);
			System.out.println(dupId);
			map.put("id", dupId);
		} catch (Exception e) {
		
			System.out.println(e.getMessage());
		}
		
		return map;
	}
	
	
	public Map<String, String> join(MemberDto memberdto) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		String duplicateEmail = null;
		String duplicatePhoneNumber = null;
		
	
		memberdto.setPassword(this.bCryptPasswordEncoder.encode(memberdto.getPassword()));
		try {
			
			MemberDao dao = sqlsession.getMapper(MemberDao.class);
			dao.join(memberdto);
			duplicateEmail = memberdto.getDuplicate_email();
		    duplicatePhoneNumber = memberdto.getDuplicate_phone_number();
			
			
		} catch (Exception e) {
		
			System.out.println(e.getMessage());
		}
		
		
		
		System.out.println("호출 후: "+memberdto.toString());
		System.out.println(memberdto.getDuplicate_phone_number());
		
		
		  if (duplicateEmail != null) {
	    	     map.put("message", duplicateEmail+"은 이미 사용되었습니다.");
	       	  }
		  if (duplicatePhoneNumber != null) {
        	  map.put("message", duplicatePhoneNumber+"은 이미 사용되었습니다.");
	       }
		  
		  if (duplicateEmail == null && duplicatePhoneNumber == null ){
	    	   map.put("message", memberdto.getName()+"님 회원가입 성공!");
	    
	       }
		  
	      
	      return map;
	 
		
	}

}
