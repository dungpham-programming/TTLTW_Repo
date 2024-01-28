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

@WebServlet(value = {"/cart-deleting"})
public class CartDeletingController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        int productId = Integer.parseInt(req.getParameter("productId"));
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        List<Item> items = cart.getItems();

        if (cart != null && items != null) {
            if (!items.isEmpty()) {
                cart.deleteItem(productId);
            }
        }
        req.setAttribute("customizeInfo", customizeInfo);
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }
}
