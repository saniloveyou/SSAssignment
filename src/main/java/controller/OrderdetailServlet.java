package controller;

import com.utar.model.entity.Order;
import com.utar.model.entity.Orderdetail;
import com.utar.model.sessionbean.OrderSessionBean;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderdetailServlet", value = "/OrderdetailServlet")
public class OrderdetailServlet extends HttpServlet {

    @EJB
    private OrderSessionBean orderSessionBean;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int nOfPages = 0;
        int currentPage = 1;

        try {
            currentPage = Integer.parseInt(request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage"));
        } catch (NullPointerException e) {
            System.out.println("No page number selected");
        }
        finally {
            if (currentPage < 1) currentPage = 1;
        }


        int recordsPerPage = Integer.parseInt(request.getParameter("recordsPerPage") == null ? "20" : request.getParameter("recordsPerPage"));
        String direction = request.getParameter("direction") == null ? "ASC" : request.getParameter("direction");
        String sortBy = request.getParameter("sortBy") == null ? "ordernumber" : request.getParameter("sortBy");

        String ordernumber = request.getParameter("ordernumber");
        String productcode = request.getParameter("productcode");
        String quantityordered = request.getParameter("quantityordered");
        String priceeach = request.getParameter("priceeach");
        String orderlinenumber = request.getParameter("orderlinenumber");

        String orderBy = sortBy + " " + direction;

        String where = "WHERE ";

        if (ordernumber != null && !ordernumber.equals("")) where += "ordernumber = " + ordernumber + " AND ";
        if (productcode != null && !productcode.equals("")) where += "productcode = " + productcode + " AND ";
        if (quantityordered != null && !quantityordered.equals("")) where += "quantityordered = " + quantityordered + " AND ";
        if (priceeach != null && !priceeach.equals("")) where += "priceeach = " + priceeach + " AND ";
        if (orderlinenumber != null && !orderlinenumber.equals("")) where += "orderlinenumber = " + orderlinenumber + " AND ";

        if (where.equals("WHERE ")) where = "";
        else where = where.substring(0, where.length() - 5);

        try {
            String sql = "SELECT * FROM classicmodels.orderdetails " + where + " ORDER BY " + orderBy;
            int rows = orderSessionBean.getNumberOfRows("SELECT COUNT(*) FROM classicmodels.orderdetails " + where);
            nOfPages = rows / recordsPerPage;
            if (rows % recordsPerPage != 0) nOfPages++;
            if (currentPage > nOfPages && nOfPages != 0) currentPage = nOfPages;


            List<Orderdetail> orders = orderSessionBean.readOrderdetail(currentPage, recordsPerPage, sql);
            request.setAttribute("orders", orders);

        } catch (EJBException ex) {
            request.setAttribute("msg", "Unable to access the method ");
            RequestDispatcher req = request.getRequestDispatcher("DeniedAccessMethod.jsp");
            req.forward(request, response);
        }


        request.setAttribute("nOfPages", nOfPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("recordsPerPage", recordsPerPage);
        request.setAttribute("direction", direction);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("orderBy", orderBy);
        request.setAttribute("ordernumber", ordernumber);
        request.setAttribute("productcode", productcode);
        request.setAttribute("quantityordered", quantityordered);
        request.setAttribute("priceeach", priceeach);
        request.setAttribute("orderlinenumber", orderlinenumber);

        RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayOrderDetails.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
