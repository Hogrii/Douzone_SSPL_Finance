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
	      	  }else if(duplicatePhoneNumber != null) {
		           	 map.put("message", duplicatePhoneNumber+"은 이미 사용되었습니다.");
		   	  }else if(duplicateEmail == null && duplicatePhoneNumber == null ){
			   	   	 map.put("message", memberdto.getName()+"님 회원가입 성공!");
			  }
			
		 
		  
		
	      return map;
	}
	
	public boolean userSelect(String id, String password) {
		
		String en_password = "";
		boolean result = false;
		
		try {
			
			MemberDao dao = sqlsession.getMapper(MemberDao.class);
			en_password = dao.userSelect(id);
			
			result = bCryptPasswordEncoder.matches(password, en_password);
			System.out.println(en_password +","+ result);
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
		}
		
		return result;
	}
	
	public MemberDto userData(String id) {
		
		MemberDto dto = null;
		
		try {
			
			MemberDao dao = sqlsession.getMapper(MemberDao.class);
			dto = dao.userData(id);
			
			
			System.out.println(dto.toString());
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
		}
		
		return dto;
		
		
	}
	
	public Map<String, String>  dupDataCheck(MemberDto dto) {
		
		Map<String, String> map = new HashMap<String, String>();
		String duplicateEmail = null;
		String duplicatePhoneNumber = null;
		try {
			
			MemberDao dao = sqlsession.getMapper(MemberDao.class);
		    dao.dupDataCheck(dto);
		    
		    duplicateEmail = dto.getDuplicate_email();
		    duplicatePhoneNumber = dto.getDuplicate_phone_number();
			
			System.out.println(dto.toString());
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
		}
		
		 if (duplicateEmail != null) {
    	     map.put("message", duplicateEmail+"은 이미 사용되었습니다.");
      	  }else if(duplicatePhoneNumber != null) {
	           	 map.put("message", duplicatePhoneNumber+"은 이미 사용되었습니다.");
	   	  }else if(duplicateEmail == null && duplicatePhoneNumber == null ){
	   		  map.put("message", "null");
		  }
		
	
		
		return map;
	}
	
	public Map<String, String>  userModify(MemberDto dto) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		String msg = "";
		
		try {
				
			MemberDao dao = sqlsession.getMapper(MemberDao.class);
		    dao.userModify(dto);
		   
			System.out.println("갱신:"+dto.toString());
			msg = "수정 완료 되었습니다!";
			map.put("message", msg);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return  map;
	}

}
