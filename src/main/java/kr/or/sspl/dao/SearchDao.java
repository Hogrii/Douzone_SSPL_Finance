package kr.or.sspl.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.sspl.dto.StockDto;

public interface SearchDao {
	public List<StockDto> searchList(Map<String, String> map) throws ClassNotFoundException, SQLException;
}
