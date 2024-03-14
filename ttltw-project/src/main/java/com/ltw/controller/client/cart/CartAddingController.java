package com.ltw.controller.client.cart;

import com.ltw.bean.Cart;
import com.ltw.bean.Item;
import com.ltw.bean.ProductBean;
import com.ltw.bean.ProductImageBean;
import com.ltw.dao.ProductDAO;
import com.ltw.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/cart-adding")
public class CartAddingController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    // Todo: Chuyển đổi hàm findImage vào ProductImageDAO.
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Đăng nhập mới cho phép thêm vào cart (Đã có trong filter)
        String productId = req.getParameter("productId");
        // 3 requestBy: Từ shop, từ product-detail và từ search
        // Cart đã được thêm vào ngay khi thực hiện filter
        ProductBean product = productDAO.findProductById(Integer.parseInt(productId));
        List<ProductImageBean> thumbnailProduct = productDAO.findImagesByProductId(Integer.parseInt(productId));
        product.setImages(thumbnailProduct);
        Cart cart = (Cart) SessionUtil.getInstance().getValue(req, "cart");

        Item item = new Item();
        item.setProduct(product);

        cart.addItem(item);
        SessionUtil.getInstance().putValue(req, "cart", cart);

        resp.sendRedirect(req.getContextPath() + "/shop?success=s");
    }
}
