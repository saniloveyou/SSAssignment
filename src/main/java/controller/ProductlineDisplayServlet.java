package controller;

import com.utar.model.entity.Productline;
import com.utar.model.sessionbean.ProductlineSessionBeanLocal;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductlineDisplayServlet", value = "/ProductlineDisplayServlet")
public class ProductlineDisplayServlet extends HttpServlet {

    @EJB
    ProductlineSessionBeanLocal productlinebean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int nOfPages= 0;
        int currentPage = Integer.valueOf(request.getParameter("currentPage"));
        int recordsPerPage = Integer.valueOf(request.getParameter("recordsPerPage"));
        String keyword = request.getParameter("keyword");
        String sort = request.getParameter("sort");

        try{
            int rows = productlinebean.getNoOfRows(keyword);
            nOfPages = rows / recordsPerPage;
            if (rows % recordsPerPage != 0) {
                nOfPages++;
            }
            if (currentPage > nOfPages && nOfPages != 0) {
                currentPage = nOfPages;
            }
            List<Productline> lists = productlinebean.readProductline(currentPage, recordsPerPage, keyword ,sort);
            request.setAttribute("productline", lists);
            request.setAttribute("nOfPages", nOfPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("recordsPerPage", recordsPerPage);
            request.setAttribute("keyword", keyword);
            request.setAttribute("sort", sort);

            RequestDispatcher req = request.getRequestDispatcher("ProductlineList.jsp");

            req.forward(request, response);

        }catch (EJBException ex){

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
