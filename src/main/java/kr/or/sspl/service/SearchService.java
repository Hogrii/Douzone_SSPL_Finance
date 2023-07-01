package kr.or.sspl.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.sspl.dao.SearchDao;
import kr.or.sspl.dto.StockDto;

@Service
public class SearchService {

	private SqlSession sqlsession;

	@Autowired
	public void setSession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	public List<StockDto> searchList(String stock_name) {
		List<StockDto> stockList = new ArrayList<StockDto>();
		try {
			SearchDao searchDao = sqlsession.getMapper(SearchDao.class);
			Map<String, String> map = new HashMap<String, String>();
			map.put("stock_name", stock_name);
			stockList = searchDao.searchList(map);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return stockList;
	}
	
	public String searchByCode(String stock_code) {
		String jsonResponse = null;
		//주식현재가 시세 요청 주소
		String apiUrl = "inquire-price?";
		//GET방식 Query param 설정
		apiUrl += "fid_cond_mrkt_div_code=J&fid_input_iscd="+stock_code;
		//Header 데이터
		//주식현재가 시세 조회 코드
		String tr_id = "FHKST01010100";
		jsonResponse = connectAPI(apiUrl, tr_id);
		 return jsonResponse;
	}
	
	//한국투자 api
	public String connectAPI(String apiUrl, String tr_id) {
		String jsonResponse = null;
		 try {
	            URL url = new URL("https://openapivts.koreainvestment.com:29443//uapi/domestic-stock/v1/quotations/"+apiUrl);
	            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	            connection.setRequestMethod("GET");
	            
	            connection.setRequestProperty("content-type", "application/json; charset=utf-8");
	            connection.setRequestProperty("authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6IjU0ZjE1ZmI2LTAyYjctNDE2MS04Y2UzLTJiZDBmNTQ5YTg1ZCIsImlzcyI6InVub2d3IiwiZXhwIjoxNjg4Mjg1MTExLCJpYXQiOjE2ODgxOTg3MTEsImp0aSI6IlBTc0VVN3BNbFA0bzBlTVJObVlVRzFBcTdDZmJDWjR1dVU4ZCJ9.gSXf4rgyJUN-9sxggq03RyYT53Ht-uVe-t1vUHj1xf6v2KMBRQSlbdPqjh6qOlLszCb2zBUD5R4kyNmjMgY5Qg");
	            connection.setRequestProperty("appkey", "PSsEU7pMlP4o0eMRNmYUG1Aq7CfbCZ4uuU8d");
	            connection.setRequestProperty("appsecret", "3leesykWctdjLwK7bc482HezywI8js9ZjKMWPT23+5WPvzqi1UuTkaNQ6eU+jtiMw89CWiXCLWfOCgUsJxkAdwfm2PhdQH5lfvkHNfbdkj0hspZFYWhBIHtUT3IvQtyV9AF2Xl0g6p9QxR2B9mCd0rNZDkoknjQsZxf42NkWbISyBeL1VFE=");
	            connection.setRequestProperty("tr_id", tr_id);
	            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
	            String line;
	            StringBuilder response = new StringBuilder();
	            while ((line = reader.readLine()) != null) {
	                response.append(line);
	            }	
	            reader.close();

	            jsonResponse = response.toString();
	        } catch (Exception e) {
	        	System.out.println(e.getMessage());
	            e.printStackTrace();
	        }
		 System.out.println(jsonResponse);
		 return jsonResponse;
	}
}
