package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

//db�� �����ؼ� ó���ϱ� ���� Ŭ����
public class BbsDAO {
	//�����ͺ��̽��� �����ϰ� ���ִ� ��ü
	private Connection connection;
	//private PreparedStatement preparedStatement; //db�� �����ϴ� �޼ҵ尡 ���� ������ �浹�Ͼ �� �����Ƿ� �ּ�ó��
	private ResultSet resultSet;//������ ���� �� �ִ� ��ü
	//������
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";//������ǻ���� mysql���� ��Ʈ�� BBS�����ͺ��̽��� ������ �� �ֵ��� ��
			String dbID = "root";
			String dbPassword = "soo930";
			Class.forName("com.mysql.cj.jdbc.Driver"); //mysql�� ������ �� �ֵ��� ���ִ� ����̹� ���̺귯��
			connection = DriverManager.getConnection(dbURL, dbID, dbPassword); //����
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//���� �ۼ��� �� ������ �ð��� �ڵ����� �־��ֱ� ���� �޼ҵ�
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SQL);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				return resultSet.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return ""; //�����ͺ��̽� ����
	}
	
	//���� �Խñ� ��ȣ ��������
	//������ ���� �߻�: db���� �Խñ� �����ͼ� �ѷ��� �� �ֱ� �Խñ�id(������ �Խñ� �� ����)�� �ݿ��Ǳ� ������
	//				�Խñ��� ������ ����� �������� ��ư ��ɿ� �ݿ����� �ʴ´�.
	//				����> 12���� �� �� 2���� �������� ������ư�� �����ϸ� 2�������� �Ѿ�� 1���������� ������ 2���� ���� ���δ�.
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";//������ �Խñ��� ��ȣ�� �����´�.
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SQL);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				return resultSet.getInt(1);
			}
			return 1; //�Խñ��� �� ���� ���� ���
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;//�����ͺ��̽� ������ �߻��� ���
	}
	
	//���� ������ ������ �ذ��ϱ� ����
	//�������� ���� �Խñ��� ������ �����ִ� �޼ҵ�
	public int getAvailableBbsTotalCount() {
		String SQL = "SELECT COUNT(*) FROM BBS WHERE bbsAvailable = 1";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SQL);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				return resultSet.getInt(1);
			}
			return 0; //�Խñ��� �� ���� ���� ���
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;//�����ͺ��̽� ������ �߻��� ���
	}
	/*
	 * �������� ���� �Խñ� ���� print test
	public static void main(String[] args) {
		System.out.println(new BbsDAO().getTotalCount());
	}
	*/
	
	//�������� ���� ���� �Խñ� id�� �����´�.
	public int getAvailableNextBbsID(ArrayList<Bbs> list) {
		String SQL = "SELECT bbsID FROM BBS WHERE bbsAvailable = 1 AND bbsID < ? ORDER BY bbsID DESC";//������ �Խñ��� ��ȣ�� �����´�.
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setInt(1, list.get(list.size()-1).getBbsID());
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				return resultSet.getInt(1); //���� �������� �� ���̵��� �Խñ� ���� ���������Ѵ�.
			}
			return 1; //�Խñ��� �� ���� ���� ���
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;//�����ͺ��̽� ������ �߻��� ���
		
	}
	
	//���� �������� �Խñ۵��� ����Ʈ�� ��ȯ�ϴ� �޼ҵ�
	//ex>�Ķ���ͷ� 3�� ������ 2���������� ��µ� 20���� �Խñ��� list�� ���� ��ȯ�ȴ�.
	public ArrayList<Bbs> getPreviousList(int previousPageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 ORDER BY bbsID DESC LIMIT ?"; // db���� 10���� �����´�.
		ArrayList<Bbs> list = new ArrayList<>();
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setInt(1, (previousPageNumber-1) * 10);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				Bbs bbs = new Bbs();

				// sql����� ���� �Խñ� �ϳ��� ���� ó��
				bbs.setBbsID(resultSet.getInt(1));
				bbs.setBbsTitle(resultSet.getString(2));
				bbs.setUserID(resultSet.getString(3));
				bbs.setBbsDate(resultSet.getString(4));
				bbs.setBbsContent(resultSet.getString(5));
				bbs.setBbsAvailable(resultSet.getInt(6));

				list.add(bbs);
			}

			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;// db����
	}
	
	//db�Խñ��� ����Ʈ�� �����ͼ� ��ȯ�ϴ� �޼ҵ�
	//������ ���� �ذ��� ���� ����
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsID <= ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; //db���� 10���� �����´�.
		ArrayList<Bbs> resultList = new ArrayList<>();
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SQL);
			if(pageNumber == 1) {
				preparedStatement.setInt(1, getNext());
			}
			else {
				ArrayList<Bbs> list = new ArrayList<>();
				list = getPreviousList(pageNumber); //�ش� ������ ������ ��µ� �Խñ۵��� list�� �޴´�.
				preparedStatement.setInt(1, getAvailableNextBbsID(list)); //�ش� ���������� ��µǾ�� �� �Խñ�ID�� set
			}
			resultSet = preparedStatement.executeQuery();
			while(resultSet.next()) {
				Bbs bbs = new Bbs();
				
				//sql����� ���� �Խñ� �ϳ��� ���� ó��
				bbs.setBbsID(resultSet.getInt(1));
				bbs.setBbsTitle(resultSet.getString(2));
				bbs.setUserID(resultSet.getString(3));
				bbs.setBbsDate(resultSet.getString(4));
				bbs.setBbsContent(resultSet.getString(5));
				bbs.setBbsAvailable(resultSet.getInt(6));
				
				resultList.add(bbs);
			}
			return resultList;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;//db����
	}
	
	//�ĸ������� ��������ȣ�� �ִ��� �������� �˷��ִ� �޼ҵ�
	//������ ���� ����
	public boolean nextPage(int pageNumber) {
		
		if (getAvailableBbsTotalCount() - (pageNumber - 1) * 10 > 0) {
			return true;
		}else {
			return false;
		}
	}
	
	
	//�ۼ��� ���� db�� �����ϴ� �޼ҵ�
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setInt(1, getNext()); //�Խñ��� ��ȣ set
			preparedStatement.setString(2, bbsTitle);
			preparedStatement.setString(3, userID);
			preparedStatement.setString(4, getDate());
			preparedStatement.setString(5, bbsContent);
			preparedStatement.setInt(6, 1); // Available�� set
		
			return preparedStatement.executeUpdate(); //�����ߴٸ� 0�̻��� ��� ��ȯ
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;//db����
	}
	
	//�Խñ��� ������ Ŭ������ �� �ش� �Խñ���  �����ֱ� ���� �޼ҵ�
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setInt(1, bbsID); //�ش� �Խñ�id�� �����´�.
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				Bbs bbs = new Bbs();
				
				//sql����� ���� �Խñ� �ϳ��� ���� ó��
				bbs.setBbsID(resultSet.getInt(1));
				bbs.setBbsTitle(resultSet.getString(2));
				bbs.setUserID(resultSet.getString(3));
				bbs.setBbsDate(resultSet.getString(4));
				bbs.setBbsContent(resultSet.getString(5));
				bbs.setBbsAvailable(resultSet.getInt(6));
				
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null; //�ش� �Խñ��� �������� ���� ���
	}
	
	//�� ������ ���� �޼ҵ�
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setString(1, bbsTitle);
			preparedStatement.setString(2, bbsContent);
			preparedStatement.setInt(3, bbsID);
		
			return preparedStatement.executeUpdate(); //�����ߴٸ� 0�̻��� ��� ��ȯ
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;//db����
	}
	
	//�� ������ ���� �޼ҵ�
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setInt(1, bbsID);
		
			return preparedStatement.executeUpdate(); //�����ߴٸ� 0�̻��� ��� ��ȯ
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;//db����
	}
	
}