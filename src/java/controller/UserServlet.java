
package controller;

import com.model.User;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            UserDAO dao = new UserDAO();

            if ("register".equals(action)) {
                User user = new User();
                user.setUsername(request.getParameter("username"));
                user.setEmail(request.getParameter("email"));
                user.setPassword(request.getParameter("password"));
                user.setFullName(request.getParameter("fullName"));
                user.setPhone(request.getParameter("phone"));

                boolean success = dao.registerUser(user);
                if (success) {
                    response.sendRedirect("User/login.jsp?msg=registered");
                } else {
                    response.sendRedirect("User/register.jsp?error=1");
                }

            } else if ("login".equals(action)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                User user = dao.login(username, password);
                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("role", user.getRole());

                    if ("Admin".equalsIgnoreCase(user.getRole())) {
                        response.sendRedirect(request.getContextPath() + "/Admin/home.jsp");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/Booking/home.jsp");
                    }

                } else {
                    response.sendRedirect("User/login.jsp?error=1");
                }

            } else if ("updateProfile".equals(action)) {
                HttpSession session = request.getSession();
                User currentUser = (User) session.getAttribute("user");

                if (currentUser == null) {
                    response.sendRedirect("User/login.jsp");
                    return;
                }

                // ✅ Now read userID from form safely
                int userID = Integer.parseInt(request.getParameter("userid"));

                String username = request.getParameter("username");
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");

                // ✅ Update fields
                currentUser.setUserID(userID);
                currentUser.setUsername(username);
                currentUser.setFullName(fullName);
                currentUser.setEmail(email);
                currentUser.setPhone(phone);

                boolean updateSuccess = dao.updateUser(currentUser);

                if (updateSuccess) {
                    session.setAttribute("user", currentUser);
                    String role = (String) session.getAttribute("role");

                    if ("Admin".equalsIgnoreCase(role)) {
                        response.sendRedirect("User/profile.jsp?msg=updated");
                    } else {
                        response.sendRedirect("User/profile.jsp?msg=updated");
                    }
                } else {
                    response.sendRedirect("User/editProfile.jsp?error=1");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("User/login.jsp?error=systemError");
        }
    }
}
