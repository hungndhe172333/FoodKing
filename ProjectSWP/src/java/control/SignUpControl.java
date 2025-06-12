package control;

import dal.DAO;
import java.io.IOException;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.SendMail;

@WebServlet(name = "SignUpControl", urlPatterns = {"/signup"})
public class SignUpControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");

        if (!isValidEmail(email)) {
            request.setAttribute("mess", "Sai định dạng mail");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
            return;
        }

        DAO dao = new DAO();
        if (dao.checkUserExistByUserNameEmploy(email) != null) {
            request.setAttribute("mess", "Email đã tồn tại");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
            return;
        } else {
            request.setAttribute("mess", "Quản lý sẽ cung cấp cho bạn mật khẩu dùng để đăng nhập !");
            String adminEmail = "minhphuc2308031@gmail.com";
            String subject = "New Account Activation Request";
            String activationLink = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/activate?email=" + email;
            String messageContent = "A new account has been registered with the email: " + email + ". Please activate the account by clicking the following link: " + activationLink;
            SendMail mail = new SendMail();
            mail.send(adminEmail, subject, messageContent);

            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
        }

    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
        
//        String emailRegex = "^[a-zA-Z0-9._%+-]+@gmail\\.com$";
//        Pattern pattern = Pattern.compile(emailRegex);
//        Matcher matcher = pattern.matcher(email);
//        return matcher.matches();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
