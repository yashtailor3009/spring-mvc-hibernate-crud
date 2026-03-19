package com.springmvc.service;

import com.springmvc.model.ProductEntity;
import java.util.List;

public interface ProductService {
    List<ProductEntity> getAllProducts();
    ProductEntity getProductById(Long id);
    void saveProduct(ProductEntity product);
    void updateProduct(ProductEntity product);
    void deleteProduct(Long id);
    List<ProductEntity> getProductsByCategory(String category);
    List<ProductEntity> searchProducts(String keyword);
    void updateStock(Long productId, int quantity);
}