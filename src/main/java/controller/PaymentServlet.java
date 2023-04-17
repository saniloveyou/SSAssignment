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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@WebServlet(name = "PaymentServlet", value = "/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    @EJB
    private PaymentSessionBean paymentSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String customernumber = request.getParameter("customernumber");
        String customername = request.getParameter("customername");
        String checknumber = request.getParameter("checknumber");
        String paymentdate = request.getParameter("paymentdate");

        String fromDateStr = request.getParameter("from_date");

        String toDateStr = request.getParameter("to_date");

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//        Date fromDate = null;
//        Date toDate = null;
//        if (fromDateStr != null && toDateStr != null) {
//            try {
//                fromDate = dateFormat.parse(fromDateStr);
//                toDate = dateFormat.parse(toDateStr);
//            } catch (ParseException e) {
//            }
//        }

        System.out.println("this line here"+fromDateStr);

        String category;
        List<Object[]> lists;

//        check customer number contain alphabet or not

        if (customernumber != null && customernumber.length() > 0 && !customernumber.matches(".*[a-zA-Z]+.*") ) {
            category = "c.customernumber = " +"'"+customernumber+"'" ;
            lists = paymentSessionBean.findPayment(category);

        }
        else if(customername != null && customername.length() > 0){
            System.out.println("customername"+customername);
            category = "c.customername LIKE " + "'"+customername+"'";
            lists = paymentSessionBean.findPayment(category);
        }
        else if(checknumber != null && checknumber.length() > 0){
            System.out.println("checknumber"+checknumber);
            category = "pd.checknumber = " + "'"+checknumber+"'";
            lists = paymentSessionBean.findPayment(category);
        }
        else if(fromDateStr != null && toDateStr != null && fromDateStr.length() > 0 && toDateStr.length() > 0){
            System.out.println("fromDateStr"+fromDateStr);
            System.out.println("toDateStr"+toDateStr);
            category = "AND pd.paymentdate BETWEEN " + "'"+fromDateStr+"'" + " AND " + "'"+toDateStr+"'";
            lists = paymentSessionBean.findPayment(category);
        }
        else{
            lists = paymentSessionBean.getpaymentdetails();
        }


        HttpSession session = request.getSession();

        session.setAttribute("payment",lists);

        RequestDispatcher req = request.getRequestDispatcher("DisplayPayment.jsp");
        req.forward(request, response);



        }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
