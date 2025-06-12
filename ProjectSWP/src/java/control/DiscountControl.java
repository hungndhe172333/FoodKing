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
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.List;
import model.Cart;
import model.Discount;

/**
 *
 * @author minhp
 */
public class DiscountControl extends HttpServlet {

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
            out.println("<title>Servlet DiscountControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DiscountControl at " + request.getContextPath() + "</h1>");
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
        if (session == null || session.getAttribute("employ") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String tableName = request.getParameter("tableName");

        // Get the discount code from the request
        String promoCode = request.getParameter("promo-code").trim();

        if (promoCode.isEmpty()) {
            promoCode = null;
        }

        DAO dao = new DAO();
        Discount discount = dao.getDiscountByCode(promoCode);

        double discountPercent = 0;
        String message;

        // Check if the discount code is valid
        if (discount != null) {
            discountPercent = discount.getDiscountPercentage();
            message = "Áp dụng thành công";
        } else {
            message = "Mã giảm giá không hợp lệ";
        }

        // Retrieve the cart for the specific table from the database
        List<Cart> cartList = dao.getCartsByTableName(tableName);

        // Apply discount and promo code to each cart in the list for the specific table
        for (Cart cart : cartList) {
            cart.setDiscountPercent(discountPercent);
            cart.setPromoCode(discount != null ? promoCode : "");
            dao.updateCart(cart); // Update the cart in the database
        }

        // Forward to table detail control servlet
        String redirectUrl = "tableDetailControl?tableName=" + tableName + "&discountMessage=" + URLEncoder.encode(message, "UTF-8");
        response.sendRedirect(redirectUrl);
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
