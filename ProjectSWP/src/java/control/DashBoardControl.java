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
import java.util.Calendar;
import java.util.List;
import model.OrderDetail;

public class DashBoardControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

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

        //Cập nhật tổng bill
        dao.updateOrderFromOrderDetail();

        //update giá của Tran sau khi đã tính discount từ Order
        dao.updateToOrderFromTranHis();

        //Cập nhật doanh thu
        dao.updateRevenue();

        int totalTranHis = dao.getTotalTranHis();
        int totalRevenue = dao.getTotalRevenue();
        int avgEveryTrans = totalRevenue / totalTranHis;
        int tranTypeOnl = dao.getTranTypeOnl();
        int tranTypeOff = dao.getTranTypeOff();
        List<OrderDetail> listOrderDetails = dao.getTop5Product();
        List<Integer> listDay = dao.getTransactionsYear();

        request.setAttribute("listOrderDetails", listOrderDetails);
        request.setAttribute("tranTypeOnl", tranTypeOnl);
        request.setAttribute("tranTypeOff", tranTypeOff);
        request.setAttribute("avgEveryTrans", avgEveryTrans);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalTranHis", totalTranHis);
        request.setAttribute("testD", false);
        request.setAttribute("selectedMonth", 0);
        request.setAttribute("listDay", listDay);
        request.getRequestDispatcher("DashBoard.jsp").forward(request, response);

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

        DAO dao = new DAO();

        String stringDay = request.getParameter("selectedDay");
        int month = Integer.parseInt(request.getParameter("selectedMonth"));
        int selectedYear = Calendar.getInstance().get(Calendar.YEAR);

        // Logic to determine the number of days in the selected month
        int daysInMonth = 0;
        if (month == 2) {
            daysInMonth = (selectedYear % 4 == 0) ? 29 : 28;
        } else if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
            daysInMonth = 31;
        } else {
            daysInMonth = 30;
        }

        //Cập nhật tổng bill
        dao.updateOrderFromOrderDetail();

        //update giá của Tran sau khi đã tính discount từ Order
        dao.updateToOrderFromTranHis();

        //Cập nhật doanh thu
        dao.updateRevenue();

        int totalTranHis = 0;
        int totalRevenue = 0;
        int avgEveryTrans = 0;
        int tranTypeOnl = 0;
        int tranTypeOff = 0;
        int day = 0;
        List<OrderDetail> listOrderDetails = null;
        List<Integer> listDay = dao.getTransactionsPerDay(month);

        //Nếu chỉ chọn tháng
        if (stringDay == null || stringDay.equals("0")) {
            totalTranHis = dao.getTotalTranHisByMonth(month);
            totalRevenue = dao.getTotalRevenueByMonth(month);
            if (totalTranHis != 0 && totalRevenue != 0) {
                avgEveryTrans = totalRevenue / totalTranHis;
            }
            tranTypeOnl = dao.getTranTypeOnlByMonth(month);
            tranTypeOff = dao.getTranTypeOffByMonth(month);

            listOrderDetails = dao.getTop5ProductByMonth(month);
        } else {
            day = Integer.parseInt(stringDay);
            totalTranHis = dao.getTotalTranHisByMonthDay(month, day);
            totalRevenue = dao.getTotalRevenueByMonthDay(month, day);
            if (totalTranHis != 0 && totalRevenue != 0) {
                avgEveryTrans = totalRevenue / totalTranHis;
            }
            tranTypeOnl = dao.getTranTypeOnlByMonthDay(month, day);
            tranTypeOff = dao.getTranTypeOffByMonthDay(month, day);
            
            listOrderDetails = dao.getTop5ProductByMonthDay(month, day);
        }

        request.setAttribute("listOrderDetails", listOrderDetails);
        request.setAttribute("tranTypeOnl", tranTypeOnl);
        request.setAttribute("tranTypeOff", tranTypeOff);
        request.setAttribute("avgEveryTrans", avgEveryTrans);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalTranHis", totalTranHis);
        request.setAttribute("listDay", listDay);
        request.setAttribute("testD", true);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedDay", day);
        request.setAttribute("daysInMonth", daysInMonth);
        request.getRequestDispatcher("DashBoard.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
