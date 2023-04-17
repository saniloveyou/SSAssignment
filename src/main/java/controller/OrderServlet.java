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
        int currentPage = Integer.parseInt(request.getParameter("currentPage"));
        int recordsPerPage = Integer.parseInt(request.getParameter("recordsPerPage"));
        String direction = request.getParameter("direction");

        try {
            int rows = orderSessionBean.getNumberOfRows();
            nOfPages = rows / recordsPerPage;
            if (rows % recordsPerPage != 0) nOfPages++;
            if (currentPage > nOfPages && nOfPages != 0) currentPage = nOfPages;
            List<Order> orders = orderSessionBean.readOrder(currentPage, recordsPerPage, direction);
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

        RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayOrder.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
