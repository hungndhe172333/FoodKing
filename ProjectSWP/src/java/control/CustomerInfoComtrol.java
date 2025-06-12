/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dal.DAO;
import java.io.IOException;
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
import model.Customer;
import model.Table;

/**
 *
 * @author minhp
 */
public class CustomerInfoComtrol extends HttpServlet {

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
        HttpSession session = request.getSession();
        String tableName = request.getParameter("tableName");
        DAO dao = new DAO();

        
        if (!dao.tableExists(tableName)) {
            request.setAttribute("error", "Bàn không tồn tại");
            request.getRequestDispatcher("CustomerInfo.jsp?tableName="+tableName).forward(request, response);
            return;
        }
        
        Map<String, List<Cart>> tableCarts = (Map<String, List<Cart>>) session.getAttribute("tableCarts");
        if (tableCarts == null) {
            tableCarts = new HashMap<>();
        }

        List<Cart> cartList = tableCarts.computeIfAbsent(tableName, k -> new ArrayList<>());

        String customerName = request.getParameter("customerName");
        String phoneNumber = request.getParameter("phoneNumber");

        boolean customerExists = false;
        for (Cart c : cartList) {
            Customer cust = c.getCustomer();
            if (cust != null && cust.getPhone_number() != null && cust.getPhone_number().equals(phoneNumber)) {
                customerExists = true;
                break;
            }
        }

        if (!customerExists) {
            Cart newCart = new Cart();
            newCart.setCustomer(new Customer(customerName, phoneNumber));
            newCart.setStatus("Đang chọn món");
            newCart.setTable(new Table(tableName));

            cartList.add(newCart);

            tableCarts.put(tableName, cartList);
            session.setAttribute("tableCarts", tableCarts);

            try {
                int cartId = dao.insertCartFirstAccess(newCart, tableName);
                if (cartId != -1) {
                    newCart.setId(cartId);
                    session.setAttribute("currentCartId", cartId);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
        } else {
            request.setAttribute("error", "Customer already exists.");
        }

        request.getRequestDispatcher("home").forward(request, response);
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
