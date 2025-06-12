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
public class ProcessControl extends HttpServlet {

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
            out.println("<title>Servlet ProcessControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProcessControl at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private Cart findCartById(List<Cart> cartList, int cartId) {
        for (Cart cart : cartList) {
            if (cart.getId() == cartId) {
                return cart;
            }
        }
        return null;
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
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("employ") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String tableName = request.getParameter("tableName");
        int cartId = Integer.parseInt(request.getParameter("cartId"));
        String tnum = request.getParameter("num").trim();
        String tid = request.getParameter("id");

        Map<String, List<Cart>> tableCarts = (Map<String, List<Cart>>) session.getAttribute("tableCarts");
        if (tableCarts == null) {
            tableCarts = new HashMap<>();
            session.setAttribute("tableCarts", tableCarts);
        }

        List<Cart> cartList = tableCarts.get(tableName);
        if (cartList == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Cart cart = findCartById(cartList, cartId);
        if (cart == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(tid);
            int num = Integer.parseInt(tnum);
            if (num == -1 && cart.getQuantityById(id) <= 1) {
                cart.removeItem(id);
            } else {
                DAO dao = new DAO();
                Product p = dao.getProductByID(id);
                Item t = new Item(p, num);
                cart.addItem(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (cart.getItems().isEmpty()) {
            cartList.remove(cart);
            Cart newCart = new Cart();
            cartList.add(newCart);
            tableCarts.put(tableName, cartList);
        } else {
            tableCarts.put(tableName, cartList);
        }

        // Kiểm tra trạng thái của giỏ hàng
        if (!"Đang chờ xác nhận".equals(cart.getStatus())) {
            session.setAttribute("size", cart.getItems().size());
        }
        session.setAttribute("tableCarts", tableCarts);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"size\": " + cart.getItems().size() + "}");
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
        HttpSession session = request.getSession();
        String tableName = request.getParameter("tableName");
        int cartId = Integer.parseInt(request.getParameter("cartId"));
        String tid = request.getParameter("id");

        Map<String, List<Cart>> tableCarts = (Map<String, List<Cart>>) session.getAttribute("tableCarts");
        if (tableCarts == null) {
            tableCarts = new HashMap<>();
            session.setAttribute("tableCarts", tableCarts);
        }

        List<Cart> cartList = tableCarts.get(tableName);
        if (cartList == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Cart cart = findCartById(cartList, cartId);
        if (cart == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(tid);
            cart.removeItem(id);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (cart.getItems().isEmpty()) {
            cartList.remove(cart);
            Cart newCart = new Cart();
            cartList.add(newCart);
            tableCarts.put(tableName, cartList);
        } else {
            tableCarts.put(tableName, cartList);
        }

        // Kiểm tra trạng thái của giỏ hàng
        if (!"Đang chờ xác nhận".equals(cart.getStatus())) {
            session.setAttribute("size", cart.getItems().size());
        }
        session.setAttribute("tableCarts", tableCarts);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"size\": " + cart.getItems().size() + "}");
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
