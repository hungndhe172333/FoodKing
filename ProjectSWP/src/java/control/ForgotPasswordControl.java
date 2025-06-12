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
import model.SendMail;

/**
 *
 * @author minhp
 */
@WebServlet(name = "ForgotPasswordControl", urlPatterns = {"/forgot"})
public class ForgotPasswordControl extends HttpServlet {

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
        SendMail mail = new SendMail();
        String code = mail.getRandom();

        DAO dao = new DAO();

        boolean isAdmin = dao.checkUserExistByEmailAdmin(email) != null;
        boolean isEmployee = dao.checkUserExistByUserNameEmploy(email) != null;

        if (!isAdmin && !isEmployee) {
            request.setAttribute("mess", "Email không tồn tại");
            request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
        } else {
            if (isAdmin) {
                dao.storeResetCodeAdmin(email, code);
            } else if (isEmployee) {
                dao.storeResetCodeEmploy(email, code);
            }

            String resetLink = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                    + request.getContextPath() + "/reset?email=" + email + "&code=" + code;

            String to = email;
            String message = "Click the following link to reset your password: " + resetLink;
            mail.send(to, "Reset Password", message);

            request.setAttribute("mess", "Một liên kết đặt lại mật khẩu đã được gửi đến email của bạn."
                    + "\n Liên kết sẽ tồn tại trong 3 phút");
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
