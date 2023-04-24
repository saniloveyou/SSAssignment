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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (loginSessionBean.authenticate(username, password))
        {
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("username", username);
            httpSession.setAttribute("user_role", loginSessionBean.getUserRole(username));
            response.sendRedirect("SuccesfullLogin.jsp.jsp");
        }
        else {
            request.setAttribute("error", "true");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}