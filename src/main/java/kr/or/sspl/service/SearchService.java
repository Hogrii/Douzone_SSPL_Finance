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

import kr.or.sspl.dao.LookupListDao;
import kr.or.sspl.dao.SearchDao;
import kr.or.sspl.dto.LookupListDto;
import kr.or.sspl.dto.StockDto;

@Service
public class SearchService {

	private SqlSession sqlsession;

	@Autowired
	public void setSession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	//종목 이름으로 코드 검색
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
	
	//종목 코드로 상세 정보 검색
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
	
	//종목검색 상세 페이지 차트 데이터
	public String searchForChart(String stock_code, String category, String start_date, String end_date) {
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
	
	//기존 검색 목록에 있는지 여부 확인
	public LookupListDto searchLookupOne(String user_id, String stock_code) {
		LookupListDto lookupListDto = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_id", user_id);
		map.put("stock_code", stock_code);
		try {
			LookupListDao lookupListDao = sqlsession.getMapper(LookupListDao.class);
			lookupListDto = lookupListDao.selectSearchOne(map);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return lookupListDto;
	}
	
	//검색 목록에 추가
	public void insertSearch(LookupListDto lookupList) {
		try {
			LookupListDao lookupListDao = sqlsession.getMapper(LookupListDao.class);
			lookupListDao.insertSearch(lookupList);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}
	
	//즐겨찾기 등록/해제
	public LookupListDto updateFavorite(LookupListDto lookupList) {
		try {
			LookupListDao lookupListDao = sqlsession.getMapper(LookupListDao.class);
			lookupListDao.updateFavorite(lookupList);
			Map<String, String> map = new HashMap<String, String>();
			map.put("user_id", lookupList.getUser_id());
			map.put("stock_code", lookupList.getStock_code());
			lookupList = lookupListDao.selectSearchOne(map);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return lookupList;
	}
	
	//메인페이지 테이블 데이터
	public String searchForMainRankTable() {
		String jsonResponse = null;
		//국내주식기간별 시세 요청 주소
		String apiUrl = "volume-rank?";
		//GET방식 Query param 설정
		apiUrl += "FID_COND_MRKT_DIV_CODE=J"
				//조건 화면 분류 코드
				+ "&FID_COND_SCR_DIV_CODE=20171"
				//업종코드 0000(전체) 기타(업종코드)
				+ "&FID_INPUT_ISCD=0000"
				//분류 구분 코드 0(전체) 1(보통주) 2(우선주)
				+ "&FID_DIV_CLS_CODE=0"
				//소속 구분 코드(평균거래량_
				+ "&FID_BLNG_CLS_CODE=0"
				//대상 구분 코드	
				+ "&FID_TRGT_CLS_CODE=111111111"
				//대상 제외 구분 코드
				+ "&FID_TRGT_EXLS_CLS_CODE=000000"
				//입력 가격1
				+ "&FID_INPUT_PRICE_1="
				//입력 가격2
				+ "&FID_INPUT_PRICE_2="
				//거래량 수
				+ "&FID_VOL_CNT="
				//입력 날짜1
				+ "&FID_INPUT_DATE_1=";
		//국내주식기간별 시세 조회 코드
		String tr_id = "FHPST01710000";
		jsonResponse = connectAPI(apiUrl, tr_id);
		return jsonResponse;
	}
	
	//메인페이지 차트 데이터
	public String searchForMainChart(String industry_code, String start_date, String end_date) {
		String jsonResponse = null;
		//국내주식기간별 시세 요청 주소
		String apiUrl = "inquire-daily-indexchartprice?";
		//GET방식 Query param 설정
		//조건 시장 분류 코드
		apiUrl += "FID_COND_MRKT_DIV_CODE=U"
				//업종 상세코드 kospi : 0001 / kosdaq : 1001
				+ "&FID_INPUT_ISCD=" + industry_code
				//조회 시작 일자
				+ "&FID_INPUT_DATE_1=" + start_date
				//조회 종료 일자
				+ "&FID_INPUT_DATE_2=" + end_date
				//기간분류코드 D:일봉 W:주봉, M:월봉, Y:년봉
				+ "&FID_PERIOD_DIV_CODE=D";
		//국내주식기간별 시세 조회 코드
		String tr_id = "FHKUP03500100";
		jsonResponse = connectAPI(apiUrl, tr_id);
		return jsonResponse;
	}
	
	//한국투자 api
	public String connectAPI(String apiUrl, String tr_id) {
		String jsonResponse = null;
		 try {
	            URL url = new URL("https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/quotations/"+apiUrl);
	            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	            connection.setRequestMethod("GET");
	            
	            connection.setRequestProperty("content-type", "application/json; charset=utf-8");
	            connection.setRequestProperty("authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6IjE5YTliZjU0LTAxMmEtNGI5MC04MmY2LTI4NDA2YTI1MzIyMiIsImlzcyI6InVub2d3IiwiZXhwIjoxNjg4NDYwNjY1LCJpYXQiOjE2ODgzNzQyNjUsImp0aSI6IlBTc0VVN3BNbFA0bzBlTVJObVlVRzFBcTdDZmJDWjR1dVU4ZCJ9.b3qDLsbXifOtOqj5SiksqNZWSDY1BhmPos_m1zHaE5v1i55ItMmNMz_sptETyX58FREIfnmpsJ77msZ-j0Rh9w");
	            connection.setRequestProperty("appkey", "PSsEU7pMlP4o0eMRNmYUG1Aq7CfbCZ4uuU8d");
	            connection.setRequestProperty("appsecret", "3leesykWctdjLwK7bc482HezywI8js9ZjKMWPT23+5WPvzqi1UuTkaNQ6eU+jtiMw89CWiXCLWfOCgUsJxkAdwfm2PhdQH5lfvkHNfbdkj0hspZFYWhBIHtUT3IvQtyV9AF2Xl0g6p9QxR2B9mCd0rNZDkoknjQsZxf42NkWbISyBeL1VFE=");
	            connection.setRequestProperty("tr_id", tr_id);
	            if(tr_id.equals("FHPST01710000")) {
	            	connection.setRequestProperty("custtype", "P");
	            }
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
