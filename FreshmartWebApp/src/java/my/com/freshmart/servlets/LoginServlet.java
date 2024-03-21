package my.com.freshmart.servlets;

import freshmart.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import my.com.freshmart.controller.UserController;

public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    Connection con = null;
    ResultSet rs = null;
    PreparedStatement ps = null;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) {
        UserController uc = new UserController();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("MyServlet service method: " + email);

        User loggedInUser = uc.validateUserOnDatabase(email, password);

        try {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");

            if (loggedInUser != null) {
                request.getSession().setAttribute("user", loggedInUser);

                RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
                rd.forward(request, response);
            } else {
                out.print("Sorry Username or Password error.");
                //response.sendRedirect("error.jsp");
                RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
                rd.include(request, response);
            }
        } catch (Exception e) {
            System.out.println("////////////// ERROR ON LOGIN //////////////");
            e.printStackTrace();
            System.out.println("////////////// ERROR ON LOGIN //////////////");
        }

        System.out.println("................Done in servlet................");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
