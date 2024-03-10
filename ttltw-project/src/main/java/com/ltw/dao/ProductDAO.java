package com.ltw.dao;

import com.ltw.bean.ProductImageBean;

import com.ltw.bean.ProductBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class ProductDAO {
    public List<ProductImageBean> findImagesByProductId(int productId) {
        List<ProductImageBean> productImageBeans = new ArrayList<>();
        String query = "SELECT id, link FROM images WHERE productId = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(query);
            SetParameterUtil.setParameter(preparedStatement, productId);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ProductImageBean productImageBean = new ProductImageBean();
                productImageBean.setId(resultSet.getInt("id"));
                productImageBean.setLink(resultSet.getString("link"));
                productImageBeans.add(productImageBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }

        return productImageBeans;
    }

    public List<ProductBean> findAllProducts() {
        String sql = "SELECT id, name, description, categoryTypeId, originalPrice, discountPrice, " +
                "discountPercent, quantity, size, otherSpec, keyword, status, " +
                "createdDate, createdBy, modifiedDate, modifiedBy " +
                "FROM products";

        List<ProductBean> productList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ProductBean productBean = new ProductBean();
                productBean.setId(resultSet.getInt("id"));
                productBean.setName(resultSet.getString("name"));
                productBean.setDescription(resultSet.getString("description"));
                productBean.setCategoryTypeId(resultSet.getInt("categoryTypeId"));
                productBean.setOriginalPrice(resultSet.getDouble("originalPrice"));
                productBean.setDiscountPrice(resultSet.getDouble("discountPrice"));
                productBean.setDiscountPercent(resultSet.getDouble("discountPercent"));
                productBean.setQuantity(resultSet.getInt("quantity"));
                productBean.setSize(resultSet.getString("size"));
                productBean.setOtherSpec(resultSet.getString("otherSpec"));
                productBean.setKeyword(resultSet.getString("keyword"));
                productBean.setStatus(resultSet.getInt("status"));
                productBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
                productBean.setCreatedBy(resultSet.getString("createdBy"));
                productBean.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                productBean.setModifiedBy(resultSet.getString("modifiedBy"));

                productList.add(productBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return productList;
    }

    public ProductBean findProductById(int id) {
        ProductBean product = null;
        String sql = "SELECT id, name, description, categoryTypeId, originalPrice, discountPrice, " +
                "discountPercent, quantity, size, otherSpec, status, keyword, " +
                "createdDate, createdBy, modifiedDate, modifiedBy " +
                "FROM products " +
                "WHERE id = ? AND status <> 0";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, id);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                product = new ProductBean();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setCategoryTypeId(resultSet.getInt("categoryTypeId"));
                product.setOriginalPrice(resultSet.getDouble("originalPrice"));
                product.setDiscountPrice(resultSet.getDouble("discountPrice"));
                product.setDiscountPercent(resultSet.getDouble("discountPercent"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setSize(resultSet.getString("size"));
                product.setOtherSpec(resultSet.getString("otherSpec"));
                product.setStatus(resultSet.getInt("status"));
                product.setKeyword(resultSet.getString("keyword"));
                product.setCreatedDate(resultSet.getTimestamp("createdDate"));
                product.setCreatedBy(resultSet.getString("createdBy"));
                product.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                product.setModifiedBy(resultSet.getString("modifiedBy"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return product;
    }

    public void updateProduct(ProductBean productBean) {
        String sql = "UPDATE products " +
                "SET name = ?, description = ?, categoryTypeId = ?, originalPrice = ?, discountPrice = ?, " +
                "discountPercent = ?, quantity = ?, size = ?, otherSpec = ?, status = ?, keyword = ? " +
                "WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, productBean.getName(), productBean.getDescription(), productBean.getCategoryTypeId(),
                    productBean.getOriginalPrice(), productBean.getDiscountPrice(), productBean.getDiscountPercent(), productBean.getQuantity(),
                    productBean.getSize(), productBean.getOtherSpec(), productBean.getStatus(), productBean.getKeyword(), productBean.getId());
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }

    public void createProduct(ProductBean productBean) {
        String sql = "INSERT INTO products (name, description, categoryTypeId, originalPrice, discountPrice, " +
                "discountPercent, quantity, size, otherSpec, status, keyword) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, productBean.getName(), productBean.getDescription(), productBean.getCategoryTypeId(),
                    productBean.getOriginalPrice(), productBean.getDiscountPrice(), productBean.getDiscountPercent(), productBean.getQuantity(),
                    productBean.getSize(), productBean.getOtherSpec(), productBean.getStatus(), productBean.getKeyword());
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }

    public int deleteProduct(int id) {
        int affectRows;
        String sql = "DELETE FROM products WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, id);
            affectRows = preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
                return -1;
            } catch (SQLException ex) {
                ex.printStackTrace();
                return -1;
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
        return affectRows;
    }

    public List<ProductBean> findThreeProductByCategoryId(int categoryId) {
        List<ProductBean> products = new ArrayList<>();
        String sql = "SELECT products.id, products.name, products.categoryTypeId, products.originalPrice, products.discountPrice, products.discountPercent " +
                "FROM products INNER JOIN category_types ON products.categoryTypeId = category_types.id " +
                "INNER JOIN categories ON category_types.categoryId = categories.id " +
                "WHERE categories.id = ? AND products.status = 1 " +
                "ORDER BY products.modifiedDate DESC "+
                "LIMIT 3";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, categoryId);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ProductBean productBean = new ProductBean();
                productBean.setId(resultSet.getInt("id"));
                productBean.setName(resultSet.getString("name"));
                productBean.setCategoryTypeId(resultSet.getInt("categoryTypeId"));
                productBean.setOriginalPrice(resultSet.getDouble("originalPrice"));
                productBean.setDiscountPrice(resultSet.getDouble("discountPrice"));
                productBean.setDiscountPercent(resultSet.getDouble("discountPercent"));

                products.add(productBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return products;
    }

    public List<ProductBean> findFourProductByTypeId(int categoryTypeId) {
        List<ProductBean> products = new ArrayList<>();
        String sql = "SELECT id, name, categoryTypeId, originalPrice, discountPrice, discountPercent " +
                "FROM products WHERE categoryTypeId = ? AND status = 1 " +
                "ORDER BY modifiedDate DESC "+
                "LIMIT 4";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, categoryTypeId);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ProductBean productBean = new ProductBean();
                productBean.setId(resultSet.getInt("id"));
                productBean.setName(resultSet.getString("name"));
                productBean.setCategoryTypeId(resultSet.getInt("categoryTypeId"));
                productBean.setOriginalPrice(resultSet.getDouble("originalPrice"));
                productBean.setDiscountPrice(resultSet.getDouble("discountPrice"));
                productBean.setDiscountPercent(resultSet.getDouble("discountPercent"));

                products.add(productBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return products;
    }


    // TODO: Chưa có offset và limit
    public List<ProductBean> findProductByTypeId(String categoryTypeId) {
        List<ProductBean> products = new ArrayList<>();
        String sql = "SELECT id, name, categoryTypeId, originalPrice, discountPrice, discountPercent " +
                "FROM products WHERE categoryTypeId = ? AND status = 1 " +
                "ORDER BY name ASC";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, categoryTypeId);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ProductBean productBean = new ProductBean();
                productBean.setId(resultSet.getInt("id"));
                productBean.setName(resultSet.getString("name"));
                productBean.setCategoryTypeId(resultSet.getInt("categoryTypeId"));
                productBean.setOriginalPrice(resultSet.getDouble("originalPrice"));
                productBean.setDiscountPrice(resultSet.getDouble("discountPrice"));
                productBean.setDiscountPercent(resultSet.getDouble("discountPercent"));

                products.add(productBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return products;
    }

    public List<ProductBean> findByTypeIdAndLimit(int categoryTypeId, double[] range, String sort, int start, int offset) {
        List<ProductBean> products = new ArrayList<>();
        String sql = modifiedQueryByTypeId(range, sort);

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            // Set điều kiện để setParameter (sort đã xử lý riêng trong modifiedQuery)
            if (range == null) {
                SetParameterUtil.setParameter(preparedStatement, categoryTypeId, start, offset);
            } else {
                SetParameterUtil.setParameter(preparedStatement, categoryTypeId, range[0], range[1], start, offset);
            }

            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ProductBean productBean = new ProductBean();
                productBean.setId(resultSet.getInt("id"));
                productBean.setName(resultSet.getString("name"));
                productBean.setCategoryTypeId(resultSet.getInt("categoryTypeId"));
                productBean.setOriginalPrice(resultSet.getDouble("originalPrice"));
                productBean.setDiscountPrice(resultSet.getDouble("discountPrice"));
                productBean.setDiscountPercent(resultSet.getDouble("discountPercent"));

                products.add(productBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return products;
    }

    public List<ProductBean> findByKeyAndLimit(String key, double[] range, String sort, int start, int offset) {
        List<ProductBean> products = new ArrayList<>();
        String sql = modifiedQueryByKey(key, range, sort);
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            // Set điều kiện để setParameter (sort đã xử lý riêng trong modifiedQuery)
            if (range == null) {
                SetParameterUtil.setParameter(preparedStatement, start, offset);
            } else {
                SetParameterUtil.setParameter(preparedStatement, range[0], range[1], start, offset);
            }

            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ProductBean productBean = new ProductBean();
                productBean.setId(resultSet.getInt("id"));
                productBean.setName(resultSet.getString("name"));
                productBean.setCategoryTypeId(resultSet.getInt("categoryTypeId"));
                productBean.setOriginalPrice(resultSet.getDouble("originalPrice"));
                productBean.setDiscountPrice(resultSet.getDouble("discountPrice"));
                productBean.setDiscountPercent(resultSet.getDouble("discountPercent"));

                products.add(productBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return products;
    }


    public int getTotalItemsByCategoryType(int categoryTypeId) {
        String sql = "SELECT COUNT(id) AS tongsanpham FROM products WHERE categoryTypeId = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, categoryTypeId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("tongsanpham");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return -1;
    }

    private String modifiedQueryByTypeId(double[] range, String sort) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT id, name, categoryTypeId, originalPrice, discountPrice, discountPercent ")
           .append("FROM products WHERE categoryTypeId = ? AND status = 1 ");

        if (range != null) {
            sb.append(" AND (discountPrice BETWEEN ? AND ?) ");
        }

        if (!sort.equals("none")) {
            if (sort.equals("asc")) {
                sb.append("ORDER BY discountPrice ASC ");
            } else if (sort.equals("desc")) {
                sb.append("ORDER BY discountPrice DESC ");
            }
        }
        sb.append("LIMIT ?, ?");
        return sb.toString();
    }

    private String modifiedQueryByKey(String key, double[] range, String sort) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT id, name, categoryTypeId, originalPrice, discountPrice, discountPercent, keyword ")
                .append("FROM products WHERE (name LIKE \"%")
                .append(key)
                .append("%\" OR keyword LIKE \"%")
                .append(key)
                .append("%\") AND status = 1 ");

        if (range != null) {
            sb.append(" AND (discountPrice BETWEEN ? AND ?) ");
        }

        if (!sort.equals("none")) {
            if (sort.equals("asc")) {
                sb.append("ORDER BY discountPrice ASC ");
            } else if (sort.equals("desc")) {
                sb.append("ORDER BY discountPrice DESC ");
            }
        }
        sb.append("LIMIT ?, ?");
        return sb.toString();
    }

    public void updateQuantity(int quantity, int id) {
        String sql = "UPDATE products SET quantity = ? WHERE id = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);

            SetParameterUtil.setParameter(preparedStatement, quantity, id);
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }

    public List<String> getSuggestTitle(String key) {
        String sql = "SELECT name FROM products WHERE name LIKE ?";
        List<String> suggestKeys = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            String keyQuery = "%" + key + "%";
            SetParameterUtil.setParameter(preparedStatement, keyQuery);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                String productName = resultSet.getString("name");
                suggestKeys.add(productName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return suggestKeys;
    }

    public int getTotalItems() {
        String sql = "SELECT COUNT(id) AS tongsanpham FROM products";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("tongsanpham");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return -1;
    }
}