package controller;

import com.utar.model.sessionbean.CustomerSessionBean;
import com.utar.model.sessionbean.PaymentSessionBean;

import javax.ejb.EJB;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Profile", value = "/Profile")
public class Profile extends HttpServlet {
    @EJB
    private PaymentSessionBean paymentSessionBean;

    @EJB
    private CustomerSessionBean customerSessionBean;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        try {
            HttpSession session = request.getSession();
            String userrole = session.getAttribute("user_role").toString();
            if (userrole.equals("[user]")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("adminrights.jsp");
                dispatcher.forward(request, response);
            }
        }catch (Exception e) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
            dispatcher.forward(request, response);
        }

        String customernumber = request.getParameter("customernumber");
        String customername = request.getParameter("customername");
        String checknumber = request.getParameter("checknumber");
        String phonenumber = request.getParameter("phonenumber");
        String creditlimit = request.getParameter("creditlimit");
        String amount = request.getParameter("amount");
        String fromDateStr = request.getParameter("from_date");
        String toDateStr = request.getParameter("to_date");
        String minamount = request.getParameter("minamount");
        String maxamount = request.getParameter("maxamount");

        if (fromDateStr != null && toDateStr != null && fromDateStr.length() > 0 && toDateStr.length() > 0) {
            String[] date = fromDateStr.split("-");
            fromDateStr = date[2] + "/" + date[1] + "/" + date[0];

            date = toDateStr.split("-");
            toDateStr = date[2] + "/" + date[1] + "/" + date[0];
        }

        String category;

        List<Object[]> lists = null;
        int nOfpages = 0,currentPage = 1,recordsPerPage = 20;
        String direction = "ASC";

        System.out.println("creditlimit: " + creditlimit);
        System.out.println("creditlimit: " + minamount);
        System.out.println("creditlimit: " + maxamount);
        try {
            if (customernumber != null && customernumber.length() > 0 && !customernumber.matches(".*[a-zA-Z]+.*")) {
                category = "c.customernumber = " + "'" + customernumber + "'";
                lists = paymentSessionBean.findPaymentCustomer(category);

            } else if (customername != null && customername.length() > 0) {
                category = "c.customername LIKE " + "'%" + customername + "%'";
                lists = paymentSessionBean.findPaymentCustomer(category);
            } else if (checknumber != null && checknumber.length() > 0) {
                category = "pd.checknumber = " + "'" + checknumber + "'";
                lists = paymentSessionBean.findPaymentCustomer(category);
            } else if (phonenumber != null && phonenumber.length() > 0) {
                category = "c.phone = " + "'" + phonenumber + "'";
                lists = paymentSessionBean.findPaymentCustomer(category);
            } else if (fromDateStr != null && toDateStr != null && fromDateStr.length() > 0 && toDateStr.length() > 0) {
                category = "pd.paymentdate BETWEEN " + "'" + fromDateStr + "'" + " AND " + "'" + toDateStr + "'";
                lists = paymentSessionBean.findPaymentCustomer(category);
            } else if (creditlimit != null && creditlimit.length() > 0) {
                category = "c.creditlimit BETWEEN " +  minamount  + " AND " +  maxamount;
                lists = paymentSessionBean.findPaymentCustomer(category);
            } else if (amount != null && amount.length() > 0) {
                category = "pd.amount BETWEEN " +  minamount  + " AND " +  maxamount;
                lists = paymentSessionBean.findPaymentCustomer(category);
            }else {
                try {

                    currentPage = Integer.parseInt(request.getParameter("currentPage"));
                    recordsPerPage = Integer.parseInt(request.getParameter("recordsPerPage"));
                    int rows = customerSessionBean.getNumberOfRows();
                    nOfpages = (rows + recordsPerPage - 1) / recordsPerPage;
                    currentPage = Math.min(currentPage, nOfpages);
                    direction = request.getParameter("direction");

                    lists = customerSessionBean.readpaymentdetails(currentPage, recordsPerPage, direction);

                } catch (Exception e) {

                }
            }
            request.setAttribute("nOfPages", nOfpages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("recordsPerPage", recordsPerPage);
            request.setAttribute("direction", direction);
            HttpSession session = request.getSession();
            session.setAttribute("customer",lists);

        }catch (Exception e) {
            request.setAttribute("msg", "Unable to access the method ");
            RequestDispatcher req = request.getRequestDispatcher("DeniedAccessMethod.jsp");
            req.forward(request, response);
        }

        RequestDispatcher req = request.getRequestDispatcher("Profile.jsp");
        req.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String row0 = request.getParameter("row0");
        String row1 = request.getParameter("row1");
        String row2 = request.getParameter("row2");
        String row3 = request.getParameter("row3");
        String row4 = request.getParameter("row4");
        String row5 = request.getParameter("row5");
        String row6 = request.getParameter("row6");
        String row7 = request.getParameter("row7");
        String row8 = request.getParameter("row8");
        String row9 = request.getParameter("row9");
        String row10 = request.getParameter("row10");
        String row11 = request.getParameter("row11");
        String row12 = request.getParameter("row12");

        if(row12.equals("null") || row12 == ""){
            row12 = "0";
        }

        String[] scustomer = {row0,row1,row2,row3,row4,row5,row6,row7,row8,row9,row10,row11,row12};

            customerSessionBean.updateCustomer(scustomer);

            RequestDispatcher req = request.getRequestDispatcher("UpdateSuccess.jsp");
            req.forward(request, response);

    }
}
