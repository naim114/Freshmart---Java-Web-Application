package my.com.freshmart.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import my.com.freshmart.controller.CartController;

public class CartAddServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        CartController cc = new CartController();

        int userId = Integer.parseInt(request.getParameter("user_id"));
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        boolean isSuccess = false;

        try {
            int i = cc.addCart(userId, itemId, quantity);

            if (i > 0) {
                System.out.println("Item is successfully added to the cart.");
                isSuccess = true;
            } else {
                System.out.println("Adding item to the cart failed.");
            }
        } catch (Exception sqe) {
            sqe.printStackTrace();
        } finally {
            // Close resources if needed
        }

        try {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            if (isSuccess) {
                request.setAttribute("success_msg", "Item added to cart!");
                RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");
                rd.forward(request, response);
            } else {
                out.print("Sorry, adding item to cart failed.");
                RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
                rd.include(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        processRequest(request, response);
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
        processRequest(request, response);
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
