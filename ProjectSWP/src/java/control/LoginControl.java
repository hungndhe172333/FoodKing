/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import model.Admin;
import model.Employees;

/**
 *
 * @author minhp
 */
@WebServlet(name = "LoginControl", urlPatterns = {"/login"})
public class LoginControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        request.setAttribute("username",username);
        request.setAttribute("password",password);

        DAO dao = new DAO();
        HttpSession session = request.getSession();

        // Lấy số lần đăng nhập sai từ session
        Integer loginAttempts = (Integer) session.getAttribute("loginAttempts");
        if (loginAttempts == null) {
            loginAttempts = 0;
        }

        Employees employ = dao.loginEmployee(username, password);
        Admin admin = dao.loginAdmin(username, password);

        if (dao.checkUserExistByUserNameAdmin(username) == null && dao.checkUserExistByUserNameEmploy(username) == null) {
            request.setAttribute("mess", "Tài khoản không tồn tại");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else if (dao.loginAdmin(username, password) == null && dao.loginEmployee(username, password) == null) {
            loginAttempts++;
            session.setAttribute("loginAttempts", loginAttempts);
            if (loginAttempts >= 3) {
                request.setAttribute("mess", "Tài khoản hoặc mật khẩu không hợp lệ. Bạn có muốn <a href='ForgotPassword.jsp'>lấy lại mật khẩu?</a>");
            } else {
                request.setAttribute("mess", "Tài khoản hoặc mật khẩu không hợp lệ");
            }
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else if (employ != null) {
            // Đặt lại số lần đăng nhập sai khi đăng nhập thành công
            session.setAttribute("loginAttempts", 0);
            session.setAttribute("employ", employ);
            session.setAttribute("admin", null);
            session.setMaxInactiveInterval(3600);
            if (!employ.isActive()) {
                response.sendRedirect("ChangePassword.jsp?email=" + URLEncoder.encode(username, "UTF-8"));
            } else {
                response.sendRedirect("profile");
            }
        } else if (admin != null) {
            // Đặt lại số lần đăng nhập sai khi đăng nhập thành công
            session.setAttribute("loginAttempts", 0);
            session.setAttribute("admin", admin);
            session.setAttribute("employ", null);
            session.setMaxInactiveInterval(3600);
            response.sendRedirect("dashboard");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
