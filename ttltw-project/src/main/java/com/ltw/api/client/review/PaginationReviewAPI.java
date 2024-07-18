package com.ltw.api.client.review;

import com.google.gson.Gson;
import com.ltw.bean.ReviewBean;
import com.ltw.dao.ReviewDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/api/client/pagination-review"})
public class PaginationReviewAPI extends HttpServlet {
    private final ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int currentPage = Integer.parseInt(req.getParameter("currentPage"));
        int rating = Integer.parseInt(req.getParameter("rating"));
        int productId = Integer.parseInt(req.getParameter("productId"));

        List<ReviewBean> reviews = reviewDAO.findReviewPaginationByProductId(productId, currentPage, rating);
        Gson gson = new Gson();
        String json = gson.toJson(reviews);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }
}
