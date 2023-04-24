package controller;

import Cart.Cart;
import com.utar.model.entity.Customer;
import com.utar.model.entity.Product;
import com.utar.model.sessionbean.OrderSessionBean;
import com.utar.model.sessionbean.PaymentSessionBean;
import com.utar.model.sessionbean.ProductSessionBeanLocal;

import javax.ejb.EJB;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


@WebServlet(name = "PaymentCart", value = "/PaymentCart")
public class PaymentCart extends HttpServlet {

    @EJB
    private PaymentSessionBean paymentbean;

    @EJB
    private ProductSessionBeanLocal productbean;

    @EJB
    private OrderSessionBean orderbean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();
            String username = session.getAttribute("username").toString();
            String user_role = session.getAttribute("user_role").toString();

            String productidcart = request.getParameter("productid");

            Product info =  productbean.getProduct(productidcart);
            session.setAttribute("product", info);

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
        String total = request.getParameter("total");
        String discount = request.getParameter("discount");
        request.setAttribute("total", total);
        request.setAttribute("discount", discount);
        Customer c = (Customer) request.getSession().getAttribute("customer");
        Product p = (Product) request.getSession().getAttribute("product");

        int check = paymentbean.getNextPaymentNumber();
        String today = new SimpleDateFormat("dd/MM/yyyy").format(new Date());
        Date date = new Date();


        //this section is for checkout
        String productidcart = request.getParameter("productid");
        String quantity = request.getParameter("quantity");

        String[]  s = {String.valueOf(c.getId()), String.valueOf(check), today,total};
        paymentbean.addPayment(s);

        String today1 = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        Date date1 = new Date();
        long t1 = date1.getTime();
        Date aftersixDays1 = new Date(t1 + (6 * 24 * 3600 * 1000));
        String requiredate1 = new SimpleDateFormat("yyyy-MM-dd").format(aftersixDays1);

        int check1 = orderbean.getNextOrderNumber();

        String[] s1 = {String.valueOf(check1), today1, requiredate1,requiredate1,"pending","0",String.valueOf(c.getId())};

        orderbean.addit(s1);

        RequestDispatcher dispatcher = request.getRequestDispatcher("paymentsuccesfull.jsp");
        dispatcher.forward(request, response);




    }
}
