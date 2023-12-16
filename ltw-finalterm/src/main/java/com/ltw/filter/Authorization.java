package com.ltw.filter;

import com.ltw.bean.UserBean;
import com.ltw.util.SessionUtil;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// TODO: Nên làm tất cả Servlet đều forward để kiểm tra trường hợp endWiths(".jsp")
// TODO: Filter cho cả việc thêm vào giỏ hàng và mua sản phẩm
public class Authorization implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String uri = request.getRequestURI();
        // Filter các url bắt đầu bằng "/admin"
        if (uri.startsWith("/admin")) {
            UserBean user = (UserBean) SessionUtil.getInstance().getValue(request, "user");
            if (user != null) {
                if (user.getRoleId() == 1 || user.getRoleId() == 2) {
                    filterChain.doFilter(servletRequest, servletResponse);
                }
                else {
                    
                }
            }
        }
    }

    @Override
    public void destroy() {
    }
}
