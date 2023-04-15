package controller;


import com.utar.model.entity.Product;
import com.utar.model.sessionbean.ProductSessionBean;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


@WebServlet(name = "productservlet", value = "/productservlet")
public class ProductServelt extends HttpServlet {
    @EJB
    private ProductSessionBean prodbean;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int nOfPages = 0;
    int currentPage = 1;
    int recordsPerPage = 50;


        int rows = prodbean.getNumberOfRows();

//        get product list from database
        List<Product> list = prodbean.readProduct(currentPage, recordsPerPage);

        request.setAttribute("list", list);
//        display the list here
        request.setAttribute("nOfPages", nOfPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("recordsPerPage", recordsPerPage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayProduct.jsp");
        dispatcher.forward(request, response);



//        dispatcher.forward(request, response);
//        nOfPages = rows / recordsPerPage;
//        if (nOfPages % recordsPerPage > 0) {
//            nOfPages++;
//        }
//        List<Product> list = prodbean.readProduct(currentPage, recordsPerPage);
//
//        RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayProduct.jsp");
//        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


}
