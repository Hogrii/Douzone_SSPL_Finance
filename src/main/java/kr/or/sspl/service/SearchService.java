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
		//시장 분류 코드
		apiUrl += "fid_cond_mrkt_div_code=J"
				//종목코드
				+ "&fid_input_iscd="+stock_code;
		//Header 데이터
		//주식현재가 시세 조회 코드
		String tr_id = "FHKST01010100";
		jsonResponse = connectAPI(apiUrl, tr_id);
		 return jsonResponse;
	}
	
	public String searchForChart(String stock_code, String category, String start_date, String end_date) {
		System.out.println(stock_code+"/"+"/"+category+"/"+start_date+"/"+end_date);
		String jsonResponse = null;
		//국내주식기간별 시세 요청 주소
		String apiUrl = "inquire-daily-itemchartprice?";
		//GET방식 Query param 설정
		//시장 분류 코드
		apiUrl += "FID_COND_MRKT_DIV_CODE=J"
				//종목코드
				+ "&FID_INPUT_ISCD=" + stock_code
				//입력 날짜 (시작)
				+ "&FID_INPUT_DATE_1=" + start_date
				//입력 날짜 (종료)
				+ "&FID_INPUT_DATE_2=" + end_date
				//기간분류코드
				+ "&FID_PERIOD_DIV_CODE=" + category
				//수정주가 원주가 가격 여부
				+ "&FID_ORG_ADJ_PRC=0";
		//국내주식기간별 시세 조회 코드
		String tr_id = "FHKST03010100";
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
	            connection.setRequestProperty("authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6IjRjMWQzYWI0LWI1ZTctNDBmNS05ZDM3LWNkNDJlODJmZWI3NSIsImlzcyI6InVub2d3IiwiZXhwIjoxNjg4MzczMjY0LCJpYXQiOjE2ODgyODY4NjQsImp0aSI6IlBTc0VVN3BNbFA0bzBlTVJObVlVRzFBcTdDZmJDWjR1dVU4ZCJ9.J1vWcstJ1USFH4zlZvamo69J1GXxZm2NdS7vpsvpX9B1qXBrxeAQEC_SysHKlREiq6R8aGNFWMp0Hp96Wb7AiQ");
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
