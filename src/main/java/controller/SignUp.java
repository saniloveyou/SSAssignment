package controller;

import com.utar.model.entity.Customer;
import com.utar.model.entity.User;
import com.utar.model.sessionbean.CustomerSessionBean;
import com.utar.model.sessionbean.OrderSessionBean;
import com.utar.model.sessionbean.SignUpSessionBean;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

@WebServlet(name = "SignUp", value = "/SignUp")
public class SignUp extends HttpServlet {

    @EJB
    private SignUpSessionBean signUpSessionBean;

    @EJB
    private CustomerSessionBean customerSessionBean;

    @EJB
    private OrderSessionBean orderSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int cusnum = customerSessionBean.getNextOrderNumber();
        System.out.println("cusnum: " + cusnum);
        String cusnumStr = String.valueOf(cusnum);
        HttpSession session = request.getSession();
        session.setAttribute("customernumber",cusnumStr);

        RequestDispatcher req = request.getRequestDispatcher("SignUp.jsp");
        req.include(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id = request.getParameter("ids");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String phone = request.getParameter("phone");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zip = request.getParameter("zip");
        String country = request.getParameter("country");
        String creditlimit = request.getParameter("creditlimit");

        String[] s = {id,username,password,firstname,lastname,phone,address1,address2,city,state,zip,country,creditlimit};

       Boolean flag = signUpSessionBean.addSignUp(s);

       if (flag){
           request.setAttribute("flag","True");
           RequestDispatcher req = request.getRequestDispatcher("SignUp.jsp");
           req.forward(request, response);
       }
       else
       {
           request.setAttribute("flag","False");
           RequestDispatcher req = request.getRequestDispatcher("SignUp.jsp");
           req.forward(request, response);
       }
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("username", username);
        httpSession.setAttribute("user_role", "user");
        Customer info = customerSessionBean.findcustomer(username);
        httpSession.setAttribute("customer", info);
        request.getSession().setAttribute("cartcount", orderSessionBean.cartCount(String.valueOf(info.getId())));

    }

}
