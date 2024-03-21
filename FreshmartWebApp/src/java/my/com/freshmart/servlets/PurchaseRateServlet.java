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
import my.com.freshmart.controller.PurchaseController;

public class PurchaseRateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PurchaseController pc = new PurchaseController();

        int purchase_id = Integer.parseInt(request.getParameter("purchase_id"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        boolean isSuccess = false;

        try {
            int i = pc.ratePurchase(purchase_id, rating, comment);

            if (i > 0) {
                System.out.println("Rate success");
                isSuccess = true;
            } else {
                System.out.println("Rate Failed.");
            }
        } catch (Exception sqe) {
            out.println("Error while Updating Record : " + sqe);
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
                request.setAttribute("success_msg", "Purchase rated!");
                RequestDispatcher rd = request.getRequestDispatcher("purchase.jsp");
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
