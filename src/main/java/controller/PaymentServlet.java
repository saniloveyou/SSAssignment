package controller;


import com.utar.model.entity.Payment;
import com.utar.model.sessionbean.PaymentSession;
import com.utar.model.sessionbean.PaymentSessionBean;

import javax.ejb.EJB;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.awt.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "PaymentServlet", value = "/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    @EJB
    private PaymentSessionBean paymentSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Object[]> lists = paymentSessionBean.getpaymentdetails();

        System.out.println("this is here " + lists.size());

        HttpSession session = request.getSession();

        session.setAttribute("payment",lists);

        RequestDispatcher req = request.getRequestDispatcher("DisplayPayment.jsp");
        req.forward(request, response);

        for (Object[] row : lists) {
            System.out.println("Product Name: " + row[0]);
            System.out.println("Product Name: " + row[1]);
            System.out.println("Product Name: " + row[2]);
            System.out.println("Product Name: " + row[3]);
            System.out.println("Product Name: " + row[4]);
        }




        }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
