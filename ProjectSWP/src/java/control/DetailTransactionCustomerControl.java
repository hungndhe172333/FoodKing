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
import java.util.List;
import model.Customer;
import model.Discount;
import model.OrderDetail;
import model.TransactionHistory;

/**
 *
 * @author minhp
 */
public class DetailTransactionCustomerControl extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        DAO dao = new DAO();
        
        int id = Integer.parseInt(request.getParameter("customer_id"));
        Customer c = dao.getCustomerById(id);
        int totalOrder = dao.getTotalOrderByCustomerId(id);
        int totalAmount = dao.getTotalAmountByCustomerId(id);
        List<TransactionHistory> listTransactionHistorys = dao.getTranHisByCId(id);
        
        request.setAttribute("listTransactionHistorys", listTransactionHistorys);
        request.setAttribute("c", c);
        request.setAttribute("totalOrder", totalOrder);
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("DetailTransactionCustomer.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
        
        int tranHisId = Integer.parseInt(request.getParameter("thID"));
        int CustomerId = Integer.parseInt(request.getParameter("CID"));
        
        Customer c = dao.getCustomerById(CustomerId);
        TransactionHistory tranHis = dao.getDetailTranHis(tranHisId);
        Discount d = dao.getDiscountByTranHisId(tranHisId);
        List<OrderDetail> od = dao.getOrderDetailByTranHisId(tranHisId);
        
        request.setAttribute("od", od);
        request.setAttribute("discount", d);
        request.setAttribute("c", c);
        request.setAttribute("tranHis", tranHis);
        request.getRequestDispatcher("TransactionByCustomerId.jsp").forward(request, response); 
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
