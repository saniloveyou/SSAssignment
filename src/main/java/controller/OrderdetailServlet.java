package controller;

import com.utar.model.entity.Customer;
import com.utar.model.entity.Order;
import com.utar.model.entity.Orderdetail;
import com.utar.model.sessionbean.OrderSessionBean;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "OrderdetailServlet", value = "/OrderdetailServlet")
public class OrderdetailServlet extends HttpServlet {

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
                String productcode = request.getParameter("productcode");
                String only = request.getParameter("only");
                Orderdetail orderdetail = orderSessionBean.findOrderdetail(ordernumber, productcode);
                request.setAttribute("ordernumber", ordernumber);
                request.setAttribute("productcode", productcode);
                request.setAttribute("quantityordered", orderdetail.getQuantityordered().toString());
                request.setAttribute("priceeach", orderdetail.getPriceeach().toString());
                request.setAttribute("orderlinenumber", orderdetail.getOrderlinenumber().toString());
                request.setAttribute("only", only);
                request.getRequestDispatcher("UpdateOrderdetail.jsp").forward(request, response);
            }
            if (action.equals("delete")){
                String ordernumber = request.getParameter("ordernumber");
                String productcode = request.getParameter("productcode");
                String only = request.getParameter("only");
                orderSessionBean.deleteOrderdetail(ordernumber, productcode);
                Customer customer = (Customer) request.getSession().getAttribute("customer");
                request.getSession().setAttribute("cartcount", orderSessionBean.cartCount(String.valueOf(customer.getId())));
                PrintWriter out = response.getWriter();
                if (only.equals("quantity")) {
                    response.sendRedirect("CartServlet");
                } else {
                    response.sendRedirect("OrderdetailServlet");
                }
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

        String productcode = "";
        try {
            productcode = request.getParameter("productcode");
        } catch (NullPointerException e) {
            System.out.println("No productcode selected");
        }
        finally {
            if (productcode == null) productcode = "";
        }

        String quantityordered = request.getParameter("quantityordered");
        String priceeach = request.getParameter("priceeach");
        String orderlinenumber = request.getParameter("orderlinenumber");

        String orderBy = sortBy + ", orderlinenumber " + direction;

        String where = "WHERE ";

        if (ordernumber != null && !ordernumber.equals("")) where += "ordernumber = " + ordernumber + " AND ";
        if (productcode != null && !productcode.equals("")) where += "productcode = '" + productcode + "' AND ";

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
        if(request.getParameter("action").equals("updateOrderdetail")){
            int ordernumber = Integer.parseInt(request.getParameter("ordernumber"));
            String productcode = request.getParameter("productcode");
            int quantityordered = Integer.parseInt(request.getParameter("quantityordered"));
            double priceeach = Double.parseDouble(request.getParameter("priceeach"));

            orderSessionBean.updateOrderdetail(ordernumber, productcode, quantityordered, priceeach);
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Order detail updated successfully');");
            out.println("</script>");

            Customer customer = (Customer) request.getSession().getAttribute("customer");
            request.getSession().setAttribute("cartcount", orderSessionBean.cartCount(String.valueOf(customer.getId())));

            try {
                String only = request.getParameter("only");
                if (only.equals("quantity")) {
                    response.sendRedirect("CartServlet");
                    return;
                }
            } catch (Exception e) {
                System.out.println("Not from cart");
            }

            response.sendRedirect("OrderdetailServlet?currentPage=1&recordsPerPage=20&sortBy=ordernumber&direction=asc");
        }
    }
}
