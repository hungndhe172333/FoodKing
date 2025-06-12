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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Cart;
import model.Item;
import model.Product;

/**
 *
 * @author minhp
 */
public class BuyControl extends HttpServlet {

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
            out.println("<title>Servlet BuyControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuyControl at " + request.getContextPath() + "</h1>");
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
        if (session == null || session.getAttribute("tableCarts") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String tableName = request.getParameter("tableName");
        String customerName = request.getParameter("customerName");
        String phoneNumber = request.getParameter("phoneNumber");

        // Retrieve or create tableCarts map from session
        Map<String, List<Cart>> tableCarts = (Map<String, List<Cart>>) session.getAttribute("tableCarts");
        if (tableCarts == null) {
            tableCarts = new HashMap<>();
        }

        // Retrieve or create cart list for the specific table
        List<Cart> cartList = tableCarts.computeIfAbsent(tableName, k -> new ArrayList<>());

        // Get the current cart ID from session
        Integer currentCartId = (Integer) session.getAttribute("currentCartId");

        // Find the current cart using the currentCartId
        Cart currentCart = null;
        for (Cart cart : cartList) {
            if (cart.getId() == currentCartId) {
                currentCart = cart;
                break;
            }
        }

        if (currentCart == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"status\":\"error\", \"message\":\"Cart not found.\"}");
                out.flush();
            }
            return;
        }
        
        // Add item to the current cart
        String tid = request.getParameter("id");
        try {
            int id = Integer.parseInt(tid);
            DAO dao = new DAO();
            Product product = dao.getProductByID(id);
            Item item = new Item(product, 1);
            currentCart.addItem(item);
            currentCart.setStatus("Đang chọn món");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        // Update session attributes
        tableCarts.put(tableName, cartList);
        session.setAttribute("tableCarts", tableCarts);
        session.setAttribute("size", currentCart.getItems().size());

        // Send JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.write("{\"status\":\"success\", \"size\":" + currentCart.getItems().size() + "}");
            out.flush();
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
