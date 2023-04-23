package controller;

import com.utar.model.entity.Employee;
import com.utar.model.entity.Order;
import com.utar.model.sessionbean.OrderSessionBean;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", value = "/OrderServlet")
public class OrderServlet extends HttpServlet {

    @EJB
    private OrderSessionBean orderSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int nOfPages = 0;
        int currentPage = Integer.parseInt(request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage"));
        int recordsPerPage = Integer.parseInt(request.getParameter("recordsPerPage") == null ? "20" : request.getParameter("recordsPerPage"));
        String direction = request.getParameter("direction") == null ? "ASC" : request.getParameter("direction");
        String sortBy = request.getParameter("sortBy") == null ? "ordernumber" : request.getParameter("sortBy");

        try {
            int rows = orderSessionBean.getNumberOfRows("SELECT COUNT(*) FROM classicmodels.orders");
            nOfPages = rows / recordsPerPage;
            if (rows % recordsPerPage != 0) nOfPages++;
            if (currentPage > nOfPages && nOfPages != 0) currentPage = nOfPages;
            List<Order> orders = orderSessionBean.readOrder(currentPage, recordsPerPage, sortBy, direction);
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

        RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayOrder.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // get all the parameters from the request
        String ordernumber = request.getParameter("ordernumber");
        String customernumber = request.getParameter("customernumber");
        String fromOrderDate = request.getParameter("fromOrderDate");
        String toOrderDate = request.getParameter("toOrderDate");
        String fromRequiredDate = request.getParameter("fromRequiredDate");
        String toRequiredDate = request.getParameter("toRequiredDate");
        String fromShippedDate = request.getParameter("fromShippedDate");
        String toShippedDate = request.getParameter("toShippedDate");
//        String[] status = request.getParameterValues("status");
        int recordsPerPage = Integer.parseInt(request.getParameter("recordsPerPage") == null ? "20" : request.getParameter("recordsPerPage"));

        int nOfPages = 0;
        int currentPage = Integer.parseInt(request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage"));
        String direction = request.getParameter("direction") == null ? "ASC" : request.getParameter("direction");
        String sortBy = request.getParameter("sortBy") == null ? "ordernumber" : request.getParameter("sortBy");


        String orderBy = sortBy + " " + direction;
        String where = "WHERE ";
//        if (status.length > 0) {
//            where += " status IN (";
//            for (int i = 0; i < status.length; i++) {
//                where += "'" + status[i] + "'";
//                if (i != status.length - 1) where += ", ";
//            }
//            where += ") AND ";
//        }
        if (where.equals("WHERE ")) where = "";
        else where = where.substring(0, where.length() - 5);
        String statement = "SELECT COUNT(*) FROM classicmodels.orders " + where;

        try {
            int rows = orderSessionBean.getNumberOfRows(statement);
            nOfPages = rows / recordsPerPage;
            if (rows % recordsPerPage != 0) nOfPages++;
            if (currentPage > nOfPages && nOfPages != 0) currentPage = nOfPages;
            List<Order> orders = orderSessionBean.readOrder(currentPage, recordsPerPage, sortBy, direction, ordernumber, customernumber, fromOrderDate, toOrderDate, fromRequiredDate, toRequiredDate, fromShippedDate, toShippedDate);
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
//        request.setAttribute("status", status);

        RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayOrder.jsp");
        dispatcher.forward(request, response);
    }
}
