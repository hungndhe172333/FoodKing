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
import java.util.Map;
import model.Cart;
import model.Discount;
import model.Employees;
import java.util.List;

/**
 *
 * @author minhp
 */
public class CompletePaymentControl extends HttpServlet {

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
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("employ") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        DAO dao = new DAO();
        
        
        String tableName = request.getParameter("tableName");
        String totalMoney = request.getParameter("totalMoney");
        String transactiontype = request.getParameter("transactiontype");
        String phonenumber = request.getParameter("phoneNumber");

        System.out.println("Received parameters:");
        System.out.println("Table Name: " + tableName);
        System.out.println("Total Money: " + totalMoney);
        System.out.println("Transaction Type: " + transactiontype);
        System.out.println("Phone Number: " + phonenumber);

        // Retrieve the cart list from the session
        Map<String, List<Cart>> tableCarts = dao.getAllTableCarts();

        if (tableCarts == null || !tableCarts.containsKey(tableName)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No tableCarts found for the given table.");
            return;
        }

        List<Cart> cartList = tableCarts.get(tableName);

        String customerName = null;
        String phoneNumber = null;
        Cart customerCart = null;

        for (Cart cart : cartList) {
            if (cart.getCustomer().getPhone_number().equals(phonenumber)) {
                customerName = cart.getCustomer().getName();
                phoneNumber = cart.getCustomer().getPhone_number();
                customerCart = cart;
                break;
            }
        }

        System.out.println("Customer Details:");
        System.out.println("Customer Name: " + customerName);
        System.out.println("Phone Number: " + phoneNumber);

        int table_id = dao.getTableIdByName(tableName);
        Discount discount = dao.getDiscountByCode(customerCart.getPromoCode());
        Integer discountId = (discount != null) ? discount.getDiscountId() : null;
        Employees employee = (Employees) session.getAttribute("employ");

        if (employee == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No employee information found.");
            return;
        }

        System.out.println("Employee ID: " + employee.getEmployee_id());
        System.out.println("Table ID: " + table_id);
        System.out.println("Discount ID: " + discountId);

        // Insert customer and order
        int orderId = dao.insertCustomerAndOrders(customerName, phoneNumber, table_id, Double.parseDouble(totalMoney), discountId);

        System.out.println("Order ID: " + orderId);

        // Insert order details
        if (orderId != -1) {
            dao.insertOrderDetails(orderId, cartList);
            dao.insertOrUpdateRevenue(new java.util.Date(), Double.parseDouble(totalMoney));
            dao.insertTransaction(orderId, employee.getEmployee_id(), Double.parseDouble(totalMoney), transactiontype);

            System.out.println("Order completed successfully.");

            // Optional: Clear cart after completion
            tableCarts.remove(tableName);
            dao.clearCartByTableName(tableName);
            response.sendRedirect("tableControl");
        } else {
            System.out.println("Failed to create order.");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create order.");
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
