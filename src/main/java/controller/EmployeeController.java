package controller;

import com.utar.model.sessionbean.EmployeeSessionBeanLocal;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "EmployeeController", value = "/EmployeeController")
public class EmployeeController extends HttpServlet {

    //Set the serialization version
    private static final long serialVersionUID = 1L;

    @EJB
    private EmployeeSessionBeanLocal empbean;

    //Global variables
    int firstTime = 0;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        firstTime = Integer.valueOf(request.getParameter("firstTime"));

        //When the page is loaded for the first time
        if (firstTime == 1) {
            //Set the parameters to default value
            int currentPage = 1;
            int noOfPages = 0; //Needed calculation
            int recordsPerPage = 20;
            String keyword = "";
            String direction = "ACS";

            //Calculations for noOfPages
            int rows = empbean.getAllEmployees().size();
            noOfPages = rows / recordsPerPage;

            if (rows %  recordsPerPage != 0) {
                noOfPages++;
            }

            if (currentPage > noOfPages && noOfPages != 0) {
                currentPage = noOfPages;
            }

            //List<Employee> employeeList = empbean.

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
