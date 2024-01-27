package com.ltw.filter;

import com.ltw.bean.UserBean;
import com.ltw.util.SessionUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = {"/cart-management", "/cart-adding", "/cart-updating", "/checkout"})
public class CartAndPaymentFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String uri = request.getRequestURI();
        // Filter các url bắt đầu bằng "/cart" hoặc có chứa "cart"
        if (uri.startsWith("/cart") || uri.contains("cart")) {
            UserBean user = (UserBean) SessionUtil.getInstance().getValue(request, "user");
            if (user == null) {
                // Nếu chưa tồn tại Session, điều hướng sang trang login
                response.sendRedirect(request.getContextPath() + "/signin?message=must_login");
                return;
            }
        }

        if (uri.startsWith("/checkout") || uri.contains("checkout")) {
            UserBean user = (UserBean) SessionUtil.getInstance().getValue(request, "user");
            if (user == null) {
                // Nếu chưa tồn tại Session, điều hướng sang trang login
                response.sendRedirect(request.getContextPath() + "/signin?message=must_login");
                return;
            }
        }
        filterChain.doFilter(request, response);
    }
}
