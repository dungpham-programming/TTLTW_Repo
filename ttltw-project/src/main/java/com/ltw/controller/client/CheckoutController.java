package com.ltw.controller.client;

import com.ltw.bean.*;
import com.ltw.dao.*;
import com.ltw.dto.FullOrderDTO;
import com.ltw.dto.LogAddressDTO;
import com.ltw.service.LogService;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;

@WebServlet(value = {"/checkout"})
public class CheckoutController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();
    private final UserDAO userDAO = new UserDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private LogService<UserBean> userLogService = new LogService<>();
    private LogService<OrderBean> orderLogService = new LogService<>();
    private LogService<List<OrderDetailBean>> orderDetailLogService = new LogService<>();
    private ResourceBundle logBundle = ResourceBundle.getBundle("log-content");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        // Kiểm tra só lượng trước khi cho phép checkout
        Cart cart = (Cart) SessionUtil.getInstance().getValue(req, "cart");
        List<Item> items = cart.getItems();

        for (Item item : items) {
            if (item.getQuantity() > item.getProduct().getQuantity()) {
                resp.sendRedirect(req.getContextPath() + "/cart-management?error=e&productId=" + item.getProduct().getId() + "&quantity=" + item.getProduct().getQuantity());
                return;
            }
        }
        req.setAttribute("customizeInfo", customizeInfo);
        req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String addressLine = req.getParameter("addressLine");
        String addressWard = req.getParameter("addressWard");
        String addressDistrict = req.getParameter("addressDistrict");
        String addressProvince = req.getParameter("addressProvince");
        String paymentMethod = req.getParameter("paymentMethod");

        String[] inputsForm = new String[]{firstName, lastName, addressLine, addressWard, addressDistrict, addressProvince};
        ArrayList<String> errors = new ArrayList<>();

        UserBean modifyUser = (UserBean) SessionUtil.getInstance().getValue(req, "user");

        boolean isValid = true;

        for (String string : inputsForm) {
            if (BlankInputUtil.isBlank(string)) {
                errors.add("e");
                if (isValid) {
                    isValid = false;
                }
            } else {
                errors.add(null);
            }
        }
        req.setAttribute("errors", errors);

        UserBean user = (UserBean) SessionUtil.getInstance().getValue(req, "user");
        Cart cart = (Cart) SessionUtil.getInstance().getValue(req, "cart");
        if (isValid) {
            // Lưu thông tin của người dùng đã nhập
            UserBean userBean = new UserBean();
            userBean.setId(user.getId());
            userBean.setFirstName(firstName.trim());
            userBean.setLastName(lastName.trim());
            userBean.setAddressLine(addressLine.trim());
            userBean.setAddressWard(addressWard.trim());
            userBean.setAddressDistrict(addressDistrict.trim());
            userBean.setAddressProvince(addressProvince.trim());

            UserBean prevUser = userDAO.findUserById(user.getId());
            int userAffected = userDAO.updateAccount(userBean);

            if (userAffected < 0) {
                LogAddressDTO addressObj = new LogAddressDTO("user-update-in-checkout", modifyUser.getId(), logBundle.getString("user-update-in-checkout-fail"));
                userLogService.createLog(req.getRemoteAddr(), "", "ALERT", addressObj, prevUser, prevUser);
            } else if (userAffected > 0) {
                UserBean nowUser = userDAO.findUserById(user.getId());
                LogAddressDTO addressObj = new LogAddressDTO("user-update-in-checkout", modifyUser.getId(), logBundle.getString("user-update-in-checkout-success"));
                userLogService.createLog(req.getRemoteAddr(), "", "ALERT", addressObj, prevUser, nowUser);
            }

            // Lưu thông tin đơn hàng
            OrderBean orderBean = new OrderBean();
            orderBean.setUserId(user.getId());
            orderBean.setTotal(cart.getDiscountPriceTotal());
            if (paymentMethod.equals("paymentOnDelivery")) {
                orderBean.setPaymentMethod("Thanh toán khi nhận hàng");
            } else {
                orderBean.setPaymentMethod("Thanh toán chuyển khoản");
            }
            orderBean.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            orderBean.setShipToDate(calcShipToDate());
            orderBean.setCreatedBy(user.getEmail());
            orderBean.setModifiedDate(new Timestamp(System.currentTimeMillis()));
            orderBean.setModifiedBy(user.getEmail());

            int orderId = orderDAO.createOrder(orderBean);
            if (orderId <= 0) {
                req.setAttribute("insertError", "ie");
                CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
                req.setAttribute("customizeInfo", customizeInfo);
                req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
            } else {
                List<OrderDetailBean> orderDetails = new ArrayList<>();

                for (Item item : cart.getItems()) {
                    OrderDetailBean orderDetailBean = new OrderDetailBean();
                    orderDetailBean.setOrderId(orderId);
                    orderDetailBean.setProductId(item.getProduct().getId());
                    orderDetailBean.setQuantity(item.getQuantity());

                    orderDetails.add(orderDetailBean);
                    orderDetailDAO.createOrderDetail(orderDetailBean);

                    int quantityProductAfterOrder = productDAO.getTotalItems() - item.getQuantity();
                    // Set lại số lượng product
                    productDAO.updateQuantity(item.getProduct().getId(), quantityProductAfterOrder);
                }
                // Ghi log thành công
                LogAddressDTO addressObj = new LogAddressDTO("order-in-checkout", modifyUser.getId(), logBundle.getString("order-in-checkout-success"));
                FullOrderDTO fullOrder = new FullOrderDTO(orderDAO.findOrderById(orderId), orderDetails);
                orderLogService.createLog(req.getRemoteAddr(), "", "ALERT", addressObj, null, fullOrder);

                resp.sendRedirect(req.getContextPath() + "/thankyou");
            }
        } else {
            // Ghi log thất bại
            LogAddressDTO addressObj = new LogAddressDTO("order-in-checkout", modifyUser.getId(), logBundle.getString("order-in-checkout-fail"));
            orderLogService.createLog(req.getRemoteAddr(), "", "ALERT", addressObj, null, null);

            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
        }
    }

    private Timestamp calcShipToDate() {
        Date currentDate = new Date();

        // Tạo một đối tượng Calendar và thiết lập thời gian hiện tại
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(currentDate);

        // Thêm 7 ngày
        calendar.add(Calendar.DAY_OF_MONTH, 7);

        // Lấy thời gian sau khi thêm 7 ngày
        Date sevenDaysLater = calendar.getTime();
        return new Timestamp(sevenDaysLater.getTime());
    }
}
