package my.com.freshmart.controller;

import freshmart.Cart;
import freshmart.Item;
import freshmart.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CartController {

    Connection con = null;
    ResultSet rs = null;
    PreparedStatement ps = null;
    Statement st = null;

    String driverName = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/freshmart";
    String dbuser = "root";
    String dbpassword = "";

    public int addCart(int userId, int itemId, int quantity) throws ClassNotFoundException, SQLException {
        Class.forName(driverName);
        con = DriverManager.getConnection(url, dbuser, dbpassword);
        st = con.createStatement();

        // Check if the item is already in the user's cart
        String checkCartSql = "SELECT * FROM CART WHERE USER_ID = ? AND ITEM_ID = ?";
        PreparedStatement checkCartPs = con.prepareStatement(checkCartSql);
        checkCartPs.setInt(1, userId);
        checkCartPs.setInt(2, itemId);
        ResultSet checkCartRs = checkCartPs.executeQuery();

        if (checkCartRs.next()) {
            // If the item is already in the cart, update the quantity
            String updateCartSql = "UPDATE CART SET QUANTITY = QUANTITY + ? WHERE USER_ID = ? AND ITEM_ID = ?";
            PreparedStatement updateCartPs = con.prepareStatement(updateCartSql);
            updateCartPs.setInt(1, quantity);
            updateCartPs.setInt(2, userId);
            updateCartPs.setInt(3, itemId);
            return updateCartPs.executeUpdate();
        } else {
            // If the item is not in the cart, insert a new row
            String insertCartSql = "INSERT INTO CART (USER_ID, ITEM_ID, QUANTITY) VALUES (?, ?, ?)";
            PreparedStatement insertCartPs = con.prepareStatement(insertCartSql);
            insertCartPs.setInt(1, userId);
            insertCartPs.setInt(2, itemId);
            insertCartPs.setInt(3, quantity);
            return insertCartPs.executeUpdate();
        }
    }

    public boolean deleteCart(int itemId, int userId) {
        boolean success = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/freshmart", "root", "");
            Statement st = con.createStatement();

            String sql = "DELETE FROM CART WHERE USER_ID = " + userId + " AND ITEM_ID = " + itemId;
            int rowsAffected = st.executeUpdate(sql);

            if (rowsAffected > 0) {
                success = true;
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Handle the exception properly in your application
        }

        return success;
    }

    public List<Cart> getCartByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String sql = "SELECT c.*, i.ITEM_NAME, i.PRICE, i.DESCRIPTION, i.IMG_URL "
                + "FROM CART c "
                + "INNER JOIN ITEM i ON c.ITEM_ID = i.ITEM_ID "
                + "WHERE c.USER_ID = ?";

        try {
            Class.forName(driverName);
            con = DriverManager.getConnection(url, dbuser, dbpassword);
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int cartId = rs.getInt("CART_ID");
                int quantity = rs.getInt("QUANTITY");

                // Extract item details
                int itemId = rs.getInt("ITEM_ID");
                String itemName = rs.getString("ITEM_NAME");
                double price = rs.getDouble("PRICE");
                String desc = rs.getString("DESCRIPTION");
                String imgURL = rs.getString("IMG_URL");

                // Create User and Item objects
                UserController uc = new UserController();
                User user = uc.getUserById(userId);
                Item item = new Item(itemId, itemName, price, desc, imgURL);

                // Create Cart object
                Cart cart = new Cart(cartId, user, item, quantity);
                cartList.add(cart);
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

        return cartList;
    }

}
