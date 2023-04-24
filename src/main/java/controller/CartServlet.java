package controller;

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

        HttpSession session = request.getSession();

        int ordernumber = (int) session.getAttribute("ordernumber");
        System.out.println("CartServlet ordernumber: " + ordernumber);

        List<Orderdetail> orderdetails = orderSessionBean.readOrderdetail(ordernumber);

        for (Orderdetail orderdetail : orderdetails){
            System.out.println("CartServlet orderdetail: " + orderdetail.getProductcode().getId());
        }

        session.setAttribute("cart_list", orderdetails);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
