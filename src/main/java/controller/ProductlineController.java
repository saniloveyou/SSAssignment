package controller;

import com.utar.model.entity.Productline;
import com.utar.model.sessionbean.ProductlineSessionBeanLocal;
import utilities.ProductChangesValidation;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ProductlineController", value = "/ProductlineController")
public class ProductlineController extends HttpServlet {

    @EJB
    private ProductlineSessionBeanLocal productlinebean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            else if (ProductChangesValidation.validateManager(request).equals("DELETE")) {
                productlinebean.deleteProductline(pl); //NEED TO WAIT FOR INTEGRATION TO DEBUG


            } else {
               productlinebean.addProductline(s);

            }
            // this line is to redirect to notify record has been updated and redirect to
            // another page

                out.println("<SCRIPT type=\"text/javascript\">");
                out.println("alert(\"Record has been updated and url will be redirected\")");
                out.println("window.location.assign(\"ProductlineDisplayServlet?currentPage=1&recordsPerPage=12&keyword=&sort=ASC\")"); //CHANGE URL
                out.println("</SCRIPT>");


        } catch (EJBException ex) {
        }

    }
}
