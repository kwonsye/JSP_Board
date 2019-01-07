package user;
//mysql의 DB에 대한 클래스
//하나의 데이터베이스를 관리하고 처리 할 수 있는 기법을 JSP에서 구현하는 것 = JavaBeans
public class User {
	private String userID;
	private String userPassword;
	private String userName;
	private String userGender;
	private String userEmail;
	
	//getter setter
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
}
