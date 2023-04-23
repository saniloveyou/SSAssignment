package controller;

import com.utar.model.entity.Product;
import com.utar.model.entity.Productline;
import com.utar.model.sessionbean.ProductSessionBeanLocal;
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

@WebServlet(name = "ProductController", value = "/ProductController")
public class ProductController extends HttpServlet {
    @EJB
    private ProductSessionBeanLocal productbean;
    @EJB
    private ProductlineSessionBeanLocal productlinebean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            String display = request.getParameter("display");
            Product p = productbean.getProduct(id);
            request.setAttribute("product", p);
            if (display == null){
                RequestDispatcher req = request.getRequestDispatcher("ProductUpdate.jsp");
                req.forward(request, response);
            }
            else{
                RequestDispatcher req = request.getRequestDispatcher("ProductDetail.jsp");
                req.forward(request, response);
            }
        } catch (EJBException ex) {
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");

            String productline = request.getParameter("productline"); //need to convert to productline object
            Productline pl = productlinebean.getProductline(productline);

            String productScale = request.getParameter("productScale");
            String productVendor = request.getParameter("productVendor");
            String productDescription = request.getParameter("productDescription");
            String productInStock = request.getParameter("productInStock");
            String buyPrice = request.getParameter("buyPrice");
            String msrp = request.getParameter("msrp");
            PrintWriter out = response.getWriter();

            String[] s = { productId, productName, productScale, productVendor, productDescription, productInStock, buyPrice, msrp  };
            if (ProductChangesValidation.validateManager(request).equals("UPDATE")) {
                productbean.updateProduct(s, pl);

            }
            else if (ProductChangesValidation.validateManager(request).equals("DELETE")) {
                productbean.deleteProduct(productId); //NEED TO WAIT FOR INTEGRATION TO DEBUG


            } else {
                productbean.addProduct(s, pl);

            }
            // this line is to redirect to notify record has been updated and redirect to
            // another page
            out.println("<SCRIPT type=\"text/javascript\">");
            out.println("alert(\"Record has been updated and url will be redirected\")");
            out.println("window.location.assign(\"ProductPaginationServlet?currentPage=1&recordsPerPage=12&keyword=&admin=true&sort=ASC\")"); //CHANGE URL
            out.println("</SCRIPT>");

        } catch (EJBException ex) {

        }

    }

}
