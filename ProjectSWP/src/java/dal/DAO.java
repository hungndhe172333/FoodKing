/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Admin;
import model.Attendance;
import model.Cart;
import model.Category;
import model.Employees;
import model.Product;
import model.Table;
import model.Customer;
import model.Discount;
import model.Item;
import model.Order;
import model.OrderDetail;
import model.Revenue;
import model.Salaries;
import model.ShiftPattern;
import model.TransactionHistory;
import model.WorkShift;

/**
 *
 * @author cuongDepTrai
 */
public class DAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public int getTableIdByName(String tableName) {
        String sql = "SELECT table_id FROM Tables WHERE table_name = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, tableName);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("table_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean tableExists(String tableName) {
        boolean exists = false;
        String query = "SELECT 1 FROM Tables WHERE table_name = ? and active = 1";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, tableName);
            rs = ps.executeQuery();
            exists = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }

    public void insertTable(String qr_code, String table_name) {
        try {
            String sql = """
                         INSERT INTO [dbo].[Tables]
                         ([qr_code], [table_name])
                         VALUES (?, ?)""";

            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, qr_code);
            stm.setString(2, table_name);
            stm.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi để tiện debug
        }
    }

    public void updateServedStatus(int productId, boolean served) {
        String query = "UPDATE Items SET served = ? WHERE product_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setBoolean(1, served);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void showDiscount(int id) {
        try {
            con = new DBContext().getConnection();
            String sql = """
                         Update Discounts set active = 1
                         where discount_id = ?""";

            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();

        } catch (Exception e) {

        }
    }

    public void showTable(int id) {
        try {
            con = new DBContext().getConnection();
            String sql = """
                         Update Tables set active = 1
                         where Table_id = ?""";

            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();

        } catch (Exception e) {

        }
    }

    public Discount getDiscountByCode(String code) {
        String query = """
                       SELECT [discount_id]
                             ,[code]
                             ,[discount_percentage]
                         FROM [SWP391].[dbo].[Discounts] where code=? """;

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, code);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Discount(rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int insertCustomerAndOrders(String customerName, String customerPhone, int tableId, double totalAmount, Integer discountId) {
        int orderId = -1;
        Connection con = null;
        PreparedStatement psCustomer = null;
        PreparedStatement psOrder = null;
        ResultSet rsCustomer = null;
        ResultSet rsOrder = null;

        try {
            con = new DBContext().getConnection();
            con.setAutoCommit(false); // Start transaction

            // Insert customer
            String insertCustomerSQL = "INSERT INTO [dbo].[Customers] ([name], [phone_number]) VALUES (?, ?)";
            psCustomer = con.prepareStatement(insertCustomerSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            psCustomer.setString(1, customerName);
            psCustomer.setString(2, customerPhone);
            psCustomer.executeUpdate();

            // Retrieve generated customer_id
            rsCustomer = psCustomer.getGeneratedKeys();
            int customerId = -1;
            if (rsCustomer.next()) {
                customerId = rsCustomer.getInt(1);
            }

            // Insert order
            String insertOrderSQL = "INSERT INTO [dbo].[Orders] ([table_id], [customer_id], [total_amount], [discount_id]) VALUES (?, ?, ?, ?)";
            psOrder = con.prepareStatement(insertOrderSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, tableId);
            psOrder.setInt(2, customerId);
            psOrder.setDouble(3, totalAmount);
            if (discountId != null) {
                psOrder.setInt(4, discountId);
            } else {
                psOrder.setNull(4, java.sql.Types.INTEGER);
            }
            psOrder.executeUpdate();

            // Retrieve generated order_id
            rsOrder = psOrder.getGeneratedKeys();
            if (rsOrder.next()) {
                orderId = rsOrder.getInt(1);
            }

            con.commit(); // Commit transaction

        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback(); // Rollback transaction on error
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        }
        return orderId;
    }

    public void insertPayment(int orderId, String paymentMethod) {
        String insertPaymentSQL = "INSERT INTO [dbo].[Payments] ([order_id], [payment_method]) VALUES (?, ?)";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(insertPaymentSQL)) {

            ps.setInt(1, orderId);
            ps.setString(2, paymentMethod);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertTransaction(int orderId, int employeeId, double transactionAmount, String transactionType) {
        String insertTransactionSQL = "INSERT INTO [dbo].[TransactionHistory] ([order_id], [employee_id], [transaction_amount], [transaction_type], [transaction_date]) VALUES (?, ?, ?, ?, CAST(GETDATE() AS DATE))";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(insertTransactionSQL)) {

            ps.setInt(1, orderId);
            ps.setInt(2, employeeId);
            ps.setDouble(3, transactionAmount);
            ps.setString(4, transactionType);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean deleteWorkShiftOfEmployee(String employee_id, String pattern_id) {
        String sql = "UPDATE [dbo].[WorkShifts]\n"
                + "   SET [active] = 0\n"
                + " WHERE employee_id = ? AND pattern_id = ? AND active = 1;";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, employee_id);
            ps.setString(2, pattern_id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private Map<Integer, Item> aggregateItemsFromCarts(List<Cart> carts) {
        Map<Integer, Item> aggregatedItems = new HashMap<>();

        for (Cart cart : carts) {
            if ("Đã xác nhận".equals(cart.getStatus())) {
                for (Item item : cart.getItems()) {
                    int productId = item.getProduct().getProduct_id();
                    if (aggregatedItems.containsKey(productId)) {
                        // If item already exists, update the quantity
                        Item existingItem = aggregatedItems.get(productId);
                        existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
                    } else {
                        // If item doesn't exist, add it to the map
                        aggregatedItems.put(productId, new Item(item.getProduct(), item.getQuantity()));
                    }
                }
            }
        }

        return aggregatedItems;
    }

    public void insertOrderDetails(int orderId, List<Cart> carts) {
        if (carts == null || carts.isEmpty()) {
            System.out.println("Cart list is empty or null. Cannot insert order details.");
            return;
        }

        Map<Integer, Item> aggregatedItems = aggregateItemsFromCarts(carts);

        String insertOrderDetailSQL = "INSERT INTO [dbo].[OrderDetails] ([order_id], [product_id], [quantity], [price]) VALUES (?, ?, ?, ?)";

        try (Connection con = new DBContext().getConnection(); PreparedStatement psInsert = con.prepareStatement(insertOrderDetailSQL)) {

            // Insert order details
            for (Item item : aggregatedItems.values()) {
                int productId = item.getProduct().getProduct_id();
                int quantity = item.getQuantity();
                double price = item.getProduct().getPrice();

                // Insert into OrderDetails
                psInsert.setInt(1, orderId);
                psInsert.setInt(2, productId);
                psInsert.setInt(3, quantity);
                psInsert.setDouble(4, price);
                psInsert.addBatch();
            }

            psInsert.executeBatch();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertOrUpdateRevenue(Date date, double revenue) {
        try {
            String query = "IF EXISTS (SELECT * FROM Revenue WHERE date = ?) "
                    + "BEGIN "
                    + "    UPDATE Revenue SET total_revenue = total_revenue + ? WHERE date = ? "
                    + "END "
                    + "ELSE "
                    + "BEGIN "
                    + "    INSERT INTO Revenue (date, total_revenue) VALUES (?, ?) "
                    + "END";
            ps = con.prepareStatement(query);
            java.sql.Date sqlDate = new java.sql.Date(date.getTime());
            ps.setDate(1, sqlDate);
            ps.setDouble(2, revenue);
            ps.setDate(3, sqlDate);
            ps.setDate(4, sqlDate);
            ps.setDouble(5, revenue);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void restoreStockProduct(int cartId) {
        String updateProductQuantitySQL = "UPDATE [dbo].[Products] SET [stock_quantity] = [stock_quantity] + ? WHERE [product_id] = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(updateProductQuantitySQL);
            List<Item> listItem = getItemsByCartId(cartId);
            for (Item item : listItem) {
                int productId = item.getProduct().getProduct_id();
                int quantity = item.getQuantity();

                ps.setInt(1, quantity);
                ps.setInt(2, productId);
                ps.addBatch();
            }

            ps.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean deleteCartById(int cartId) {
        String deleteItemsSql = "DELETE FROM Items WHERE cart_id = ?";
        String deleteCartSql = "DELETE FROM Carts WHERE id = ?";

        try (Connection connection = new DBContext().getConnection()) {

            try (PreparedStatement deleteItemsStatement = connection.prepareStatement(deleteItemsSql); PreparedStatement deleteCartStatement = connection.prepareStatement(deleteCartSql)) {

                // Delete items from the cart
                deleteItemsStatement.setInt(1, cartId);
                deleteItemsStatement.executeUpdate();

                // Delete the cart
                deleteCartStatement.setInt(1, cartId);
                int rowsAffected = deleteCartStatement.executeUpdate();

                return rowsAffected > 0;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Product> get8Product() {
        List<Product> list = new ArrayList<>();
        String query = """
                       select top 8 p.product_id, p.name as [productName], p.description, p.price, p.stock_quantity,
                       p.category_id, c.name as categoryName, p.image
                       from Products p
                       inner join Categories C on p.category_id = c.category_id
                       where p.active = 1""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {

                Category c = new Category();

                c.setCategory_id(rs.getInt("category_id"));
                c.setName(rs.getString("categoryname"));

                list.add(new Product(rs.getInt("product_id"),
                        rs.getString("productname"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        c,
                        rs.getString("image")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public ArrayList<Product> getAllProduct() {
        ArrayList<Product> list = new ArrayList<>();
        String query = """
                       SELECT p.product_id, p.[name] as productname, p.[description], p.price, 
                                              p.stock_quantity, p.[image], p.category_id, c.[name] as categoryname
                                              from Products P
                                              inner join Categories c on p.category_id = c.category_id
                                              where p.active = 1""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {

                Category c = new Category();

                c.setCategory_id(rs.getInt("category_id"));
                c.setName(rs.getString("categoryname"));

                list.add(new Product(rs.getInt("product_id"),
                        rs.getString("productname"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        c,
                        rs.getString("image")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Product> get4FirstProduct() {
        List<Product> list = new ArrayList<>();
        String query = """
                       select top 4 p.product_id, p.name as [productName], p.description, p.price, p.stock_quantity,
                       p.category_id, c.name as categoryName, p.image
                       from Products p
                       inner join Categories C on p.category_id = c.category_id
                       where p.active = 1""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {

                Category cate = new Category(rs.getInt(6), rs.getString(7));

                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getInt(5),
                        cate,
                        rs.getString(8)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Product> get4LastProduct() {
        List<Product> list = new ArrayList<>();
        String query = """
                   WITH LastFour AS (
                       SELECT TOP 4 p.product_id, p.name as [productName], p.description, p.price, p.stock_quantity,
                       p.category_id, c.name as categoryName, p.image
                       FROM Products p
                       INNER JOIN Categories c ON p.category_id = c.category_id
                       WHERE p.active = 1
                       ORDER BY p.product_id DESC
                   )
                   SELECT *
                   FROM LastFour
                   ORDER BY product_id ASC;
                   """;
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category cate = new Category(rs.getInt("category_id"), rs.getString("categoryName"));
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("productName"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        cate,
                        rs.getString("image")
                );
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String query = """
                       SELECT [category_id]
                             ,[name]
                         FROM [SWP391].[dbo].[Categories]""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1),
                        rs.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> pagingAccount(int index) {
        List<Product> list = new ArrayList<>();
        String query = """
                   select p.product_id, p.name as [productName], p.description, p.price, p.stock_quantity,
                          p.category_id, c.name as categoryName, p.image
                   from Products p
                   inner join Categories c on p.category_id = c.category_id
                   where p.active = 1
                   order by p.product_id
                   offset ? rows fetch next 3 rows only;
                   """;
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, (index - 1) * 3);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category cate = new Category(rs.getInt("category_id"), rs.getString("categoryName"));
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("productName"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        cate,
                        rs.getString("image")
                );
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalProduct() {
        String query = "select count(*) from Products "
                + "where active = 1";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalProductByCID(String cid) {
        String query = "select count(*) from Products where category_id=?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, cid);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> getProductByCID(String id, int index) {
        List<Product> list = new ArrayList<>();
        String query = """
           SELECT p.product_id, p.name AS productName, p.description, p.price, p.stock_quantity,
                  p.category_id, c.name AS categoryName, p.image
           FROM Products p
           INNER JOIN Categories c ON p.category_id = c.category_id
           WHERE p.category_id = ? AND p.active = 1
           ORDER BY p.product_id
           OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY
           """;
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            ps.setInt(2, (index - 1) * 3);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category cate = new Category(rs.getInt("category_id"), rs.getString("categoryName"));
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("productName"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        cate,
                        rs.getString("image")
                );
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getProductByID(int id) {

        String query = """
                       SELECT p.product_id, p.[name] as productname, 
                       p.[description], p.price, p.stock_quantity, p.[image],
                       p.category_id, c.[name] as categoryname     
                       from Products P
                       join Categories c on p.category_id = c.category_id
                       where product_id = ? and p.active = 1""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            while (rs.next()) {

                Category c = new Category();
                c.setCategory_id(rs.getInt("category_id"));
                c.setName(rs.getString("categoryname"));

                return new Product(rs.getInt("product_id"),
                        rs.getString("productname"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        c,
                        rs.getString("image"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getProductByType(String type, int index) {
        List<Product> list = new ArrayList<>();
        String query = null;

        if ("desc".equalsIgnoreCase(type)) {
            query = """
                SELECT p.product_id, p.name as [productName], p.description, p.price, p.stock_quantity,
                       p.category_id, c.name as categoryName, p.image
                FROM Products p
                INNER JOIN Categories c ON p.category_id = c.category_id
                WHERE p.active = 1
                ORDER BY p.price DESC
                OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY;
                """;
        } else if ("asc".equalsIgnoreCase(type)) {
            query = """
                SELECT p.product_id, p.name as [productName], p.description, p.price, p.stock_quantity,
                       p.category_id, c.name as categoryName, p.image
                FROM Products p
                INNER JOIN Categories c ON p.category_id = c.category_id
                WHERE p.active = 1
                ORDER BY p.price ASC
                OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY;
                """;
        }

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, (index - 1) * 3);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category cate = new Category(rs.getInt("category_id"), rs.getString("categoryName"));
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("productName"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        cate,
                        rs.getString("image")
                );
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Employees loginEmployee(String username, String password) {
        String query = """
                       SELECT [employee_id]
                             ,[name]
                             ,[email]
                             ,[password]
                             ,[phone_number]
                             ,[employment_status]
                             ,[active]
                             ,[hourly_wage_rate]
                         FROM [SWP391].[dbo].[Employees] where email=? and password =?""";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Employees(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getDouble(8)
                );
            }

        } catch (Exception e) {
        }
        return null;
    }

    public Admin loginAdmin(String username, String password) {
        String query = "select * from [Admins] where username=? and password =?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Admin(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5));
            }

        } catch (Exception e) {
        }
        return null;
    }

    public List<Product> searchByName(String name) {
        List<Product> list = new ArrayList<>();
        String query = """
                   select p.product_id, p.name, p.description, p.price, p.stock_quantity,
                          p.category_id, c.name as categoryName, p.image
                   from Products p
                   inner join Categories c on p.category_id = c.category_id
                   where p.name like ?
                   """;

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category(rs.getInt("category_id"), rs.getString("categoryName"));
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        category,
                        rs.getString("image")
                );
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateCart(Cart cart, String tableName) {
        String sql = "UPDATE carts SET status = ?, checkoutTime = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, cart.getStatus());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            pstmt.setString(2, cart.getCheckoutTime().format(formatter));
            pstmt.setInt(3, cart.getId());

            pstmt.executeUpdate();

            insertCartItems(cart);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void insertCartItems(Cart cart) {
        String sql = "INSERT INTO items (cart_id, product_id, quantity) VALUES (?, ?, ?)";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            for (Item item : cart.getItems()) {
                pstmt.setInt(1, cart.getId());
                pstmt.setInt(2, item.getProduct().getProduct_id());
                pstmt.setInt(3, item.getQuantity());

                pstmt.addBatch();
            }

            pstmt.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteDiscount(String did) {
        String query = "DELETE FROM [dbo].[Discounts] WHERE discount_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, did);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteTable(String tid) {
        String query = "DELETE FROM [dbo].[Tables] WHERE table_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, tid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateDiscountById(String code, double discountPercentage, boolean active, String discountId) {
        String query = """
                   UPDATE [dbo].[Discounts]
                      SET [code] = ?
                         ,[discount_percentage] = ? 
                         ,[active] = 1
                    WHERE [discount_id] = ?"""; // Assuming the primary key is discount_id

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, code);
            ps.setDouble(2, discountPercentage);

            ps.setString(3, discountId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Discount> getAllDiscount() {
        List<Discount> list = new ArrayList<>();
        String query = "Select * from [Discounts] "
                + "where active = 1"
                + "order by discount_percentage ";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Discount(rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Discount> getHideDiscount() {
        List<Discount> list = new ArrayList<>();
        String query = """
                       SELECT [discount_id]
                             ,[code]
                             ,[discount_percentage]
                       FROM [dbo].[Discounts]
                       WHERE [active] = 0""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Discount(rs.getInt("discount_id"),
                        rs.getString("code"),
                        rs.getDouble("discount_percentage")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void hideDiscount(int id) {
        try {
            con = new DBContext().getConnection();
            String sql = """
                         Update Discounts set active = 0
                         where discount_id = ?""";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Table> getHideTable() {
        List<Table> list = new ArrayList<>();
        String query = """
                       SELECT [table_id]
                             ,[qr_code]
                            ,[table_name]
                      FROM [dbo].[Tables]
                      WHERE [active] = 0""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Table(
                        rs.getInt("table_id"),
                        rs.getString("qr_code"),
                        rs.getString("table_name")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void hideTable(int id) {
        try {
            con = new DBContext().getConnection();
            String sql = """
                         Update Tables set active = 0
                         where Table_id = ?""";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertDiscount(String code, double discountPercentage) {
        String sql = "INSERT INTO [dbo].[Discounts] ([code], [discount_percentage] ) VALUES (?, ? )";

        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, code);
            stm.setDouble(2, discountPercentage);

            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();  // In ra lỗi để tiện debug
        }
    }

    public List<Table> getAllTable() {
        List<Table> list = new ArrayList<>();
        String query = """
                       SELECT [table_id]
                             ,[qr_code]
                         FROM [SWP391].[dbo].[Tables]""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Table(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Table> getAllTableAdminActive() {
        List<Table> list = new ArrayList<>();
        String query = "Select * from [Tables] "
                + "where active = 1"
                + "order by table_name ";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Table(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Table> getAllTableAdmin() {
        List<Table> list = new ArrayList<>();
        String query = "Select * from [Tables] "
                + "order by table_name ";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Table(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    

    public int insertCartFirstAccess(Cart cart, String tableName) {
        String sql = "INSERT INTO carts (customer_name, customer_phone, status, tableName) VALUES (?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, cart.getCustomer().getName());
            pstmt.setString(2, cart.getCustomer().getPhone_number());
            pstmt.setString(3, cart.getStatus());
            pstmt.setString(4, tableName);

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);  // Return the generated cart ID
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  // Return -1 if insertion failed
    }

    public void clearCartByTableName(String tableName) {
        String deleteItemsSQL = "DELETE FROM Items WHERE cart_id IN (SELECT id FROM Carts WHERE tableName = ?)";
        String deleteCartsSQL = "DELETE FROM Carts WHERE tableName = ?";

        PreparedStatement deleteItemsStmt = null;
        PreparedStatement deleteCartsStmt = null;

        try {
            con = new DBContext().getConnection();
            // Delete items
            deleteItemsStmt = con.prepareStatement(deleteItemsSQL);
            deleteItemsStmt.setString(1, tableName);
            deleteItemsStmt.executeUpdate();

            // Delete carts
            deleteCartsStmt = con.prepareStatement(deleteCartsSQL);
            deleteCartsStmt.setString(1, tableName);
            deleteCartsStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Cart getCartById(int cartId) {
        Cart cart = null;
        try {
            String query = "SELECT * FROM Carts WHERE id = ?";
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, cartId);
            rs = ps.executeQuery();
            if (rs.next()) {
                cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setStatus(rs.getString("status"));
                Customer customer = new Customer(rs.getString("customer_name"), rs.getString("customer_phone"));
                cart.setCustomer(customer);
                Table table = new Table(rs.getString("tableName"));
                cart.setTable(table);
                Timestamp timestamp = rs.getTimestamp("checkoutTime");
                if (timestamp != null) {
                    cart.setCheckoutTime(timestamp.toLocalDateTime());
                }
                cart.setDiscountPercent(rs.getDouble("discountPercent"));
                cart.setPromoCode(rs.getString("promoCode"));

                // Get items for this cart
                cart.setItems(getItemsByCartId(cartId));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cart;
    }

    public void removeItemFromCart(int cartId, int productId) {
        try {
            String query = "DELETE FROM Items WHERE cart_id = ? AND product_id = ?";
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void removeCart(int cartId) {
        try {
            String query = "DELETE FROM Carts WHERE id = ?";
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCartItem(int cartId, int productId, int num) {
        try {
            // Get the current quantity from the database
            String selectQuery = "SELECT quantity FROM Items WHERE cart_id = ? AND product_id = ?";
            con = new DBContext().getConnection();
            ps = con.prepareStatement(selectQuery);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int currentQuantity = rs.getInt("quantity");
                int newQuantity = currentQuantity + num; // num will be 1 or -1

                if (newQuantity > 0) {
                    // Update the quantity in the database
                    String updateQuery = "UPDATE Items SET quantity = ? WHERE cart_id = ? AND product_id = ?";
                    ps = con.prepareStatement(updateQuery);
                    ps.setInt(1, newQuantity);
                    ps.setInt(2, cartId);
                    ps.setInt(3, productId);
                    ps.executeUpdate();
                } else {
                    // If the new quantity is 0 or less, remove the item from the cart
                    removeItemFromCart(cartId, productId);
                }
            } else if (num > 0) {
                // If the item does not exist in the cart, add it with the given quantity
                String insertQuery = "INSERT INTO Items (cart_id, product_id, quantity) VALUES (?, ?, ?)";
                ps = con.prepareStatement(insertQuery);
                ps.setInt(1, cartId);
                ps.setInt(2, productId);
                ps.setInt(3, num);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCart(Cart cart) {
        try {
            String query = "UPDATE Carts SET discountPercent = ?, promoCode = ? WHERE id = ?";
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setDouble(1, cart.getDiscountPercent());
            ps.setString(2, cart.getPromoCode());
            ps.setInt(3, cart.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Cart> getCartsByTableName(String tableName) {
        List<Cart> cartList = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String query = "SELECT * FROM Carts WHERE tableName = ?";
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, tableName);
            rs = ps.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setStatus(rs.getString("status"));
                Customer customer = new Customer(rs.getString("customer_name"), rs.getString("customer_phone"));
                cart.setCustomer(customer);
                Table table = new Table(rs.getString("tableName"));
                cart.setTable(table);
                Timestamp timestamp = rs.getTimestamp("checkoutTime");
                if (timestamp != null) {
                    cart.setCheckoutTime(timestamp.toLocalDateTime());
                }
                cart.setDiscountPercent(rs.getDouble("discountPercent"));
                cart.setPromoCode(rs.getString("promoCode"));
                cartList.add(cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartList;
    }

    public Admin checkUserExistByUserNameAdmin(String username) {
        String query = "select * from [Admins] where username=?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Admin(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Admin checkUserExistByEmailAdmin(String email) {
        String query = "select * from [Admins] where email=?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Admin(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Employees checkUserExistByUserNameEmploy(String email) {
        String query = """
                       SELECT [employee_id]
                             ,[name]
                             ,[email]
                             ,[password]
                             ,[phone_number]
                             ,[employment_status]
                             ,[active]
                         FROM [SWP391].[dbo].[Employees] where email=?""";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Employees(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePasswordAdmin(String email, String password) {
        String query = """
                       UPDATE [dbo].[Admins]
                       SET [password] = ?
                       WHERE email = ?""";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, password);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updatePasswordEmploy(String email, String password) {
        String query = """
                       UPDATE [dbo].[Employees]
                       SET [password] = ?
                       WHERE email = ?""";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, password);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean checkValidAdmin(String username, String email) {
        String query = "SELECT * FROM [Admins] WHERE username = ? AND email = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void storeResetCodeAdmin(String email, String code) {
        String sql = "UPDATE Admins SET reset_code = ?, reset_code_created_at = GETDATE() WHERE email = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, code);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean checkResetCodeAdmin(String email, String code) {
        String sql = "SELECT reset_code_created_at FROM Admins WHERE email = ? AND reset_code = ?";
        try {
            Connection con = new DBContext().getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, code);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Timestamp createdAt = rs.getTimestamp("reset_code_created_at");
                if (createdAt != null) {
                    long currentTime = System.currentTimeMillis();
                    long codeTime = createdAt.getTime();
                    long diff = currentTime - codeTime;
                    if (diff <= 300000) {
                        return true;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void storeResetCodeEmploy(String email, String code) {
        String sql = "UPDATE Employees SET reset_code = ?, reset_code_created_at = GETDATE() WHERE email = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, code);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean checkResetCodeEmploy(String email, String code) {
        String sql = "SELECT reset_code_created_at FROM Employees WHERE email = ? AND reset_code = ?";
        try {
            Connection con = new DBContext().getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, code);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Timestamp createdAt = rs.getTimestamp("reset_code_created_at");
                if (createdAt != null) {
                    long currentTime = System.currentTimeMillis();
                    long codeTime = createdAt.getTime();
                    long diff = currentTime - codeTime;
                    if (diff <= 300000) {
                        return true;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getEmailByUsername(String username) {
        String email = null;
        try {
            Connection con = new DBContext().getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT email FROM Admins WHERE username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                email = rs.getString("email");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return email;
    }

    public boolean addEmployee(String email, String password) {
        try {
            con = new DBContext().getConnection();

            String sql = "INSERT INTO Employees (email, password) VALUES (?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
        }
        return false;
    }

    public void clearAdminResetCode(String email) {
        String query = "UPDATE Admins SET reset_code = NULL, reset_code_created_at = NULL WHERE email = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void clearEmployeeResetCode(String email) {
        String query = "UPDATE Employees SET reset_code = NULL, reset_code_created_at = NULL WHERE email = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Employees> getAllEmployee() {
        List<Employees> list = new ArrayList<>();
        String query = """
                       SELECT TOP (1000) [employee_id]
                             ,[name]
                             ,[email]
                             ,[password]
                             ,[phone_number]
                             ,[employment_status]
                             ,[active]
                             ,[hourly_wage_rate]
                         FROM [SWP391].[dbo].[Employees]""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Employees(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getDouble(8)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void setEmployeeActive(String email) {
        String sql = "UPDATE Employees SET active = 1 WHERE email = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addEmployee(String name, String phone_number, String employment_status, double hourly_wage_rate) {
        String query = """
                       INSERT INTO [dbo].[Employees]
                                  ([name]
                                  ,[phone_number]
                                  ,[employment_status]
                                  ,[hourly_wage_rate])
                            VALUES (?, ?, ?, ?)""";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, phone_number);
            ps.setString(3, employment_status);
            ps.setDouble(4, hourly_wage_rate);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateInfoEmployee(String name, String phone_number, String employment_status, boolean active, double hourly_wage_rate, String employee_id) {
        String query = """
                       UPDATE [dbo].[Employees]
                          SET [name] = ?
                             ,[phone_number] = ? 
                             ,[employment_status] = ? 
                             ,[active] = ?
                             ,[hourly_wage_rate] = ?
                        WHERE employee_id = ?""";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, phone_number);
            ps.setString(3, employment_status);
            ps.setBoolean(4, active); // Đặt giá trị cho trường active
            ps.setDouble(5, hourly_wage_rate);
            ps.setString(6, employee_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addProduct(String pName, String pDescription, double price, int quantity, Category category, String img) {

        try {
            con = new DBContext().getConnection();
            String sql = """
                         INSERT [dbo].[Products] 
                         ([name], [description], [price], [stock_quantity], [category_id], [image]) 
                         VALUES (?, ?, ?, ?, ?, ?)""";

            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, pName);
            stm.setString(2, pDescription);
            stm.setDouble(3, price);
            stm.setInt(4, quantity);
            stm.setInt(5, category.getCategory_id());
            stm.setString(6, img);
            stm.executeUpdate();

        } catch (Exception e) {

        }
    }

    public void addCategory(String cateName) {

        try {
            con = new DBContext().getConnection();
            String sql = "insert into Categories values (?)";

            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, cateName);
            stm.executeUpdate();

        } catch (Exception e) {

        }
    }

    public void updateProduct(String name, String description, double price, int quantity, Category category, String img, int id) {
        try {
            con = new DBContext().getConnection();
            String sql = """
                         UPDATE Products
                         SET [name] = ?, [description] = ?, price = ?,
                         stock_quantity = ?, category_id = ?, [image] = ?
                         WHERE product_id = ?""";

            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, description);
            stm.setDouble(3, price);
            stm.setInt(4, quantity);
            stm.setInt(5, category.getCategory_id());
            stm.setString(6, img);
            stm.setInt(7, id);
            stm.executeUpdate();

        } catch (Exception e) {

        }
    }

    public void hideProduct(int id) {
        try {
            con = new DBContext().getConnection();
            String sql = """
                         Update Products set active = 0
                         where product_id = ?""";

            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();

        } catch (Exception e) {

        }
    }

    public void showProduct(int id) {
        try {
            con = new DBContext().getConnection();
            String sql = """
                         Update Products set active = 1
                         where product_id = ?""";

            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();

        } catch (Exception e) {

        }
    }

    public List<Product> getHideProduct() {
        List<Product> list = new ArrayList<>();
        String query = """
                       SELECT p.product_id, p.[name] as productname, p.[description], p.price, 
                                              p.stock_quantity, p.[image], p.category_id, c.[name] as categoryname
                                              from Products P
                                              inner join Categories c on p.category_id = c.category_id
                                              where p.active = 0""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {

                Category c = new Category();

                c.setCategory_id(rs.getInt("category_id"));
                c.setName(rs.getString("categoryname"));

                list.add(new Product(rs.getInt("product_id"),
                        rs.getString("productname"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        c,
                        rs.getString("image")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Attendance> getAttendanceData() {
        List<Attendance> attendanceRecords = new ArrayList<>();
        String query = """
                       select a.attendance_id, a.attendance_status, a.working_date, 
                       w.shift_id,
                       e.name, e.employee_id, 
                       s.pattern_id, s.pattern_name, s.start_time, s.end_time 
                       from Attendance a
                       inner join WorkShifts w on a.shift_id = w.shift_id
                       inner join Employees e on w.employee_id = e.employee_id
                       inner join ShiftPatterns s on s.pattern_id = w.pattern_id""";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                int attendanceId = rs.getInt("attendance_id");
                String attendanceStatus = rs.getString("attendance_status");
                Date workingDate = rs.getDate("working_date");

                Employees employee = new Employees(rs.getInt("employee_id"), rs.getString("name"));

                ShiftPattern sp = new ShiftPattern(rs.getInt("pattern_id"), rs.getString("pattern_name"), rs.getTime("start_time"), rs.getTime("end_time"));

                WorkShift ws = new WorkShift(rs.getInt("shift_id"), employee, sp);

                Attendance attendance = new Attendance(attendanceId, ws, attendanceStatus, workingDate);
                attendanceRecords.add(attendance);
            }
        } catch (Exception e) {
        }
        return attendanceRecords;
    }

    //Chưa sửa
    public void updateAttendanceToday() {
        String query = """
                       INSERT INTO dbo.Attendance (shift_id, employee_id, working_date, shift_name)
                       SELECT 
                           ws.shift_id,
                           ws.employee_id,
                           CAST(GETDATE() AS DATE) AS working_date, 
                           sp.pattern_name
                       FROM 
                           dbo.WorkShifts ws
                       JOIN 
                           dbo.Employees e ON ws.employee_id = e.employee_id
                       JOIN 
                           dbo.ShiftPatterns sp ON ws.pattern_id = sp.pattern_id
                       WHERE 
                           e.active = 1 -- Ch\u1ec9 l\u1ea5y nh\u1eefng nh\u00e2n vi\u00ean \u0111ang l\u00e0m vi\u1ec7c""";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Cần hỏi lại
    public List<ShiftPattern> getShiftPatternName() {
        List<ShiftPattern> list = new ArrayList<>();

        String query = """
                       SELECT [pattern_id]
                             ,[pattern_name]
                         FROM [SWP391].[dbo].[ShiftPatterns]""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ShiftPattern(rs.getInt(1),
                        rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public boolean addWorkShift(int employee_id, int pattern_id) {
        String checkQuery = """
                        SELECT [active]
                        FROM [dbo].[WorkShifts]
                        WHERE [employee_id] = ? AND [pattern_id] = ?""";
        String updateQuery = """
                         UPDATE [dbo].[WorkShifts]
                         SET [active] = 1
                         WHERE [employee_id] = ? AND [pattern_id] = ? AND [active] = 0""";
        String insertQuery = """
                         INSERT INTO [dbo].[WorkShifts]
                                    ([employee_id], [pattern_id])
                                VALUES
                                    (?, ?)""";

        try {
            con = new DBContext().getConnection();

            // Check if the work shift already exists
            ps = con.prepareStatement(checkQuery);
            ps.setInt(1, employee_id);
            ps.setInt(2, pattern_id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Work shift exists, check the active status
                int active = rs.getInt("active");
                if (active == 0) {
                    // Update active status to 1
                    ps = con.prepareStatement(updateQuery);
                    ps.setInt(1, employee_id);
                    ps.setInt(2, pattern_id);
                    ps.executeUpdate();
                    return true;  // Update successful
                }
            } else {
                // Insert new work shift
                ps = con.prepareStatement(insertQuery);
                ps.setInt(1, employee_id);
                ps.setInt(2, pattern_id);
                ps.executeUpdate();
                return true;  // Insert successful
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;  // An error occurred
    }

    public List<String> getEmployeeStatus() {
        List<String> list = new ArrayList<>();

        String query = """
                       SELECT distinct [employment_status]
                         FROM [SWP391].[dbo].[Employees]""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                String status = rs.getString("employment_status");
                list.add(status);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //Không chắc
    public boolean insertAttendance() {
        String query = """
                   INSERT INTO dbo.Attendance (shift_id, attendance_status, working_date)
                       SELECT 
                           ws.shift_id,
                           N'Vắng mặt' AS attendance_status,
                           CAST(GETDATE() AS DATE) AS working_date
                       FROM 
                           dbo.WorkShifts ws
                       JOIN 
                           dbo.Employees e ON ws.employee_id = e.employee_id
                       JOIN 
                           dbo.ShiftPatterns sp ON ws.pattern_id = sp.pattern_id
                       WHERE 
                           e.active = 1
                           AND ws.active = 1
                           AND NOT EXISTS (
                               SELECT 1
                               FROM dbo.Attendance a
                               WHERE a.shift_id = ws.shift_id
                               AND a.working_date = CAST(GETDATE() AS DATE)
                           )
                       """;

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    //Xóa hết à :v
    public void deleteAttendance() {
        String query = "DELETE FROM [dbo].[Attendance]";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Salaries> getSalaries() {
        List<Salaries> salaryList = new ArrayList<>();
        String query = """
                       SELECT s.*, e.name
                       FROM Salaries s
                       INNER JOIN Employees e ON s.employee_id = e.employee_id;""";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                int salary_id = rs.getInt("salary_id");
                int employee_id = rs.getInt("employee_id");
                double totalHoursWorked = rs.getDouble("total_hours_worked");
                double totalSalary = rs.getDouble("total_salary");
                String monthYearStr = rs.getString("month_year");
                String name = rs.getString("name");

                java.sql.Date monthYear = java.sql.Date.valueOf(monthYearStr);

                Employees employees = new Employees(employee_id, name);
                Salaries salary = new Salaries(salary_id, employees, totalSalary, totalHoursWorked, monthYear);

                salaryList.add(salary);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return salaryList;
    }

    public boolean insertSalaries() {
        String query = """
                   MERGE INTO Salaries AS target
                   USING (
                       SELECT 
                           e.employee_id,
                           SUM(
                               CASE
                                   WHEN a.attendance_status = N'C\u00f3 m\u1eb7t' THEN
                                       CASE
                                           WHEN sp.start_time <= sp.end_time THEN
                                               CEILING(DATEDIFF(minute, sp.start_time, sp.end_time) / 60.0)
                                           ELSE
                                               CEILING(((DATEDIFF(minute, sp.start_time, '23:59:59') + DATEDIFF(minute, '00:00:00', sp.end_time)) / 60.0))
                                       END
                                   ELSE
                                       0
                               END
                           ) AS total_hours_worked,
                           SUM(
                               CASE
                                   WHEN a.attendance_status = N'C\u00f3 m\u1eb7t' THEN
                                       CASE
                                           WHEN sp.start_time <= sp.end_time THEN
                                               CEILING((DATEDIFF(minute, sp.start_time, sp.end_time) / 60.0)) * e.hourly_wage_rate
                                           ELSE
                                               CEILING(((DATEDIFF(minute, sp.start_time, '23:59:59') + DATEDIFF(minute, '00:00:00', sp.end_time)) / 60.0)) * e.hourly_wage_rate
                                       END
                                   ELSE
                                       0
                               END
                           ) AS total_salary,
                           DATEADD(MONTH, DATEDIFF(MONTH, 0, a.working_date), 0) AS month_year,
                           SUM(CASE WHEN a.attendance_status = N'Mu\u1ed9n' THEN 1 ELSE 0 END) AS late_count
                       FROM 
                           Attendance a
                       INNER JOIN 
                           WorkShifts ws ON a.shift_id = ws.shift_id
                       INNER JOIN 
                           ShiftPatterns sp ON ws.pattern_id = sp.pattern_id
                       INNER JOIN 
                           Employees e ON ws.employee_id = e.employee_id
                       GROUP BY
                           e.employee_id,
                           DATEADD(MONTH, DATEDIFF(MONTH, 0, a.working_date), 0),
                           e.hourly_wage_rate
                   ) AS source
                   ON target.employee_id = source.employee_id AND target.month_year = source.month_year
                   WHEN MATCHED AND (
                       target.total_hours_worked <> source.total_hours_worked OR
                       target.total_salary <> CASE 
                                                 WHEN source.late_count > 10 THEN source.total_salary * 0.8 
                                                 ELSE source.total_salary 
                                              END
                   ) THEN
                       UPDATE SET
                           target.total_hours_worked = source.total_hours_worked,
                           target.total_salary = CASE 
                                                    WHEN source.late_count > 10 THEN source.total_salary * 0.8 
                                                    ELSE source.total_salary 
                                                 END
                   WHEN NOT MATCHED THEN
                       INSERT (employee_id, total_hours_worked, total_salary, month_year)
                       VALUES (source.employee_id, source.total_hours_worked, CASE 
                                                                                 WHEN source.late_count > 10 THEN source.total_salary * 0.8 
                                                                                 ELSE source.total_salary 
                                                                              END, source.month_year);""";

        boolean success = false;
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updateToOrderFromTranHis() {
        String query = """
                       UPDATE TransactionHistory
                       SET transaction_amount = CASE
                                                   WHEN o.discount_id IS NULL THEN o.total_amount
                                                   ELSE o.total_amount - (o.total_amount * d.discount_percentage / 100)
                                                END
                       FROM TransactionHistory th
                       INNER JOIN Orders o ON th.order_id = o.order_id
                       LEFT JOIN Discounts d ON o.discount_id = d.discount_id;""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateRevenue() {
        String query = """
                       UPDATE r
                       SET r.total_revenue = 0 + th.totalAmountSum
                       FROM revenue r
                       JOIN (
                           SELECT t.transaction_date, SUM(t.transaction_amount) AS totalAmountSum
                           FROM TransactionHistory t
                           GROUP BY t.transaction_date
                       ) th ON r.date = th.transaction_date;""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateOrderFromOrderDetail() {
        String query = """
                       UPDATE o
                       SET o.total_amount = od.total_amount
                       FROM [Orders] o
                       JOIN (
                           SELECT order_id, SUM(quantity * price) AS total_amount
                           FROM OrderDetails
                           GROUP BY order_id
                       ) od ON o.order_id = od.order_id""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Integer> getTransactionsPerDay(int month) {
        List<Integer> transactions = new ArrayList<>();
        String sql = """
                     SELECT DAY(th.transaction_date) AS day, COUNT(*) AS count
                     FROM TransactionHistory th
                     WHERE MONTH(th.transaction_date) = ?
                     GROUP BY DAY(th.transaction_date)""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, month);
            ResultSet rs = ps.executeQuery();

            for (int i = 0; i < 31; i++) {
                transactions.add(0);
            }
            while (rs.next()) {
                int day = rs.getInt("day");
                int count = rs.getInt("count");
                transactions.set(day - 1, count);
            }
        } catch (Exception e) {
        }
        return transactions;
    }

    public List<Integer> getTransactionsYear() {
        List<Integer> transactions = new ArrayList<>();
        String sql = """
                     SELECT MONTH(th.transaction_date) AS month, COUNT(*) AS count
                     FROM TransactionHistory th
                     GROUP BY Month(th.transaction_date)""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            for (int i = 0; i < 12; i++) {
                transactions.add(0);
            }
            while (rs.next()) {
                int month = rs.getInt("month");
                int count = rs.getInt("count");
                transactions.set(month - 1, count);
            }
        } catch (Exception e) {
        }
        return transactions;
    }

    public List<OrderDetail> getTop5Product() {
        List<OrderDetail> list = new ArrayList<>();
        String query = """
                       SELECT TOP 5 p.product_id, p.name, SUM(od.quantity) AS quantity
                       FROM OrderDetails od
                       INNER JOIN Products p ON p.product_id = od.product_id
                       INNER JOIN Orders o ON o.order_id = od.order_id
                       INNER JOIN TransactionHistory th ON th.order_id = o.order_id
                       GROUP BY p.product_id, p.name
                       ORDER BY quantity DESC""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(rs.getInt("product_id"), rs.getString("name"));

                OrderDetail od = new OrderDetail(p, rs.getInt("quantity"));

                list.add(od);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<OrderDetail> getTop5ProductByMonth(int month) {
        List<OrderDetail> list = new ArrayList<>();
        String query = """
                       SELECT TOP 5 p.product_id, p.name, SUM(od.quantity) AS quantity
                                              FROM OrderDetails od
                                              INNER JOIN Products p ON p.product_id = od.product_id
                                              INNER JOIN Orders o ON o.order_id = od.order_id
                                              INNER JOIN TransactionHistory th ON th.order_id = o.order_id
                       \t\t\t\t\t   where month(transaction_date) = ?
                                              GROUP BY p.product_id, p.name
                                              ORDER BY quantity DESC""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, month);
            rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(rs.getInt("product_id"), rs.getString("name"));

                OrderDetail od = new OrderDetail(p, rs.getInt("quantity"));

                list.add(od);
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    public List<OrderDetail> getTop5ProductByMonthDay(int month, int day) {
        List<OrderDetail> list = new ArrayList<>();
        String query = """
                       SELECT TOP 5 p.product_id, p.name, SUM(od.quantity) AS quantity
                       FROM OrderDetails od
                       INNER JOIN Products p ON p.product_id = od.product_id
                       INNER JOIN Orders o ON o.order_id = od.order_id
                       INNER JOIN TransactionHistory th ON th.order_id = o.order_id
                       where month(transaction_date) = ? and day(transaction_date) = ?
                       GROUP BY p.product_id, p.name
                       ORDER BY quantity DESC""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, month);
            ps.setInt(2, day);
            rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(rs.getInt("product_id"), rs.getString("name"));

                OrderDetail od = new OrderDetail(p, rs.getInt("quantity"));

                list.add(od);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public int getTranTypeOnl() {
        int total = 0;
        String query = """
                       select count(*) as total
                       from TransactionHistory
                       where transaction_type = N'Chuy\u1ec3n kho\u1ea3n'""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public int getTranTypeOnlByMonth(int month) {
        int total = 0;
        String query = """
                       select count(*) as total
                       from TransactionHistory
                       where transaction_type = N'Chuy\u1ec3n kho\u1ea3n' and month(transaction_date) = ?""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, month);
            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }
    
    public int getTranTypeOnlByMonthDay(int month, int day) {
        int total = 0;
        String query = """
                       select count(*) as total
                       from TransactionHistory
                       where transaction_type = N'Chuy\u1ec3n kho\u1ea3n' 
                       and month(transaction_date) = ? 
                       and day(transaction_date) = ?""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, month);
            ps.setInt(2, day);
            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public int getTranTypeOff() {
        int total = 0;
        String query = """
                       select count(*) as total
                       from TransactionHistory
                       where transaction_type = N'Tiền mặt'""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public int getTranTypeOffByMonth(int month) {
        int total = 0;
        String query = """
                       select count(*) as total
                       from TransactionHistory
                       where transaction_type = N'Tiền mặt' 
                       and month(transaction_date) = ?""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, month);
            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }
    
    public int getTranTypeOffByMonthDay(int month, int day) {
        int total = 0;
        String query = """
                       select count(*) as total
                       from TransactionHistory
                       where transaction_type = N'Tiền mặt' 
                       and month(transaction_date) = ?
                       and day(transaction_date) = ?""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, month);
            ps.setInt(2, day);
            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public int getTotalRevenue() {
        int total = 0;
        String query = "select SUM(total_revenue) as total from Revenue";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public int getTotalRevenueByMonth(int month) {
        int total = 0;
        String query = """
                       select SUM(total_revenue) as total from Revenue
                       where month(date) = ?""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, month);
            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }
    
    public int getTotalRevenueByMonthDay(int month, int day) {
        int total = 0;
        String query = """
                       select SUM(total_revenue) as total from Revenue
                       where month(date) = ? and day(date) = ?""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, month);
            ps.setInt(2, day);
            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public List<Customer> getAllCustomer() {
        List<Customer> list = new ArrayList<>();
        String query = "select * from Customers";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Customer(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<WorkShift> getPatternNameOfEmployee() {
        List<WorkShift> list = new ArrayList<>();
        String query = """
                       select e.employee_id, w.shift_id, s.pattern_id, s.pattern_name  
                       from Employees e
                       inner join WorkShifts w on e.employee_id = w.employee_id
                       inner join ShiftPatterns s on s.pattern_id = w.pattern_id""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                ShiftPattern sp = new ShiftPattern(rs.getInt("pattern_id"), rs.getString("pattern_name"));
                Employees e = new Employees(rs.getInt("employee_id"));

                WorkShift ws = new WorkShift(rs.getInt("shift_id"), e, sp);

                list.add(ws);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalTranHis() {
        int total = 0;
        String query = "select count(*) as total from TransactionHistory";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public int getTotalTranHisByMonth(int month) {
        int total = 0;
        String query = """
                       select count(*) as total from TransactionHistory
                       where month(transaction_date) = ?""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, month);
            rs = ps.executeQuery();
            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }
    
    public int getTotalTranHisByMonthDay(int month, int day) {
        int total = 0;
        String query = """
                       select count(*) as total from TransactionHistory
                       where month(transaction_date) = ? and day(transaction_date) = ?""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, month);
            ps.setInt(2, day);
            rs = ps.executeQuery();
            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public int getTotalOrderByCustomerId(int id) {
        int total = 0;
        String query = """
                       select count(th.transaction_id) as total
                       from TransactionHistory th
                       inner join Orders o on th.order_id = o.order_id
                       inner join Customers c on c.customer_id = o.customer_id
                       WHERE c.phone_number = (SELECT phone_number 
                                               FROM Customers 
                                               WHERE customer_id = ?)""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public int getTotalAmountByCustomerId(int id) {
        int total = 0;
        String query = """
                       select sum(th.transaction_amount) as total
                       from TransactionHistory th
                       inner join Orders o on th.order_id = o.order_id
                       inner join Customers c on c.customer_id = o.customer_id
                       WHERE c.phone_number = (SELECT phone_number 
                                               FROM Customers 
                                               WHERE customer_id = ?)""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public Customer getCustomerById(int id) {
        Customer c = new Customer();
        String query = """
                       select c.customer_id, c.name, c.phone_number
                       from Customers c
                       where c.customer_id = ?""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                c = new Customer(rs.getInt("customer_id"), rs.getString("name"), rs.getString("phone_number"));
            }
        } catch (Exception e) {
        }
        return c;
    }

    public List<TransactionHistory> getTranHisByCId(int id) {
        List<TransactionHistory> list = new ArrayList<>();
        String query = """
                       SELECT th.transaction_id, 
                              th.transaction_date, 
                              SUM(th.transaction_amount) AS total
                       FROM TransactionHistory th
                       INNER JOIN Orders o ON o.order_id = th.order_id
                       INNER JOIN Customers c ON c.customer_id = o.customer_id
                       WHERE c.phone_number = (SELECT phone_number 
                                               FROM Customers 
                                               WHERE customer_id = ?)
                       GROUP BY th.transaction_date, th.transaction_id;""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Revenue r = new Revenue(rs.getDate("transaction_date"));
                TransactionHistory th = new TransactionHistory(rs.getInt("transaction_id"), rs.getDouble("total"), r);
                list.add(th);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public TransactionHistory getDetailTranHis(int id) {
        TransactionHistory th = null;
        String query = """
                       select transaction_id, transaction_date, transaction_amount, transaction_type,
                       o.total_amount, o.order_id
                       from TransactionHistory th
                       inner join Orders o on o.order_id = th.order_id
                       inner join OrderDetails od on o.order_id = od.order_id
                       where transaction_id = ?
                       group by transaction_id, transaction_date, transaction_amount, transaction_type, o.total_amount, o.order_id""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Revenue r = new Revenue(rs.getDate("transaction_date"));
                Order o = new Order(rs.getInt("order_id"), rs.getInt("total_amount"));
                th = new TransactionHistory(rs.getInt("transaction_id"), o, rs.getDouble("transaction_amount"), rs.getString("transaction_type"), r);
            }
        } catch (Exception e) {
        }
        return th;
    }

    public Discount getDiscountByTranHisId(int id) {
        Discount d = null;
        String query = """
                       select d.discount_id, discount_percentage
                       from TransactionHistory th
                       inner join Orders o on o.order_id = th.order_id
                       inner join Discounts d on d.discount_id = o.discount_id
                       where transaction_id = ?""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                d = new Discount(rs.getInt("discount_id"), rs.getInt("discount_percentage"));
            }
        } catch (Exception e) {
        }
        return d;
    }

    public List<OrderDetail> getOrderDetailByTranHisId(int id) {
        List<OrderDetail> list = new ArrayList<>();
        String query = """
                       select od.product_id, o.order_id, od.quantity, p.name, od.price, p.image
                       from TransactionHistory th
                       inner join Orders o on th.order_id = o.order_id
                       inner join OrderDetails od on od.order_id = o.order_id
                       inner join Products p on p.product_id = od.product_id
                       where transaction_id = ?
                       group by o.order_id, od.product_id, od.quantity, p.name, od.price, p.image""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("order_id"));
                Product p = new Product(rs.getInt("product_id"), rs.getString("name"), rs.getString("image"));
                OrderDetail od = new OrderDetail(id, o, p, rs.getInt("quantity"), rs.getInt("price"));
                list.add(od);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<TransactionHistory> getLoyaltyCustomer() {
        List<TransactionHistory> list = new ArrayList<>();
        String query = """
                       select top 10 c.phone_number, sum(th.transaction_amount) as total
                       from TransactionHistory th
                       inner join Orders o on o.order_id = th.order_id
                       inner join Customers c on c.customer_id = o.customer_id
                       group by c.phone_number
                       order by total desc""";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Customer c = new Customer(rs.getString("phone_number"));
                Order o = new Order(c);
                TransactionHistory th = new TransactionHistory(o, rs.getDouble("total"));
                list.add(th);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void updateAttendanceByAttendanceID(String attendance_status, String attendance_id) {
        String query = "UPDATE [dbo].[Attendance]\n"
                + "   SET [attendance_status] = ?\n"
                + " WHERE attendance_id =?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, attendance_status);
            ps.setString(2, attendance_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateStockProduct(int cartId) {
        String updateProductQuantitySQL = "UPDATE [dbo].[Products] SET [stock_quantity] = [stock_quantity] - ? WHERE [product_id] = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(updateProductQuantitySQL);
            List<Item> listItem = getItemsByCartId(cartId);
            for (Item item : listItem) {
                int productId = item.getProduct().getProduct_id();
                int quantity = item.getQuantity();

                // Update product quantity
                ps.setInt(1, quantity);
                ps.setInt(2, productId);
                ps.addBatch();
            }

            ps.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Map<String, List<Cart>> getAllTableCarts() {
        Map<String, List<Cart>> tableCarts = new HashMap<>();
        String sql = "SELECT * FROM Carts";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                String tableName = rs.getString("tableName");

                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setStatus(rs.getString("status"));

                Customer customer = new Customer();
                customer.setName(rs.getString("customer_name"));
                customer.setPhone_number(rs.getString("customer_phone"));
                cart.setCustomer(customer);

                Table table = new Table();
                table.setTable_name(tableName);
                cart.setTable(table);

                Timestamp timestamp = rs.getTimestamp("checkoutTime");
                if (timestamp != null) {
                    cart.setCheckoutTime(timestamp.toLocalDateTime());
                }
                cart.setDiscountPercent(rs.getDouble("discountPercent"));
                cart.setPromoCode(rs.getString("promoCode"));
                cart.setItems(getItemsByCartId(cart.getId()));

                if (!tableCarts.containsKey(tableName)) {
                    tableCarts.put(tableName, new ArrayList<>());
                }
                tableCarts.get(tableName).add(cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tableCarts;
    }

    private List<Item> getItemsByCartId(int cartId) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM Items WHERE cart_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cartId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Item item = new Item();
                    item.setQuantity(rs.getInt("quantity"));
                    item.setProduct(new DAO().getProductByID(rs.getInt("product_id"))); // Assuming ProductDAO has a getProductById method
                    item.setServed(rs.getBoolean("served"));
                    items.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    public boolean updateCartStatus(int cartId, String newStatus) {
        String sql = "UPDATE Carts SET status = ? WHERE id = ?";
        try (Connection connection = new DBContext().getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, newStatus);
            statement.setInt(2, cartId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProfile(String name, String phone_number, int employee_id) {
        String sql = "UPDATE [dbo].[Employees]\n"
                + "   SET [name] = ?\n"
                + "      ,[phone_number] = ?\n"
                + " WHERE employee_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phone_number);
            ps.setInt(3, employee_id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<ShiftPattern> getShiftPatternByEmployeeId(int employee_id) {
        List<ShiftPattern> list = new ArrayList<>();
        String sql = "select sp.pattern_id, sp.pattern_name, sp.start_time, sp.end_time from Employees e join WorkShifts w on e.employee_id = w.employee_id join ShiftPatterns sp on w.pattern_id = sp.pattern_id where e.employee_id = ? and w.active=1";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, employee_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ShiftPattern(rs.getInt(1), rs.getString(2), rs.getTime(3), rs.getTime(4)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getAllHistoryOrder(int employee_id) {
        List<Order> list = new ArrayList<>();
        String sql = """
                     SELECT
                         o.order_id,
                         c.name,
                         c.phone_number,
                         o.total_amount,
                         d.code,
                         d.discount_percentage,
                         th.transaction_amount,
                         th.transaction_date,
                         th.transaction_type
                     FROM
                         dbo.Orders o
                         INNER JOIN dbo.TransactionHistory th ON o.order_id = th.order_id
                         INNER JOIN dbo.Employees e ON th.employee_id = e.employee_id
                         INNER JOIN dbo.Customers c ON o.customer_id = c.customer_id
                         LEFT JOIN dbo.Discounts d ON o.discount_id = d.discount_id
                     WHERE
                         e.employee_id = ?
                         AND CONVERT(date, th.transaction_date) = CONVERT(date, GETDATE())
                     ORDER BY
                         o.order_id;""";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, employee_id);

            rs = ps.executeQuery();
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                String customerName = rs.getString("name");
                String customerPhoneNumber = rs.getString("phone_number");
                double totalAmount = rs.getDouble("total_amount");
                String discountCode = rs.getString("code");
                double discountPercentage = rs.getDouble("discount_percentage");
                double transactionAmount = rs.getDouble("transaction_amount");
                Date transactionDate = rs.getDate("transaction_date");
                String transactionType = rs.getString("transaction_type");

                Customer customer = new Customer(customerName, customerPhoneNumber);
                Discount discount = new Discount(discountCode, discountPercentage);
                TransactionHistory transaction = new TransactionHistory(transactionAmount, transactionDate, transactionType);

                Order order = new Order(orderId, customer, totalAmount, discount, transaction);
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductByCID(String cateID, int index, String type) {
        List<Product> list = new ArrayList<>();
        String orderByClause = "ORDER BY p.product_id"; 

        if ("desc".equalsIgnoreCase(type)) {
            orderByClause = "ORDER BY p.price DESC";
        } else if ("asc".equalsIgnoreCase(type)) {
            orderByClause = "ORDER BY p.price ASC"; 
        }

        String query = String.format("""
       SELECT p.product_id, p.name AS productName, p.description, p.price, p.stock_quantity,
              p.category_id, c.name AS categoryName, p.image
       FROM Products p
       INNER JOIN Categories c ON p.category_id = c.category_id
       WHERE p.category_id = ? AND p.active = 1
       %s
       OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY
       """, orderByClause);

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, cateID);
            ps.setInt(2, (index - 1) * 3); 
            rs = ps.executeQuery();
            while (rs.next()) {
                Category cate = new Category(rs.getInt("category_id"), rs.getString("categoryName"));
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("productName"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        cate,
                        rs.getString("image")
                );
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        DAO dao = new DAO();
        System.out.println(dao.getProductByCID("1",1,"desc"));
    }
}
