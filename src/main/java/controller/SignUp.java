package controller;

import com.utar.model.sessionbean.SignUpSessionBean;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
        String hashedPassword = hashPassword(password);
        String[] s = {username, hashedPassword};

        signUpSessionBean.addSignUp(s);

        response.setContentType("text/html");
        response.getWriter().println("<html><body>");
        response.getWriter().println("<h1>Account Created</h1>");
        response.getWriter().println("<p>Your account has been successfully created.</p>");
        response.getWriter().println("</body></html>");
        response.setHeader("Refresh", "5; URL=index.html");

    }
    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            String encodedHash = Base64.getEncoder().encodeToString(hash);
            return encodedHash;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

}
