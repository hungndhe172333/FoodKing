/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Discount;

/**
 *
 * @author Admin
 */
public class InsertDiscountControl extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InsertDiscountControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InsertDiscountControl at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        DAO dao = new DAO();
        String discountPercentage_raw = request.getParameter("discountPercentage1");
        String code = request.getParameter("code1");
        double discountPercentage = 0;
        if ( code == null || code.trim().isEmpty()) {
            request.setAttribute("ms", "Bạn cần phải nhập phiếu .");
            List<Discount> listD = dao.getAllDiscount();
            request.setAttribute("listD", listD);
            request.getRequestDispatcher("ManagerDiscount.jsp").forward(request, response);
            return;
        }
        try {
            discountPercentage = Double.parseDouble(discountPercentage_raw.trim());
        } catch (NumberFormatException e) {
            request.setAttribute("ms", "Phiếu phải đúng cấu trúc.");
            List<Discount> listD = dao.getAllDiscount();
            request.setAttribute("listD", listD);
            request.getRequestDispatcher("ManagerDiscount.jsp").forward(request, response);
            return;
        }

        List<Discount> list = dao.getAllDiscount();

        if (!checkInsertDiscount(list, code)) {
            List<Discount> listD = dao.getAllDiscount();
            request.setAttribute("ms", "Phiếu đã tồn tại.");
            request.setAttribute("listD", listD);
            request.getRequestDispatcher("ManagerDiscount.jsp").forward(request, response);
        } else {
            dao.insertDiscount(code, discountPercentage);
            String ms = "Phiếu đã được thêm!";
            List<Discount> listD = dao.getAllDiscount();
            request.setAttribute("listD", listD);
            request.setAttribute("ms", ms);
            request.getRequestDispatcher("ManagerDiscount.jsp").forward(request, response);
        }
    }

    public boolean checkInsertDiscount(List<Discount> list, String code) {
        for (Discount discount : list) {
            if (discount.getCode().equals(code)) {
                return false;
            }
        }
        return true;
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
