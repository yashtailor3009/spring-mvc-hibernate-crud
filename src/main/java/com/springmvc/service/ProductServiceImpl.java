package com.springmvc.service;

import com.springmvc.dao.ProductDAO;
import com.springmvc.model.ProductEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDAO productDAO;

    @Override
    public List<ProductEntity> getAllProducts() {
        return productDAO.getAllProducts();
    }

    @Override
    public ProductEntity getProductById(Long id) {
        return productDAO.getProductById(id);
    }

    @Override
    public void saveProduct(ProductEntity product) {
        productDAO.saveProduct(product);
    }

    @Override
    public void updateProduct(ProductEntity product) {
        productDAO.updateProduct(product);
    }

    @Override
    public void deleteProduct(Long id) {
        productDAO.deleteProduct(id);
    }

    @Override
    public List<ProductEntity> getProductsByCategory(String category) {
        return productDAO.getProductsByCategory(category);
    }

    @Override
    public List<ProductEntity> searchProducts(String keyword) {
        return productDAO.searchProducts(keyword);
    }

    @Override
    public void updateStock(Long productId, int quantity) {
        productDAO.updateStock(productId, quantity);
    }
}