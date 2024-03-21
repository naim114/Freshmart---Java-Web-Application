package my.com.freshmart.controller;

import freshmart.Item;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ItemController {

    Connection con = null;
    ResultSet rs = null;
    PreparedStatement ps = null;
    Statement st = null;

    String driverName = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/freshmart";
    String dbuser = "root";
    String dbpassword = "";

    public int addItem(
            String item_name,
            double price,
            String description,
            String img_url
    ) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/freshmart", "root", "");
        st = con.createStatement();
        String sql = "INSERT INTO ITEM (ITEM_NAME, PRICE, DESCRIPTION, IMG_URL) VALUES ('"
                + item_name + "', '"
                + price + "', '"
                + description + "', '"
                + img_url + "')";
        int i = st.executeUpdate(sql);
        return i;
    }

    public int editItem(
            int itemId,
            String item_name,
            double price,
            String description,
            String img_url
    ) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/freshmart", "root", "");
        st = con.createStatement();
        String sql = "UPDATE ITEM SET ITEM_NAME = '"
                + item_name + "', PRICE = '"
                + price + "', DESCRIPTION = '"
                + description + "', IMG_URL = '"
                + img_url + "' WHERE ITEM_ID = " + itemId;
        int i = st.executeUpdate(sql);
        return i;
    }

    public boolean deleteItem(int itemId) {

        System.out.println("controller");
        boolean success = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/freshmart", "root", "");
            Statement st = con.createStatement();

            String sql = "DELETE FROM ITEM WHERE ITEM_ID = " + itemId;
            int rowsAffected = st.executeUpdate(sql);

            if (rowsAffected > 0) {
                success = true;
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Handle the exception properly in your application
        }

        return success;
    }

    public List<Item> getAllItems() {
        List<Item> itemList = new ArrayList<>();
        String sql = "SELECT * FROM ITEM";

        try {
            Class.forName(driverName);
            con = DriverManager.getConnection(url, dbuser, dbpassword);
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                int itemId = rs.getInt("ITEM_ID");
                String itemName = rs.getString("ITEM_NAME");
                double price = rs.getDouble("PRICE");
                String desc = rs.getString("DESCRIPTION");
                String imgURL = rs.getString("IMG_URL");

                Item item = new Item(itemId, itemName, price, desc, imgURL);
                itemList.add(item);
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

        return itemList;
    }

    public Item getItemById(int itemId) {
        Item item = null;
        String sql = "SELECT * FROM ITEM WHERE ITEM_ID = ?";

        try {
            Class.forName(driverName);
            con = DriverManager.getConnection(url, dbuser, dbpassword);
            ps = con.prepareStatement(sql);
            ps.setInt(1, itemId);
            rs = ps.executeQuery();

            if (rs.next()) {
                String itemName = rs.getString("ITEM_NAME");
                double price = rs.getDouble("PRICE");
                String desc = rs.getString("DESCRIPTION");
                String imgURL = rs.getString("IMG_URL");

                item = new Item(itemId, itemName, price, desc, imgURL);
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

        return item;
    }

}
