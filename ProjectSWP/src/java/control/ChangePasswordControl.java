package control;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import model.Admin;
import model.Employees;

@WebServlet(name = "ChangePasswordControl", urlPatterns = {"/change"})
public class ChangePasswordControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String newpassword = request.getParameter("newpassword");
        String repeatpassword = request.getParameter("repeatpassword");

        if (!isValidPassword(newpassword)) {
            request.setAttribute("mess", "Mật khẩu phải chứa ít nhất 8 kí tự, bắt đầu với chữ cái viết hoa và chứa ít nhất 1 kí tự đặc biệt");
            request.setAttribute("email", email); // Retain email
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            return;
        }

        DAO dao = new DAO();
        Admin admin = dao.checkUserExistByEmailAdmin(email);
        Employees employee = dao.checkUserExistByUserNameEmploy(email);

        if (admin != null) {
            // Handle password change for admin
            if (!admin.getPassword().equals(password)) {
                request.setAttribute("mess", "Mật khẩu không đúng");
                request.setAttribute("email", email); // Retain email
                request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            } else {
                if (newpassword.equals(repeatpassword)) {
                    dao.updatePasswordAdmin(email, newpassword);
                    request.setAttribute("mess", "Đổi mật khẩu thành công");
                    request.setAttribute("email", email); // Retain email
                    request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
                } else {
                    request.setAttribute("mess", "Mật khẩu mới không khớp");
                    request.setAttribute("email", email); // Retain email
                    request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
                }
            }
        } else if (employee != null) {
            // Handle password change for employee
            if (!employee.getPassword().equals(password)) {
                request.setAttribute("mess", "Mật khẩu không đúng");
                request.setAttribute("email", email); // Retain email
                request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            } else {
                if (newpassword.equals(repeatpassword)) {
                    dao.updatePasswordEmploy(email, newpassword);
                    request.setAttribute("mess", "Đổi mật khẩu thành công");
                    request.setAttribute("email", email); // Retain email
                    dao.setEmployeeActive(employee.getEmail());
                    request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
                } else {
                    request.setAttribute("mess", "Mật khẩu mới không khớp");
                    request.setAttribute("email", email); // Retain email
                    request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
                }
            }
        } else {
            request.setAttribute("mess", "Không tìm thấy người dùng");
            request.setAttribute("email", email); // Retain email
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        }
    }

    private boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"|,.<>/?]).{8,}$";
        Pattern pattern = Pattern.compile(passwordRegex);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
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
        return "Servlet for changing password";
    }
}
