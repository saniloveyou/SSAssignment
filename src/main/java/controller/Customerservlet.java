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
public class Customerservlet extends HttpServlet {
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
        String phonenumber = request.getParameter("phonenumber");
        String city = request.getParameter("City");
        String state = request.getParameter("State");
        String postalcode = request.getParameter("postal");
        String country = request.getParameter("Country");
        String creditlimit = request.getParameter("Limit");
        String minamount = request.getParameter("minamount");
        String maxamount = request.getParameter("maxamount");


        String category;

        List<Object[]> lists = null;
        int nOfpages = 0,currentPage = 1,recordsPerPage = 20;
        String direction = "ASC";


        try {
            if (customernumber != null && customernumber.length() > 0 && !customernumber.matches(".*[a-zA-Z]+.*")) {
                category = "c.customernumber = " + "'" + customernumber + "'";
                lists = customerSessionBean.filterpayment(category);
            } else if (customername != null && customername.length() > 0) {
                category = "c.customername LIKE " + "'%" + customername + "%'";
                lists = customerSessionBean.filterpayment(category);
            } else if (phonenumber != null && phonenumber.length() > 0) {
                category = "c.phone LIKE " + "'%" + phonenumber + "%'";
                lists = customerSessionBean.filterpayment(category);
            } else if (creditlimit != null && creditlimit.length() > 0) {
                category = "c.creditlimit BETWEEN " +  minamount  + " AND " +  maxamount;
                lists = customerSessionBean.filterpayment(category);
            }else if(city != null && city.length() > 0){
                category = "c.city LIKE " + "'%" + city + "%'";
                lists = customerSessionBean.filterpayment(category);
            }else if(state != null && state.length() > 0){
                category = "c.state LIKE " + "'%" + state + "%'";
                lists = customerSessionBean.filterpayment(category);
            }
            else if(postalcode != null && postalcode.length() > 0){
                category = "c.postalcode LIKE " + "'%" + postalcode + "%'";
                lists = customerSessionBean.filterpayment(category);
            }
            else if(country != null && country.length() > 0) {
                category = "c.country LIKE " + "'%" + country + "%'";
                lists = customerSessionBean.filterpayment(category);
            } else {
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
            session.setAttribute("customers",lists);

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
