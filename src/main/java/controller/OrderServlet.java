package controller;

import com.utar.model.entity.Employee;
import com.utar.model.entity.Order;
import com.utar.model.sessionbean.OrderSessionBean;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "OrderServlet", value = "/OrderServlet")
public class OrderServlet extends HttpServlet {

    @EJB
    private OrderSessionBean orderSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int nOfPages = 0;
        int currentPage = 1;

        String action = request.getParameter("action");
        if (action != null){
            if(action.equals("update")){
                String ordernumber = request.getParameter("ordernumber");
                Order order = orderSessionBean.findOrder(ordernumber);
                request.setAttribute("ordernumber", ordernumber);
                request.setAttribute("orderdate", order.getOrderdate());
                request.setAttribute("requireddate", order.getRequireddate());
                request.setAttribute("shippeddate", order.getShippeddate());
                request.setAttribute("status", order.getStatus());
                request.setAttribute("comments", order.getComments());
                request.setAttribute("customernumber", order.getCustomernumber().toString());
                request.getRequestDispatcher("UpdateOrder.jsp").forward(request, response);
            }
            if (action.equals("delete")){
                String ordernumber = request.getParameter("ordernumber");
                orderSessionBean.deleteOrder(ordernumber);
                System.out.println("OrderServlet: Order deleted");
                PrintWriter out = response.getWriter();
                response.sendRedirect("OrderServlet");
            }

            return;
        }


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
        String customernumber = request.getParameter("customernumber");
        String fromOrderDate = request.getParameter("fromOrderDate");
        String toOrderDate = request.getParameter("toOrderDate");
        String fromRequiredDate = request.getParameter("fromRequiredDate");
        String toRequiredDate = request.getParameter("toRequiredDate");
        String fromShippedDate = request.getParameter("fromShippedDate");
        String toShippedDate = request.getParameter("toShippedDate");
        String[] status = new String[0];
        try {
            status = request.getParameterValues("status");
        } catch (NullPointerException e) {
            System.out.println("No status selected");
        } finally {
            if (status == null) status = new String[]{};
        }

        String orderBy = sortBy + " " + direction;

        String where = "WHERE ";

        if (status.length != 0) {
            where += " status IN (";
            for (int i = 0; i < status.length; i++) {
                where += "'" + status[i] + "'";
                if (i != status.length - 1) where += ", ";
            }
            where += ") AND ";
        }

        if(ordernumber != null && !ordernumber.equals("")) where += "ordernumber = " + ordernumber + " AND ";
        if(customernumber != null && !customernumber.equals("")) where += "customernumber = " + customernumber + " AND ";
        if(fromOrderDate != null && !fromOrderDate.equals("")) where += "orderdate >= '" + fromOrderDate + "' AND ";
        if(toOrderDate != null && !toOrderDate.equals("")) where += "orderdate <= '" + toOrderDate + "' AND ";
        if(fromRequiredDate != null && !fromRequiredDate.equals("")) where += "requireddate >= '" + fromRequiredDate + "' AND ";
        if(toRequiredDate != null && !toRequiredDate.equals("")) where += "requireddate <= '" + toRequiredDate + "' AND ";
        if(fromShippedDate != null && !fromShippedDate.equals("")) where += "shippeddate >= '" + fromShippedDate + "' AND ";
        if(toShippedDate != null && !toShippedDate.equals("")) where += "shippeddate <= '" + toShippedDate + "' AND ";

        if (where.equals("WHERE ")) where = "";
        else where = where.substring(0, where.length() - 5);


        try {
            String sql = "SELECT ordernumber, orderdate, requireddate, CASE WHEN shippeddate = '' THEN null ELSE shippeddate END, status, comments, customerNumber FROM classicmodels.orders " + where + " ORDER BY " + orderBy;
            int rows = orderSessionBean.getNumberOfRows("SELECT COUNT(*) FROM classicmodels.orders " + where);
            nOfPages = rows / recordsPerPage;
            if (rows % recordsPerPage != 0) nOfPages++;
            if (currentPage > nOfPages && nOfPages != 0) currentPage = nOfPages;


            List<Order> orders = orderSessionBean.readOrder(currentPage, recordsPerPage, sql);
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
        request.setAttribute("status", status);
        request.setAttribute("ordernumber", ordernumber);
        request.setAttribute("customernumber", customernumber);
        request.setAttribute("fromOrderDate", fromOrderDate);
        request.setAttribute("toOrderDate", toOrderDate);
        request.setAttribute("fromRequiredDate", fromRequiredDate);
        request.setAttribute("toRequiredDate", toRequiredDate);
        request.setAttribute("fromShippedDate", fromShippedDate);
        request.setAttribute("toShippedDate", toShippedDate);

        RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayOrder.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("action").equals("updateOrder")){
            String ordernumber = request.getParameter("ordernumber");
            String orderdate = request.getParameter("orderdate");
            String requireddate = request.getParameter("requireddate");
            String shippeddate = request.getParameter("shippeddate");
            String status = request.getParameter("status");
            String comments = request.getParameter("comments");
            String customernumber = request.getParameter("customernumber");

            orderSessionBean.updateOrder(Integer.parseInt(ordernumber), requireddate, shippeddate, status, comments);
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Order updated successfully');");
            out.println("</script>");

            response.sendRedirect("OrderServlet?currentPage=1&recordsPerPage=20&sortBy=ordernumber&direction=asc");
        }
    }
}
