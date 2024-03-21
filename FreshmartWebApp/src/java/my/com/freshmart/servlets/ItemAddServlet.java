/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package my.com.freshmart.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import my.com.freshmart.controller.ItemController;

/**
 *
 * @author naimm
 */
public class ItemAddServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ItemController ic = new ItemController();

        String item_name = request.getParameter("item_name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String img_url = request.getParameter("img_url");

        boolean isSuccess = false;

        try {
            int i = ic.addItem(
                    item_name,
                    price,
                    description,
                    img_url
            );

            if (i > 0) {
                System.out.println("Item is successfully added to System.");
                isSuccess = true;
            } else {
                System.out.println("Item Addition is Failed.");
            }
        } catch (Exception sqe) {
            out.println("Error while Inserting Record : " + sqe);
        } finally {
            try {
                rs.close();
                st.close();
            } catch (Exception e) {
            }
        }

        try {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            if (isSuccess) {
                //response.sendRedirect("welcome.jsp");
                request.setAttribute("success_msg", "Item added!");
                RequestDispatcher rd = request.getRequestDispatcher("items.jsp");
                rd.forward(request, response);
            } else {
                out.print("Sorry Username addition failed.");
                //response.sendRedirect("error.jsp");
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
