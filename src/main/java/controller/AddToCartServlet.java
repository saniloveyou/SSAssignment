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

        try {
            HttpSession session = request.getSession();
            String user_role = session.getAttribute("user_role").toString();

            if (!user_role.equals("[user]")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("adminprompt.jsp");
                dispatcher.forward(request, response);
            }
        }catch (Exception e) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
            dispatcher.forward(request, response);
        }

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        String customernumber = "";
        try {
            customernumber = String.valueOf(customer.getId());
        } catch (Exception e) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
            dispatcher.forward(request, response);
        }
        String productcode = request.getParameter("productcode");

        System.out.println("customernumber: " + customernumber);

        int ordernumber = 0;
        try {
            ordernumber = session.getAttribute("ordernumber") == null ? orderSessionBean.getNextOrderNumber(customernumber) : (int) session.getAttribute("ordernumber");
            session.setAttribute("ordernumber", ordernumber);
        } catch (EJBException e) {
            System.out.println("Error getting next order number");
        }


        // check if product is already in cart
        if (orderSessionBean.findOrderdetail(String.valueOf(ordernumber), productcode) != null) {
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Product already in cart');");
            out.println("</script>");
            response.setHeader("Refresh", "0; URL=ProductHomeDisplayServlet");
            return;
        }


        try {
            orderSessionBean.addOrder(ordernumber, Integer.parseInt(customernumber));
        } catch (EJBException e) {
            System.out.println("Error adding order");
        }

        try {
            orderSessionBean.addOrderDetails(ordernumber, productcode);
        } catch (EJBException e) {
            System.out.println("Error adding order details");
        }

        PrintWriter out = response.getWriter();
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Product added to cart');");
        out.println("</script>");

        request.getSession().setAttribute("cartcount", orderSessionBean.cartCount(String.valueOf(customer.getId())));

        response.setHeader("Refresh", "0; URL=ProductHomeDisplayServlet");
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
