package control;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ActivateControl", urlPatterns = {"/activate"})
public class ActivateControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        DAO dao = new DAO();

        if (dao.checkUserExistByUserNameEmploy(email) == null) {
            request.getRequestDispatcher("SetPassword.jsp").forward(request, response);
        } else {
            request.setAttribute("mess", "Liên kết kích hoạt không hợp lệ hoặc không tìm thấy email");
            request.getRequestDispatcher("SetPassword.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for account activation";
    }
}
