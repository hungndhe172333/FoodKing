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
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import model.Cart;
import model.Item;
import model.Product;
import model.Table;

/**
 *
 * @author minhp
 */
public class CheckoutControl extends HttpServlet {

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
            out.println("<title>Servlet CheckoutControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutControl at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        
        String tableName = request.getParameter("tableName");

        Map<String, List<Cart>> tableCarts = (Map<String, List<Cart>>) session.getAttribute("tableCarts");

        if (tableCarts == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"status\":\"error\", \"message\":\"No carts found\"}");
                out.flush();
            }
            return;
        }

        List<Cart> cartList = tableCarts.get(tableName);

        if (cartList == null) {
            cartList = new ArrayList<>();
        }

        Cart currentCart = cartList.isEmpty() ? new Cart() : cartList.get(cartList.size() - 1);

        if (currentCart == null || currentCart.getItems().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"status\":\"error\", \"message\":\"Cart is empty\"}");
                out.flush();
            }
            return;
        }

        // Kiểm tra số lượng tồn kho
        boolean isStockAvailable = checkStockAvailability(currentCart);
        if (!isStockAvailable) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"status\":\"error\", \"message\":\"Not enough stock available\"}");
                out.flush();
            }
            return;
        }

        // Update status of current cart
        currentCart.setStatus("Đang chờ xác nhận");
        //DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        currentCart.setCheckoutTime(LocalDateTime.now());
        cartList.set(cartList.size() - 1, currentCart);
        
        DAO dao = new DAO();
        try {
            Integer cartId = (Integer) session.getAttribute("currentCartId");
            if (cartId != null) {
                currentCart.setId(cartId);
                dao.updateCart(currentCart, tableName);
            } else {
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        
        Cart newCart = new Cart();
        newCart.setCustomer(currentCart.getCustomer()); // Set the customer information from the current cart
        newCart.setId(dao.insertCartFirstAccess(newCart, tableName)); // Save the new cart and get the new ID
        newCart.setTable(new Table(tableName));
        session.setAttribute("currentCartId", newCart.getId());

        cartList.add(newCart);
        tableCarts.put(tableName, cartList);
        session.setAttribute("tableCarts", tableCarts);


        session.setAttribute("size", newCart.getItems().size());
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.write("{\"status\":\"success\"}");
            out.flush();
        }
    }

    private boolean checkStockAvailability(Cart cart) {
        DAO productDAO = new DAO();

        for (Item item : cart.getItems()) {
            Product product = productDAO.getProductByID(item.getProduct().getProduct_id());
            if (product.getStock_quantity() < item.getQuantity()) {
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
