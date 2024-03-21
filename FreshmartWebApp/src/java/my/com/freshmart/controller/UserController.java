package my.com.freshmart.controller;

import freshmart.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserController {

    Connection con = null;
    ResultSet rs = null;
    PreparedStatement ps = null;
    Statement st = null;

    String driverName = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/freshmart";
    String dbuser = "root";
    String dbpassword = "";

    public int addUserDataBase(
            String email,
            String name,
            String password,
            String tel_no,
            String address
    ) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/freshmart", "root", "");
        st = con.createStatement();
        int i = st.executeUpdate("INSERT INTO USER (EMAIL,USER_NAME,PASSWORD,TEL_NO,ADDRESS) VALUES ('" + email + "','" + name + "','" + password + "','" + tel_no + "','" + address + "')");
        return i;
    }

    public User getUserById(int userId) {
        User user = null;
        String sql = "select * from USER where USER_ID=?";

        try {
            Class.forName(driverName);
            con = DriverManager.getConnection(url, dbuser, dbpassword);
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Retrieve user details from the ResultSet
                int retrievedUserId = rs.getInt("USER_ID");
                String email = rs.getString("EMAIL");
                String userName = rs.getString("USER_NAME");
                String telNo = rs.getString("TEL_NO");
                String address = rs.getString("ADDRESS");
                boolean isAdmin = rs.getBoolean("IS_ADMIN");

                // Create a User object with the retrieved details
                user = new User(retrievedUserId, email, userName, telNo, address, isAdmin);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle the exception properly in your application
        } finally {
            try {
                // Close resources in the reverse order of their creation
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace(); // Handle the exception properly in your application
            }
        }

        return user;
    }

    public User validateUserOnDatabase(String inputEmail, String inputPassword) {
        System.out.println("entering validateUserOnDatabase...");

        User user = null;

        String sql = "select * from USER where EMAIL=? and PASSWORD=?";

        try {
            Class.forName(driverName);
            con = DriverManager.getConnection(url, dbuser, dbpassword);
            ps = con.prepareStatement(sql);
            ps.setString(1, inputEmail);
            ps.setString(2, inputPassword);
            rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("USER_ID");
                String email = rs.getString("EMAIL");
                String userName = rs.getString("USER_NAME");
                String telNo = rs.getString("TEL_NO");
                String address = rs.getString("ADDRESS");
                boolean isAdmin = rs.getBoolean("IS_ADMIN");

                user = new User(userId, email, userName, telNo, address, isAdmin);
//                System.out.print("@@@@@@@@@@@@@@@@@@@@@@");
////                System.out.print("userId: " + userId);
////                System.out.print("email: " + email);
////                System.out.print("isAdmin: " + isAdmin);
//                System.out.print("user: " + user);
//                System.out.print("@@@@@@@@@@@@@@@@@@@@@@");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        System.out.println("finished validateUserOnDatabase...");

        return user;
    }

    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM USER";

        try {
            Class.forName(driverName);
            con = DriverManager.getConnection(url, dbuser, dbpassword);
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                int userId = rs.getInt("USER_ID");
                String email = rs.getString("EMAIL");
                String userName = rs.getString("USER_NAME");
                String telNo = rs.getString("TEL_NO");
                String address = rs.getString("ADDRESS");
                boolean isAdmin = rs.getBoolean("IS_ADMIN");

                User user = new User(userId, email, userName, telNo, address, isAdmin);
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle the exception properly in your application
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace(); // Handle the exception properly in your application
            }
        }

        return userList;
    }

}
