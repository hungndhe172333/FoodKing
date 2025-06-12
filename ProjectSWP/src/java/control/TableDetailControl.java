package control;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import model.Item;

/**
 *
 * @author minhp
 */
public class TableDetailControl extends HttpServlet {

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
        
        // Create maps to hold the aggregated products, total prices, and product images for each table
        Map<String, Map<String, Integer>> tableAggregatedProducts = new HashMap<>();
        Map<String, Double> tableTotalPrices = new HashMap<>();
        Map<String, Map<String, String>> tableProductImages = new HashMap<>();
        Map<String, List<Customer>> tableCustomers = new HashMap<>();

        // Retrieve data from the database using the DAO
        DAO dao = new DAO();
        Map<String, List<Cart>> tableCarts = dao.getAllTableCarts();

        // Check if tableCarts is not null
        if (tableCarts != null) {
            // Loop through each list of carts and each cart in the list
            for (Map.Entry<String, List<Cart>> entry : tableCarts.entrySet()) {
                String tableName = entry.getKey();
                List<Cart> carts = entry.getValue();

                // Initialize aggregated products, total price, and product images for the current table
                Map<String, Integer> aggregatedProducts = new HashMap<>();
                Map<String, String> productImages = new HashMap<>();
                double totalPrice = 0;
                List<Customer> customers = new ArrayList<>();

                for (Cart cart : carts) {
                    if ("Đã xác nhận".equals(cart.getStatus())) {
                        for (Item item : cart.getItems()) {
                            String productName = item.getProduct().getName();
                            int quantity = item.getQuantity();
                            double price = item.getProduct().getPrice();
                            String image = item.getProduct().getImage(); // Retrieve product image

                            // Aggregate the product quantities
                            aggregatedProducts.put(productName, aggregatedProducts.getOrDefault(productName, 0) + quantity);

                            // Store the product image
                            productImages.put(productName, image);

                            // Calculate the total price
                            totalPrice += price * quantity;
                        }
                        if (cart.getCustomer() != null && !customers.contains(cart.getCustomer())) {
                            customers.add(cart.getCustomer());
                        }
                    }
                }

                // Store the aggregated products, total price, and product images for the current table
                tableAggregatedProducts.put(tableName, aggregatedProducts);
                tableTotalPrices.put(tableName, totalPrice);
                tableProductImages.put(tableName, productImages);
                tableCustomers.put(tableName, customers);
            }
        }

        String tableName = request.getParameter("tableName");
        request.setAttribute("tableCarts", tableCarts);
        request.setAttribute("tableName", tableName);
        request.setAttribute("tableAggregatedProducts", tableAggregatedProducts);
        request.setAttribute("tableTotalPrices", tableTotalPrices);
        request.setAttribute("tableProductImages", tableProductImages);
        request.setAttribute("tableCustomers", tableCustomers);
        request.getRequestDispatcher("TableDetail.jsp").forward(request, response);
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
