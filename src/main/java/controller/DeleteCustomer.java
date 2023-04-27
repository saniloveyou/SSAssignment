package controller;

import com.utar.model.sessionbean.CustomerSessionBean;

import javax.ejb.EJB;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteCustomer", value = "/DeleteCustomer")
public class DeleteCustomer extends HttpServlet {

    @EJB
    private CustomerSessionBean customerbean;

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

    String customerid = request.getParameter("id");
        customerbean.deleteCustomer(customerid);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Profile?direction=ASC&currentPage=1&recordsPerPage=20");
        dispatcher.forward(request, response);
    }
}
