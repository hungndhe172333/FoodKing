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
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author minhp
 */
@WebServlet(name = "ShopControl", urlPatterns = {"/shop"})
public class ShopControl extends HttpServlet {

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
        if (session == null || session.getAttribute("tableCarts") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        DAO dao = new DAO();

        String cateID = request.getParameter("cid");
        String type = request.getParameter("type");
        String indexPage = request.getParameter("index");

        List<Product> list;
        int count;
        int endPage = 0;
        int index = 1;

        if (indexPage == null) {
            indexPage = "1";
        }
        index = Integer.parseInt(indexPage);

        if (cateID != null) {
            count = dao.getTotalProductByCID(cateID);
            if (type != null && (type.equalsIgnoreCase("asc") || type.equalsIgnoreCase("desc"))) {
                list = dao.getProductByCID(cateID, index, type); 
            } else {
                list = dao.getProductByCID(cateID, index); 
            }
            request.setAttribute("check", cateID);
        } else {
            count = dao.getTotalProduct();
            if (type != null && (type.equalsIgnoreCase("asc") || type.equalsIgnoreCase("desc"))) {
                list = dao.getProductByType(type, index);
            } else {
                list = dao.pagingAccount(index);
            }
            request.setAttribute("check", null);
        }

        endPage = count / 3;
        if (count % 3 != 0) {
            endPage++;
        }

        List<Category> listC = dao.getAllCategory();
        List<Product> list4Product = dao.get4LastProduct();

        request.setAttribute("listP", list);
        request.setAttribute("totalproduct", count);
        request.setAttribute("list4", list4Product);
        request.setAttribute("listC", listC);
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.setAttribute("type", type);

        request.getRequestDispatcher("Shop.jsp").forward(request, response);
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
