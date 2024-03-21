/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package my.com.freshmart.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import my.com.freshmart.controller.CartController;
import my.com.freshmart.controller.PurchaseController;

/**
 *
 * @author naimm
 */
public class PurchaseAddServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        System.out.println(".....................heree");

        response.setContentType("text/html;charset=UTF-8");
        PurchaseController pc = new PurchaseController();
        CartController cc = new CartController();

        int userId = Integer.parseInt(request.getParameter("user_id"));
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        String itemName = request.getParameter("item_name");
        double price = Double.parseDouble(request.getParameter("price"));
        String imgURL = request.getParameter("img_url");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try {
            // Call the addPurchase method
            int purchaseId = pc.addPurchase(userId, itemName, price, imgURL, quantity);

            if (purchaseId != -1) {
                cc.deleteCart(itemId, userId);
                //response.sendRedirect("welcome.jsp");
                request.setAttribute("success_msg", "Purchase successful!");
                RequestDispatcher rd = request.getRequestDispatcher("purchase.jsp");
                rd.forward(request, response);
            } else {
                response.sendRedirect("error.jsp?message=Purchase insertion failed");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            // Handle exceptions (e.g., log or redirect to an error page)
            ex.printStackTrace();
            response.sendRedirect("error.jsp?message=Internal Server Error");
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(PurchaseAddServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(PurchaseAddServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
