package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//JSP에서 회원데이터베이스에 접근할 수 있도록 만든 class
//회원DB에 넣거나 DB조회하는 역할
//데이터베이스 접근 객체
public class UserDAO {
	//데이터베이스에 접근하게 해주는 객체
	private Connection connection;
	private PreparedStatement preparedStatement;
	private ResultSet resultSet;//정보를 담을 수 있는 객체

	//생성자
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";//로컬컴퓨터의 mysql서버 포트의 BBS데이터베이스에 접근할 수 있도록 함
			String dbID = "root";
			String dbPassword = "soo930";
			Class.forName("com.mysql.cj.jdbc.Driver"); //mysql에 접근할 수 있도록 해주는 드라이버 라이브러리
			connection = DriverManager.getConnection(dbURL, dbID, dbPassword); //접속
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//로그인을 시도하는 메소드
	public int login(String userID, String userPassword) {
		//실제 SQL에 입력할 명령어
		String SQL = "SELECT userPassword FROM USER WHERE userID=?";
		try {
			//해킹방지
			preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setString(1,userID); //SQL의 ?에 파라미터로 넘어온 userID를 넣고 쿼리함
			resultSet = preparedStatement.executeQuery(); //여기선 해당 userID에 대한 비밀번호가 저장됨
			
			//해당 아이디의 회원이 있으면
			if(resultSet.next()) {
				if(resultSet.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else {
					return 0; //비밀번호 불일치
				}
			}
			return -1; //아이디 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	//회원가입을 처리하는 메소드
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?)";
		try {
			preparedStatement = connection.prepareStatement(SQL);
			//SQL의 ?에 들어갈 내용 set해주기
			preparedStatement.setString(1, user.getUserID());
			preparedStatement.setString(2, user.getUserPassword());
			preparedStatement.setString(3, user.getUserName());
			preparedStatement.setString(4, user.getUserGender());
			preparedStatement.setString(5, user.getUserEmail());
			
			return preparedStatement.executeUpdate(); //쿼리를 실행하고 결과 상태를 리턴(성공적으로 실행했으면 0이상의 값을 리턴)
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 = 이미 db에 있는 primary key가 중복된 경우
		
	}
}
