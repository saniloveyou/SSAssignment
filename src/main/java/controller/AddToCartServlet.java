package controller;

import Cart.Cart;
import com.utar.model.entity.Order;
import com.utar.model.entity.Orderdetail;
import com.utar.model.entity.OrderdetailId;
import com.utar.model.entity.Product;
import com.utar.model.sessionbean.OrderSessionBean;
import com.utar.model.sessionbean.ProductSessionBean;
import com.utar.model.sessionbean.ProductSessionBeanLocal;

import javax.ejb.EJB;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "AddToCartServlet", value = "/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @EJB
    private ProductSessionBeanLocal productSessionBeanLocal;

    @EJB
    private OrderSessionBean orderSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        int ordernumber = 0;
        try (PrintWriter out = response.getWriter()) {
            Integer.parseInt((String) session.getAttribute("ordernumber"));
            if (ordernumber == 0) {
                ordernumber = orderSessionBean.getNextOrderNumber();
                session.setAttribute("ordernumber", ordernumber);
            }
        } catch (Exception e) {
            ordernumber = orderSessionBean.getNextOrderNumber();
            session.setAttribute("ordernumber", ordernumber);
        }

        int orderlinenumber = 1;
        try {
            orderlinenumber = Integer.parseInt((String) session.getAttribute("orderlinenumber"));
            if (orderlinenumber == 0) {
                orderlinenumber = 1;
                session.setAttribute("orderlinenumber", orderlinenumber);
            }
        } catch (Exception e) {
            orderlinenumber = 1;
            session.setAttribute("orderlinenumber", orderlinenumber);
        }


        ArrayList<Cart> cartList = new ArrayList<>();
        String productcode = request.getParameter("productcode");
        Cart cart = new Cart();
        Product product = productSessionBeanLocal.getProduct(productcode);
        Orderdetail orderdetail = new Orderdetail();
        OrderdetailId orderdetailId = new OrderdetailId();
        orderdetailId.setOrdernumber(ordernumber);
        orderdetailId.setProductcode(productcode);

        orderdetail.setId(orderdetailId);
        orderdetail.setPriceeach(product.getMsrp());
        orderdetail.setQuantityordered(1);
        orderdetail.setOrderlinenumber(1);


        ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart_list");

        if (cart_list == null || cart_list.isEmpty()) {
            cartList.add(cart);
            session.setAttribute("cart_list", cartList);

        } else {
            cartList = cart_list;
            boolean exist = false;
            for (Cart c : cart_list) {
                if (c.orderdetail.getProductcode().equals(productcode)) {
                    exist = true;
                }
            }
            if (!exist) {
                cartList.add(cart);
            }
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
