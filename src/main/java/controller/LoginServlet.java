package controller;

import com.utar.model.entity.Customer;
import com.utar.model.sessionbean.CustomerSessionBean;
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

    @EJB
    private CustomerSessionBean customerSessionBean;

    protected void doGet(HttpServletRequest request, HttpServletResponse response){
        String action = request.getParameter("action");
        if (action.equals("logout")) {
            HttpSession httpSession = request.getSession();
            httpSession.invalidate();
            try {
                response.sendRedirect("Login.jsp");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (loginSessionBean.authenticate(username, password))
        {

            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("username", username);
            httpSession.setAttribute("user_role", loginSessionBean.getUserRole(username));
            Customer info = customerSessionBean.findcustomer(username);
            httpSession.setAttribute("customer", info);
            response.sendRedirect("SuccesfullLogin.jsp");
        }
        else {
            request.setAttribute("error", "true");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}