package controller;

import com.utar.model.entity.Customer;
import com.utar.model.entity.Product;
import com.utar.model.sessionbean.CustomerSessionBean;

import javax.ejb.EJB;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "PaymentNow", value = "/PaymentNow")
public class PaymentNow extends HttpServlet {

    @EJB
    private CustomerSessionBean customerbean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       try {
           Product p = (Product) request.getSession().getAttribute("product");
           Customer c = (Customer) request.getSession().getAttribute("customer");
           HttpSession session = request.getSession();
           String username = session.getAttribute("username").toString();
           String user_role = session.getAttribute("user_role").toString();
//           System.out.println("username: " + username);
//           System.out.println("user_role: " + user_role);

           if (user_role.equals("[user]")) {
               RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayPaymentUser.jsp");
               dispatcher.forward(request, response);
           }else {
                RequestDispatcher dispatcher = request.getRequestDispatcher("adminprompt.jsp");
                dispatcher.forward(request, response);
           }

       }catch (Exception e) {
           RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
           dispatcher.forward(request, response);
       }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String total = request.getParameter("total");
        String discount = request.getParameter("discount");

        request.setAttribute("total", total);
        request.setAttribute("discount", discount);




        RequestDispatcher dispatcher = request.getRequestDispatcher("paymentsuccesfull.jsp");
        dispatcher.forward(request, response);



    }
}
