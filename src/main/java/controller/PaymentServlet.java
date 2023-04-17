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
        String fromDateStr = request.getParameter("from_date");
        String toDateStr = request.getParameter("to_date");
        String category;

        List<Object[]> lists = null;
        int nOfpages = 0,currentPage = 1,recordsPerPage = 20;
        String direction = "ASC";


        System.out.println("customernumber: " + customernumber);
            if (customernumber != null && customernumber.length() > 0 && !customernumber.matches(".*[a-zA-Z]+.*")) {
                category = "c.customernumber = " + "'" + customernumber + "'";
                lists = paymentSessionBean.findPayment(category);

            } else if (customername != null && customername.length() > 0) {
                category = "c.customername LIKE " + "'" + customername + "'";
                lists = paymentSessionBean.findPayment(category);
            } else if (checknumber != null && checknumber.length() > 0) {
                category = "pd.checknumber = " + "'" + checknumber + "'";
                lists = paymentSessionBean.findPayment(category);
            } else if (fromDateStr != null && toDateStr != null && fromDateStr.length() > 0 && toDateStr.length() > 0) {
                category = "pd.paymentdate BETWEEN " + "'" + fromDateStr + "'" + " AND " + "'" + toDateStr + "'";
                lists = paymentSessionBean.findPayment(category);
            } else {
                try {
                    currentPage = Integer.parseInt(request.getParameter("currentPage"));
                    recordsPerPage = Integer.parseInt(request.getParameter("recordsPerPage"));
                    int rows = paymentSessionBean.getNumberOfRows();
                    nOfpages = (rows + recordsPerPage - 1) / recordsPerPage;
                    currentPage = Math.min(currentPage, nOfpages);
                    direction = request.getParameter("direction");
                    lists = paymentSessionBean.readpaymentdetails(currentPage, recordsPerPage, direction);
                } catch (Exception e) {

                }

            }
        request.setAttribute("nOfPages", nOfpages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("recordsPerPage", recordsPerPage);
        request.setAttribute("direction", direction);
            HttpSession session = request.getSession();
            session.setAttribute("payment",lists);

//        }catch (Exception e) {
//            request.setAttribute("msg", "Unable to access the method ");
//            RequestDispatcher req = request.getRequestDispatcher("DeniedAccessMethod.jsp");
//            req.forward(request, response);
//        }

        RequestDispatcher req = request.getRequestDispatcher("DisplayPayment.jsp");
        req.forward(request, response);
        }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
