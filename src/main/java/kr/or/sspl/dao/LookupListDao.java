package kr.or.sspl.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.sspl.dto.LookupListDto;

public interface LookupListDao {
	//�˻����� ���� ��ȸ(������ �˻� ����Ʈ�� �ִ��� ���� Ȯ��)
	public LookupListDto selectSearchOne(Map<String, String> map) throws ClassNotFoundException, SQLException;
	//�˻����� ����Ʈ ��ȸ
	public List<LookupListDto> selectSearchList(LookupListDto lookupList) throws ClassNotFoundException, SQLException;
	//�˻����� �߰�
	public int insertSearch(LookupListDto lookupList) throws ClassNotFoundException, SQLException;
	//�˻����� ����
	public int deleteSearch(int lookup_list_num) throws ClassNotFoundException, SQLException;
	//���ã�� ���
	public int updateFavorite(LookupListDto lookupList) throws ClassNotFoundException, SQLException;
}
