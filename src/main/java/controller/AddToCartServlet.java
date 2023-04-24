package controller;

import Cart.Cart;
import com.utar.model.entity.Product;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (PrintWriter out = response.getWriter()) {

            ArrayList<Cart> cartList = new ArrayList<>();
            String productcode = request.getParameter("productcode");
            out.println(productcode);
            Cart cart = new Cart();
            Product product = productSessionBeanLocal.getProduct(productcode);
            cart.setProduct(product);
            cart.setQuantity(1);
            HttpSession session = request.getSession();
            ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart_list");
            out.println(cart_list);
            if (cart_list == null || cart_list.isEmpty()) {
                cartList.add(cart);
                session.setAttribute("cart_list", cartList);
                out.println("added");
            } else {
                cartList = cart_list;
                boolean exist = false;
                for (Cart c : cart_list) {
                    out.println(c.product.getId());
                    if (c.product.getId().equals(productcode)) {
                        exist = true;
                        out.println("<h3 style='color:crimson; text-align: center'>Item Already in Cart. <a href='cart.jsp'>GO to Cart Page</a></h3>");
                    }
                }
                if (!exist) {
                    cartList.add(cart);
                    out.println("not exist, added");
                }
            }
        }
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
