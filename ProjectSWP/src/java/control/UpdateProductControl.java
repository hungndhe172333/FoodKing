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
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author admin
 */
@MultipartConfig
public class UpdateProductControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateProductControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProductControl at " + request.getContextPath() + "</h1>");
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
        String productIdString = request.getParameter("id");

        DAO dao = new DAO();
        List<Product> listP = dao.getAllProduct();

        String productName = "";
        String productDescription = "";
        double productPrice = 0;
        int productQuantity = 0;
        int categoryId = 0;
        String productImg = "";

        if (productIdString == null || productIdString.isEmpty()) {
            response.sendRedirect("managerproducts");
            return;
        }
        int productId = Integer.parseInt(productIdString);
        for (int i = 0; i < listP.size(); i++) {
            if (listP.get(i).getProduct_id() == productId) {
                productName = listP.get(i).getName();
                productDescription = listP.get(i).getDescription();
                productPrice = listP.get(i).getPrice();
                productQuantity = listP.get(i).getStock_quantity();
                categoryId = listP.get(i).getCategory_id().getCategory_id();
                productImg = listP.get(i).getImage();
                break;
            }
        }
        Category cate = new Category();
        List<Category> listCategorys = dao.getAllCategory();
        for (int i = 0; i < listCategorys.size(); i++) {
            if (listCategorys.get(i).getCategory_id() == categoryId) {
                cate.setCategory_id(categoryId);
                cate.setName(listCategorys.get(i).getName());
                break;
            }
        }

        request.setAttribute("productId", productId);
        request.setAttribute("productName", productName);
        request.setAttribute("productDescription", productDescription);
        request.setAttribute("productPrice", productPrice);
        request.setAttribute("productQuantity", productQuantity);
        request.setAttribute("cate", cate);
        request.setAttribute("productImg", productImg);
        request.setAttribute("listCategorys", listCategorys);
        request.getRequestDispatcher("UpdateProduct.jsp").forward(request, response);
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
        int pQuantity = 0; // Giá trị mặc định
        if (pQualityParam != null && !pQualityParam.isEmpty()) {
            pQuantity = Integer.parseInt(pQualityParam);
        }

        String priceParam = request.getParameter("price");
        double price = 0; // Giá trị mặc định
        if (priceParam != null && !priceParam.isEmpty()) {
            price = Double.parseDouble(priceParam.trim());
        }
        String description = request.getParameter("description");

        Category c = new Category();
        int categoryId = 0; // Giá trị mặc định
        String categoryString = request.getParameter("category");

        // Nếu người dùng chọn Other
        if (categoryString != null && categoryString.equals("Other")) {
            String cateNew = request.getParameter("otherCategory");
            for (int i = 0; i < listCate.size(); i++) {

                // Nếu đã xuất hiện Category
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

                // Nếu không có Category
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

        String imagePath = "";

        String productIdString = request.getParameter("productId");
        int productId = 0;
        if (productIdString != null && !productIdString.isEmpty()) {
            productId = Integer.parseInt(productIdString);
        }
        Product p = dao.getProductByID(productId);

        // Kiểm tra nếu người dùng không thay ảnh
        Part filePart = request.getPart("productImage");
        if (filePart == null || filePart.getSize() == 0) {
            imagePath = p.getImage();
        } else {
            // Kiểm tra loại MIME của tệp
            String mimeType = filePart.getContentType();
            if (mimeType.startsWith("image/")) {
                // Chỉ xử lý tệp nếu nó là một hình ảnh
                String fileName = getFileName(filePart);
                String projectPath = new File(getServletContext().getRealPath("")).getParentFile().getParentFile().getAbsolutePath();
                String uploadPath = projectPath + File.separator + "web" + File.separator + "assets" + File.separator + "img" + File.separator + "food";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                filePart.write(uploadPath + File.separator + fileName);
                imagePath = "assets/img/food/" + fileName;
            } else {
                ms = "Vui lòng chọn một tệp ảnh hợp lệ!";
                request.setAttribute("ms", ms);
                request.getRequestDispatcher("UpdateProduct.jsp").forward(request, response);
                return;
            }
        }

        dao.updateProduct(pName, description, price, pQuantity, c, imagePath, productId);
        ms = "Đã cập nhật sản phẩm thành công!";
        List<Product> listP = dao.getAllProduct();
        request.setAttribute("listP", listP);
        request.setAttribute("ms", ms);
        request.setAttribute("listCategorys", listCate2);
        request.getRequestDispatcher("ManagerProduct.jsp").forward(request, response);
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
