package freshmart;

public class User {

    private int userId;
    private String email;
    private String userName;
    private String telNo;
    private String address;
    private boolean isAdmin;

    public User(int userId, String email, String userName, String telNo, String address, boolean isAdmin) {
        this.userId = userId;
        this.email = email;
        this.userName = userName;
        this.telNo = telNo;
        this.address = address;
        this.isAdmin = isAdmin;
    }

    @Override
    public String toString() {
        return "User{"
                + "userId=" + userId
                + ", email='" + email + '\''
                + ", userName='" + userName + '\''
                + ", telNo='" + telNo + '\''
                + ", address='" + address + '\''
                + ", isAdmin=" + isAdmin
                + '}';
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getTelNo() {
        return telNo;
    }

    public void setTelNo(String telNo) {
        this.telNo = telNo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

}
