package utilities;

import javax.servlet.http.HttpServletRequest;
import java.io.PrintWriter;

public class ProductChangesValidation {
    public static String validateManager(HttpServletRequest request) {
        if(request.getParameter("UPDATE")!=null&&request.getParameter("UPDATE").equals("UPDATE")) {
            return "UPDATE";
        }
        else if (request.getParameter("DELETE") != null && request.getParameter("DELETE").equals("DELETE")) {
            return "DELETE";
        }
        return "ADD";
    }


}
