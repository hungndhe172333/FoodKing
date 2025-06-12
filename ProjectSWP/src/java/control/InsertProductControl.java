package control;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author admin
 */
@MultipartConfig
public class InsertProductControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InsertProductControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InsertProductControl at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        List<Category> listCate = dao.getAllCategory();
        String ms = "";

        String pName = request.getParameter("productName");
        String pQualityParam = request.getParameter("quality");

        int pQuality = 0; // Giá trị mặc định
        if (pQualityParam != null && !pQualityParam.isEmpty()) {
            pQuality = Integer.parseInt(pQualityParam);
        }

        String priceParam = request.getParameter("price");
        double price = 0.0; // Giá trị mặc định
        if (priceParam != null && !priceParam.isEmpty()) {
            price = Double.parseDouble(priceParam.trim());
        }
        String description = request.getParameter("description");

        Category c = new Category();
        int categoryId = 0; // Giá trị mặc định
        String categoryString = request.getParameter("category");
        if (categoryString.equals("Other")) {
            String cateNew = request.getParameter("otherCategory");
            for (int i = 0; i < listCate.size(); i++) {
                if (cateNew.equalsIgnoreCase(listCate.get(i).getName())) {
                    categoryId = listCate.get(i).getCategory_id();
                    for (int j = 0; j < listCate.size(); j++) {
                        if (listCate.get(j).getCategory_id() == categoryId) {
                            c.setCategory_id(categoryId);
                            c.setName(listCate.get(j).getName());
                            break;
                        }
                    }
                    break;
                }
                if (i == listCate.size() - 1) {
                    dao.addCategory(cateNew);
                    List<Category> arrCate = dao.getAllCategory();
                    for (int j = 0; j < arrCate.size(); j++) {
                        if (arrCate.get(j).getName().equalsIgnoreCase(cateNew)) {
                            c.setCategory_id(arrCate.get(j).getCategory_id());
                            c.setName(cateNew);
                            break;
                        }
                    }
                }
            }
        } else {
            if (categoryString != null && !categoryString.isEmpty()) {
                categoryId = Integer.parseInt(categoryString);
            }
            for (int i = 0; i < listCate.size(); i++) {
                if (listCate.get(i).getCategory_id() == categoryId) {
                    c.setCategory_id(categoryId);
                    c.setName(listCate.get(i).getName());
                    break;
                }
            }
        }
        List<Category> listCate2 = dao.getAllCategory();

        // Lấy tệp ảnh từ request
        Part filePart = request.getPart("productImage");
        String fileName = getFileName(filePart);

        // Kiểm tra loại MIME của tệp
        String mimeType = filePart.getContentType();
        if (mimeType.startsWith("image/")) {
            // Chỉ xử lý tệp nếu nó là một hình ảnh
            String projectPath = new File(getServletContext().getRealPath("")).getParentFile().getParentFile().getAbsolutePath();
            String uploadPath = projectPath + File.separator + "web" + File.separator + "assets" + File.separator + "img" + File.separator + "food";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Tạo các thư mục cần thiết
            }
            String filePath = uploadPath + File.separator + fileName;
            try (InputStream input = filePart.getInputStream();
                 FileOutputStream output = new FileOutputStream(filePath)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }
            // Đường dẫn tương đối trên máy chủ
            String relativePath = "assets/img/food/" + fileName;

            // Lưu sản phẩm vào cơ sở dữ liệu
            dao.addProduct(pName, description, price, pQuality, c, relativePath);
            ms = "Đã thêm sản phẩm mới!";

            List<Product> listP = dao.getAllProduct();
            request.setAttribute("listP", listP);
            request.setAttribute("ms", ms);
            request.setAttribute("listCategorys", listCate2);
            request.getRequestDispatcher("ManagerProduct.jsp").forward(request, response);
        } else {

            // Nếu tệp không phải là hình ảnh, đưa ra thông báo lỗi
            ms = "Tệp được gửi không phải là hình ảnh hợp lệ. Vui lòng thử lại.";

            List<Product> listP = dao.getAllProduct();
            request.setAttribute("listP", listP);
            request.setAttribute("ms", ms);
            request.setAttribute("listCategorys", listCate2);
            request.getRequestDispatcher("ManagerProduct.jsp").forward(request, response);

        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
