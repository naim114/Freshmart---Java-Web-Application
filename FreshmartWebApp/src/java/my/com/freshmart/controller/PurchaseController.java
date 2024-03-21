package my.com.freshmart.controller;

import freshmart.Purchase;
import freshmart.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class PurchaseController {

    Connection con = null;
    ResultSet rs = null;
    PreparedStatement ps = null;
    Statement st = null;

    String driverName = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/freshmart";
    String dbuser = "root";
    String dbpassword = "";

    public int addPurchase(
            int userId,
            String itemName,
            double price,
            String imgURL,
            int quantity
    ) throws ClassNotFoundException, SQLException {
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/freshmart", "root", "");

            // Use PreparedStatement to avoid SQL injection
            String purchaseSql = "INSERT INTO PURCHASE (USER_ID, ITEM_NAME, PRICE, IMG_URL, QUANTITY) VALUES (?, ?, ?, ?, ?)";

            try (PreparedStatement purchaseStatement = con.prepareStatement(purchaseSql, Statement.RETURN_GENERATED_KEYS)) {
                // Set parameters
                purchaseStatement.setInt(1, userId);
                purchaseStatement.setString(2, itemName);
                purchaseStatement.setDouble(3, price);
                purchaseStatement.setString(4, imgURL);
                purchaseStatement.setInt(5, quantity);

                // Execute the purchase SQL statement
                int rowsAffected = purchaseStatement.executeUpdate();

                if (rowsAffected > 0) {
                    // Retrieve the auto-generated keys (purchaseId)
                    ResultSet generatedKeys = purchaseStatement.getGeneratedKeys();

                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }
        }

        return -1; // Insertion failed
    }

    public List<Purchase> getPurchaseByUserId(int userId) {
        List<Purchase> purchaseList = new ArrayList<>();
        String sql = "SELECT * FROM purchase WHERE user_id = ?";

        try {
            Class.forName(driverName);
            con = DriverManager.getConnection(url, dbuser, dbpassword);
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int purchaseId = rs.getInt("purchase_id");
                String itemName = rs.getString("item_name");
                double price = rs.getDouble("price");
                String imgURL = rs.getString("img_url");
                int quantity = rs.getInt("quantity");
                Integer rate = rs.getInt("rating");
                String comment = rs.getString("comment");
                LocalDateTime createdAt = rs.getTimestamp("created_at").toLocalDateTime();

                // Create User object
                UserController uc = new UserController();
                User user = uc.getUserById(userId);

                // Create Purchase object
                Purchase purchase = new Purchase(purchaseId, user, itemName, price, imgURL, quantity, rate, comment, createdAt);

                purchaseList.add(purchase);
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

        return purchaseList;
    }

    public int ratePurchase(
            int purchaseId,
            int rating,
            String comment
    ) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/freshmart", "root", "");
        st = con.createStatement();
        String sql = "UPDATE PURCHASE SET RATING = '"
                + rating + "', COMMENT = '"
                + comment + "' WHERE PURCHASE_ID = " + purchaseId;
        int i = st.executeUpdate(sql);
        return i;
    }

    public List<Purchase> getAllPurchases() {
        List<Purchase> purchaseList = new ArrayList<>();
        String sql = "SELECT * FROM purchase";

        try {
            Class.forName(driverName);
            con = DriverManager.getConnection(url, dbuser, dbpassword);
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                int userId = rs.getInt("user_id");
                int purchaseId = rs.getInt("purchase_id");
                String itemName = rs.getString("item_name");
                double price = rs.getDouble("price");
                String imgURL = rs.getString("img_url");
                int quantity = rs.getInt("quantity");
                Integer rate = rs.getInt("rating");
                String comment = rs.getString("comment");
                LocalDateTime createdAt = rs.getTimestamp("created_at").toLocalDateTime();

                // Create User object
                UserController uc = new UserController();
                User user = uc.getUserById(userId);

                // Create Purchase object
                Purchase purchase = new Purchase(purchaseId, user, itemName, price, imgURL, quantity, rate, comment, createdAt);

                purchaseList.add(purchase);
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

        return purchaseList;
    }

}
