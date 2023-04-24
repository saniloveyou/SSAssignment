package controller;

import Cart.Cart;
import com.utar.model.entity.Customer;
import com.utar.model.entity.Product;
import com.utar.model.sessionbean.PaymentSessionBean;
import com.utar.model.sessionbean.ProductSessionBeanLocal;

import javax.ejb.EJB;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;


@WebServlet(name = "PaymentCart", value = "/PaymentCart")
public class PaymentCart extends HttpServlet {

    @EJB
    private PaymentSessionBean paymentbean;

    @EJB
    private ProductSessionBeanLocal productbean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();
            String username = session.getAttribute("username").toString();
            String user_role = session.getAttribute("user_role").toString();

            String productidcart = request.getParameter("productid");
            String quantity = request.getParameter("quantity");

            Product info =  productbean.getProduct(productidcart);
            session.setAttribute("product", info);

            System.out.println("this is info: " + info.getId());

            if (user_role.equals("[user]")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayPaymentcart.jsp");
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
        ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart_list");
        //this section is for checkout
        String productidcart = request.getParameter("productid");
        String quantity = request.getParameter("quantity");

//        String[]  s = {String.valueOf(c.getId()), String.valueOf(check), today,total};
//        paymentbean.addPayment(s);

    }
}
