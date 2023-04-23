package controller;

import com.utar.model.entity.Product;
import com.utar.model.sessionbean.ProductSessionBeanLocal;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductPaginationServlet", value = "/ProductPaginationServlet")
public class ProductPaginationServlet extends HttpServlet {

    @EJB
    private ProductSessionBeanLocal productbean;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int nOfPages= 0;
        int currentPage = Integer.valueOf(request.getParameter("currentPage"));
        int recordsPerPage = Integer.valueOf(request.getParameter("recordsPerPage"));
        String keyword = request.getParameter("keyword");
        String sort = request.getParameter("sort");

        try {
            int rows = productbean.getNoOfRows(keyword);
            nOfPages = rows / recordsPerPage;
            if (rows % recordsPerPage != 0) {
                nOfPages++;
            }
            if (currentPage > nOfPages && nOfPages != 0) {
                currentPage = nOfPages;
            }

            List<Product> lists = productbean.readProduct(currentPage, recordsPerPage, keyword, sort);
            request.setAttribute("products", lists);
            request.setAttribute("nOfPages", nOfPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("recordsPerPage", recordsPerPage);
            request.setAttribute("keyword", keyword);
            request.setAttribute("sort", sort);
            String admin = request.getParameter("admin");
            RequestDispatcher dispatcher;
            if (admin.equals("true") ){
                dispatcher = request.getRequestDispatcher("adminProductCatalog.jsp");
            }
            else{
                dispatcher = request.getRequestDispatcher("ProductCatalog.jsp");
            }
            dispatcher.forward(request, response);
        } catch (EJBException ex) {
        }





    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
