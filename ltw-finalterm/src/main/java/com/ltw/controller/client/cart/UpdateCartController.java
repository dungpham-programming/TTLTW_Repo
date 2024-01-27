package com.ltw.controller.client.cart;

import com.ltw.bean.Cart;
import com.ltw.bean.CustomizeBean;
import com.ltw.bean.Item;
import com.ltw.dao.CustomizeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/cart-updating"})
public class UpdateCartController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        List<Item> items = cart.getItems();

        if (cart != null && items != null) {
            if (!items.isEmpty()) {
                for (int i = 0; i < cart.getTotalItem(); i++) {
                    int quantity = Integer.parseInt(req.getParameter("quantity-" + (i + 1)));
                    int productId = items.get(i).getProduct().getId();
                    if (quantity <= 0) {
                        quantity = 1;
                    }
                    // Đẫ kiểm tra sự tồn tại trong Cart, nếu tồn tại item sẽ update
                    cart.updateItem(productId, quantity);
                }
            }
        }
        req.setAttribute("customizeInfo", customizeInfo);
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }
}
