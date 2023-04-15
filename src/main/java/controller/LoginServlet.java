package controller;

import com.utar.model.sessionbean.LoginSessionBean;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {

    @EJB
    private LoginSessionBean loginSessionBean;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String user_role = request.getParameter("user_role");

        System.out.println("username.." + username);
        System.out.println("password.." + password);
        if (loginSessionBean.authenticate(username, password))
        {
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("username", username);
            httpSession.setAttribute("user_role", user_role);
            response.sendRedirect("index.jsp");
        }
        else {
            request.setAttribute("error", "true");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}