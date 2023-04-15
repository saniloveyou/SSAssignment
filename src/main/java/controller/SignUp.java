package controller;

import com.utar.model.entity.User;
import com.utar.model.sessionbean.SignUpSessionBean;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

@WebServlet(name = "SignUp", value = "/SignUp")
public class SignUp extends HttpServlet {

    @EJB
    private SignUpSessionBean signUpSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String[] s = {username, password};


       Boolean flag = signUpSessionBean.addSignUp(s);

       if (flag){
           request.setAttribute("flag","True");
           RequestDispatcher req = request.getRequestDispatcher("SignUp.jsp");
           req.forward(request, response);
       }
       else
       {
           request.setAttribute("flag","False");
           RequestDispatcher req = request.getRequestDispatcher("SignUp.jsp");
           req.forward(request, response);
       }



    }

}
