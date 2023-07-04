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

	//���� �̸����� �ڵ� �˻�
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
	
	//���� �ڵ�� �� ���� �˻�
	public String searchByCode(String stock_code) {
		String jsonResponse = null;
		//�ֽ����簡 �ü� ��û �ּ�
		String apiUrl = "inquire-price?";
		//GET��� Query param ����
		//���� �з� �ڵ�
		apiUrl += "fid_cond_mrkt_div_code=J"
				//�����ڵ�
				+ "&fid_input_iscd="+stock_code;
		//Header ������
		//�ֽ����簡 �ü� ��ȸ �ڵ�
		String tr_id = "FHKST01010100";
		jsonResponse = connectAPI(apiUrl, tr_id);
		 return jsonResponse;
	}
	
	//����˻� �� ������ ��Ʈ ������
	public String searchForChart(String stock_code, String category, String start_date, String end_date) {
		String jsonResponse = null;
		//�����ֽıⰣ�� �ü� ��û �ּ�
		String apiUrl = "inquire-daily-itemchartprice?";
		//GET��� Query param ����
		//���� �з� �ڵ�
		apiUrl += "FID_COND_MRKT_DIV_CODE=J"
				//�����ڵ�
				+ "&FID_INPUT_ISCD=" + stock_code
				//�Է� ��¥ (����)
				+ "&FID_INPUT_DATE_1=" + start_date
				//�Է� ��¥ (����)
				+ "&FID_INPUT_DATE_2=" + end_date
				//�Ⱓ�з��ڵ�
				+ "&FID_PERIOD_DIV_CODE=" + category
				//�����ְ� ���ְ� ���� ����
				+ "&FID_ORG_ADJ_PRC=0";
		//�����ֽıⰣ�� �ü� ��ȸ �ڵ�
		String tr_id = "FHKST03010100";
		jsonResponse = connectAPI(apiUrl, tr_id);
		return jsonResponse;
	}
	
	//���� �˻� ��Ͽ� �ִ��� ���� Ȯ��
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
	
	//�˻� ��Ͽ� �߰�
	public void insertSearch(LookupListDto lookupList) {
		try {
			LookupListDao lookupListDao = sqlsession.getMapper(LookupListDao.class);
			lookupListDao.insertSearch(lookupList);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}
	
	//���ã�� ���/����
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
	
	//���������� ���̺� ������
	public String searchForMainRankTable() {
		String jsonResponse = null;
		//�����ֽıⰣ�� �ü� ��û �ּ�
		String apiUrl = "volume-rank?";
		//GET��� Query param ����
		apiUrl += "FID_COND_MRKT_DIV_CODE=J"
				//���� ȭ�� �з� �ڵ�
				+ "&FID_COND_SCR_DIV_CODE=20171"
				//�����ڵ� 0000(��ü) ��Ÿ(�����ڵ�)
				+ "&FID_INPUT_ISCD=0000"
				//�з� ���� �ڵ� 0(��ü) 1(������) 2(�켱��)
				+ "&FID_DIV_CLS_CODE=0"
				//�Ҽ� ���� �ڵ�(��հŷ���_
				+ "&FID_BLNG_CLS_CODE=0"
				//��� ���� �ڵ�	
				+ "&FID_TRGT_CLS_CODE=111111111"
				//��� ���� ���� �ڵ�
				+ "&FID_TRGT_EXLS_CLS_CODE=000000"
				//�Է� ����1
				+ "&FID_INPUT_PRICE_1="
				//�Է� ����2
				+ "&FID_INPUT_PRICE_2="
				//�ŷ��� ��
				+ "&FID_VOL_CNT="
				//�Է� ��¥1
				+ "&FID_INPUT_DATE_1=";
		//�����ֽıⰣ�� �ü� ��ȸ �ڵ�
		String tr_id = "FHPST01710000";
		jsonResponse = connectAPI(apiUrl, tr_id);
		return jsonResponse;
	}
	
	//���������� ��Ʈ ������
	public String searchForMainChart(String industry_code, String start_date, String end_date) {
		String jsonResponse = null;
		//�����ֽıⰣ�� �ü� ��û �ּ�
		String apiUrl = "inquire-daily-indexchartprice?";
		//GET��� Query param ����
		//���� ���� �з� �ڵ�
		apiUrl += "FID_COND_MRKT_DIV_CODE=U"
				//���� ���ڵ� kospi : 0001 / kosdaq : 1001
				+ "&FID_INPUT_ISCD=" + industry_code
				//��ȸ ���� ����
				+ "&FID_INPUT_DATE_1=" + start_date
				//��ȸ ���� ����
				+ "&FID_INPUT_DATE_2=" + end_date
				//�Ⱓ�з��ڵ� D:�Ϻ� W:�ֺ�, M:����, Y:���
				+ "&FID_PERIOD_DIV_CODE=D";
		//�����ֽıⰣ�� �ü� ��ȸ �ڵ�
		String tr_id = "FHKUP03500100";
		jsonResponse = connectAPI(apiUrl, tr_id);
		return jsonResponse;
	}
	
	//�ѱ����� api
	public String connectAPI(String apiUrl, String tr_id) {
		String jsonResponse = null;
		 try {
	            URL url = new URL("https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/quotations/"+apiUrl);
	            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	            connection.setRequestMethod("GET");
	            
	            connection.setRequestProperty("content-type", "application/json; charset=utf-8");
	            connection.setRequestProperty("authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6IjE2ZTc1MDBiLWRhZmMtNGU0Zi1hOWU1LTE2YWExNzViOWVjOCIsImlzcyI6InVub2d3IiwiZXhwIjoxNjg4NTQ2NDgyLCJpYXQiOjE2ODg0NjAwODIsImp0aSI6IlBTc0VVN3BNbFA0bzBlTVJObVlVRzFBcTdDZmJDWjR1dVU4ZCJ9.BoPoGK_XHP01qKMAbs-fQG857u1RlpXaj_KH9Se9wSRC4xdi4p8yFHEBvpFt2O3E-0I-eYYOMFDIaXrDM6AoaA");
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
