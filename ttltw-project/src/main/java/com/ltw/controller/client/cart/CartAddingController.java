package com.ltw.controller.client.cart;

import com.ltw.bean.Cart;
import com.ltw.bean.Item;
import com.ltw.bean.ProductBean;
import com.ltw.dao.ProductDAO;
import com.ltw.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/cart-adding")
public class CartAddingController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Đăng nhập mới cho phép thêm vào cart (Đã có trong filter)
        String productId = req.getParameter("productId");
        // 3 requestBy: Từ shop, từ product-detail và từ search
        // Cart đã được thêm vào ngay khi thực hiện filter
        ProductBean product = productDAO.findProductById(Integer.parseInt(productId));
        Cart cart = (Cart) SessionUtil.getInstance().getValue(req, "cart");

        Item item = new Item();
        item.setProduct(product);

        cart.addItem(item);
        SessionUtil.getInstance().putValue(req, "cart", cart);

        resp.sendRedirect(req.getContextPath() + "/shop?success=s");
    }
}
