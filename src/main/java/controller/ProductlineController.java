package controller;

import com.utar.model.entity.Productline;
import com.utar.model.sessionbean.ProductlineSessionBeanLocal;
import utilities.ProductChangesValidation;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ProductlineController", value = "/ProductlineController")
public class ProductlineController extends HttpServlet {

    @EJB
    private ProductlineSessionBeanLocal productlinebean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if(request.getParameter("action").equals("delete")){
            productlinebean.deleteProductline(request.getParameter("id"));
            response.sendRedirect("ProductlineDisplayServlet?currentPage=1&recordsPerPage=12&&keyword=&sort=ASC");
            return;
        }

        try {
            String id = request.getParameter("id");
            Productline pl = productlinebean.getProductline(id);
            request.setAttribute("productline", pl);
            RequestDispatcher req = request.getRequestDispatcher("ProductlineUpdate.jsp");
            req.forward(request, response);

        } catch (EJBException ex) {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String pl = request.getParameter("productline");
            String textDescription = request.getParameter("textDescription");
            String htmlDescription = request.getParameter("htmlDescription");
            String image = request.getParameter("Image");
            PrintWriter out = response.getWriter();

            String[] s = { pl, textDescription, htmlDescription, image};
            if (ProductChangesValidation.validateManager(request).equals("UPDATE")) {
                productlinebean.updateProductline(s);
            }
            else {
               productlinebean.addProductline(s);
            }
                out.println("<SCRIPT type=\"text/javascript\">");
                out.println("alert(\"Record has been updated and url will be redirected\")");
                out.println("window.location.assign(\"ProductlineDisplayServlet?currentPage=1&recordsPerPage=12&keyword=&sort=ASC\")"); //CHANGE URL
                out.println("</SCRIPT>");


        } catch (EJBException ex) {
        }

    }
}
