/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Admin;
import model.SendMail;

/**
 *
 * @author minhp
 */
@WebServlet(name = "ResetPasswordControl", urlPatterns = {"/reset"})
public class ResetPasswordControl extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String code = request.getParameter("code");

        DAO dao = new DAO();
        SendMail mail = new SendMail();

        // Kiểm tra mã khôi phục cho cả admin và nhân viên
        boolean validAdminCode = dao.checkResetCodeAdmin(email, code);
        boolean validEmployeeCode = dao.checkResetCodeEmploy(email, code);

        if (validAdminCode || validEmployeeCode) {
            // Generate new password
            String newPassword = mail.getRandom();

            if (validAdminCode) {
                dao.updatePasswordAdmin(email, newPassword);
                dao.clearAdminResetCode(email);
            } else if (validEmployeeCode) {
                dao.updatePasswordEmploy(email, newPassword);
                dao.clearEmployeeResetCode(email);
            }

            // Set message for user
            request.setAttribute("mess", "Mật khẩu của bạn đã được làm mới, vui lòng kiểm tra mail.");

            // Send email with the new password
            String mess = "Your new password is: " + newPassword;
            mail.send(email, "New Password", mess);
            

            // Forward to ChangePassword.jsp
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        } else {
            // Handle invalid reset code scenario
            request.setAttribute("mess", "Invalid reset link.");
            request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
        }
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
        processRequest(request, response);
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
        processRequest(request, response);
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
