package controller;

import Cart.Cart;
import com.utar.model.entity.*;
import com.utar.model.sessionbean.OrderSessionBean;
import com.utar.model.sessionbean.ProductSessionBean;
import com.utar.model.sessionbean.ProductSessionBeanLocal;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddToCartServlet", value = "/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @EJB
    private ProductSessionBeanLocal productSessionBeanLocal;

    @EJB
    private OrderSessionBean orderSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        String productcode = request.getParameter("productcode");

        int ordernumber = 0;
        try {
            ordernumber = session.getAttribute("ordernumber") == null ? orderSessionBean.getNextOrderNumber() : (int) session.getAttribute("ordernumber");
        } catch (EJBException e) {
            System.out.println("Error getting next order number");
        }
        session.setAttribute("ordernumber", ordernumber);


        Customer customer = (Customer) session.getAttribute("customer");
        int customernumber = customer.getId();

        try {
            orderSessionBean.addOrder(ordernumber, customernumber);
        } catch (EJBException e) {
            System.out.println("Error adding order");
        }

        try {
            orderSessionBean.addOrderDetails(ordernumber, productcode);
        } catch (EJBException e) {
            System.out.println("Error adding order details");
        }

        List<Orderdetail> orderdetails = orderSessionBean.readOrderdetail(ordernumber);
        session.setAttribute("cart_list", orderdetails);

        PrintWriter out = response.getWriter();
        out.println("<h1>Added to cart</h1>");
        // refresh page
        response.setHeader("Refresh", "1; URL=index.jsp");
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
