package controller;

import com.utar.model.entity.Customer;
import com.utar.model.entity.Orderdetail;
import com.utar.model.sessionbean.OrderSessionBean;

import javax.ejb.EJB;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartServlet", value = "/CartServlet")
public class CartServlet extends HttpServlet {

    @EJB
    private OrderSessionBean orderSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        try {
            HttpSession session = request.getSession();
            String user_role = session.getAttribute("user_role").toString();

            if (!user_role.equals("[user]")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("adminprompt.jsp");
                dispatcher.forward(request, response);
                return;
            }
        }catch (Exception e) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        String customernumber = String.valueOf(customer.getId());

        List<Orderdetail> orderdetails = orderSessionBean.cartList(customernumber);
        request.setAttribute("orderdetails", orderdetails);
        request.getRequestDispatcher("Cart.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
