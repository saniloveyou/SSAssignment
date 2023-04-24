package controller;

import com.utar.model.sessionbean.PaymentSessionBean;

import javax.ejb.EJB;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeletePayment", value = "/DeletePayment")
public class DeletePayment extends HttpServlet {

    @EJB
    private PaymentSessionBean paymentbean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String flag = request.getParameter("flag");

            if(flag.equals("true")){
                RequestDispatcher dispatcher = request.getRequestDispatcher("DeletePayment.jsp");
                dispatcher.forward(request, response);
            }else {
                doPost(request, response);
            }

        }catch (Exception e) {
            doPost(request, response);
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentid = request.getParameter("id");
        paymentbean.deletePayment(paymentid);
        RequestDispatcher dispatcher = request.getRequestDispatcher("PaymentServlet?currentPage=1&recordsPerPage=20&direction=asc");
        dispatcher.forward(request, response);
    }
}
