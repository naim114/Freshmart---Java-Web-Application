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
import my.com.freshmart.controller.UserController;

//This Servlet is without using Annotation
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) {
        UserController uc = new UserController();

        String email = request.getParameter("email");
        String name = request.getParameter("user_name");
        String password = request.getParameter("password");
        String tel_no = request.getParameter("tel_no");
        String address = request.getParameter("address");

        boolean isSuccess = false;

        try {
            int i = uc.addUserDataBase(
                    email,
                    name,
                    password,
                    tel_no,
                    address
            );

            if (i > 0) {
                System.out.println("User is successfully added to System.");
                isSuccess = true;
            } else {
                System.out.println("User Addition is Failed.");
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
                request.setAttribute("success_msg", "Registration sucess! Please login.");
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
