package control;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Discount;

public class EditDiscountControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        String discountId = request.getParameter("discountId");
//        DAO dao = new DAO();
//        Discount discount = dao.getDiscountById(Integer.parseInt(discountId));
//        
//        request.setAttribute("discount", discount);
//        request.getRequestDispatcher("ManagerDiscount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String discountId = request.getParameter("discountId");
        String code = request.getParameter("code");
        String discountPercentageStr = request.getParameter("discountPercentage");
        String activeStr = request.getParameter("active");

        double discountPercentage = Double.parseDouble(discountPercentageStr);
        boolean active = Boolean.parseBoolean(activeStr);

        DAO dao = new DAO();
        List<Discount> listD = dao.getAllDiscount();
        if (!checkInsertDiscount(listD, code)) {
            request.setAttribute("ms", "Mã giảm giá này đã tồn tại!");
        } else {
            dao.updateDiscountById(code, discountPercentage, active, discountId);
            request.setAttribute("ms", "Cập nhật thành công");
            listD = dao.getAllDiscount();
        }

        request.setAttribute("listD", listD);
        request.getRequestDispatcher("ManagerDiscount.jsp").forward(request, response);
    }

    public boolean checkInsertDiscount(List<Discount> list, String code) {
        for (Discount discount : list) {
            if (discount.getCode().equals(code)) {
                return false;
            }
        }
        return true;
    }

    @Override
    public String getServletInfo() {
        return "Servlet to edit discount information";
    }
}
