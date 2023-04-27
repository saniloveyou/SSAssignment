package controller;

import com.utar.model.entity.Product;
import com.utar.model.sessionbean.ProductSessionBeanLocal;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductHomeDisplayServlet", value = "/ProductHomeDisplayServlet")
public class ProductHomeDisplayServlet extends HttpServlet {

    @EJB
    private ProductSessionBeanLocal productbean;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            List<Product> lists = productbean.readSomeProduct();
            request.setAttribute("products", lists);
        } catch (EJBException ex){

        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
