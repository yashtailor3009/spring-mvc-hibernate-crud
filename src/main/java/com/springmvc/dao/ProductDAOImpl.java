package com.springmvc.dao;

import com.springmvc.model.ProductEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
@Transactional
public class ProductDAOImpl implements ProductDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public List<ProductEntity> getAllProducts() {
        Session session = getCurrentSession();
        Query<ProductEntity> query = session.createQuery("FROM ProductEntity ORDER BY id DESC", ProductEntity.class);
        return query.list();
    }

    @Override
    public ProductEntity getProductById(Long id) {
        Session session = getCurrentSession();
        return session.get(ProductEntity.class, id);
    }

    @Override
    public void saveProduct(ProductEntity product) {
        Session session = getCurrentSession();
        session.save(product);
    }

    @Override
    public void updateProduct(ProductEntity product) {
        Session session = getCurrentSession();
        session.update(product);
    }

    @Override
    public void deleteProduct(Long id) {
        Session session = getCurrentSession();
        ProductEntity product = session.get(ProductEntity.class, id);
        if (product != null) {
            session.delete(product);
        }
    }

    @Override
    public List<ProductEntity> getProductsByCategory(String category) {
        Session session = getCurrentSession();
        Query<ProductEntity> query = session.createQuery(
            "FROM ProductEntity WHERE category = :category", ProductEntity.class);
        query.setParameter("category", category);
        return query.list();
    }

    @Override
    public List<ProductEntity> searchProducts(String keyword) {
        Session session = getCurrentSession();
        Query<ProductEntity> query = session.createQuery(
            "FROM ProductEntity WHERE name LIKE :keyword OR description LIKE :keyword OR category LIKE :keyword", 
            ProductEntity.class);
        query.setParameter("keyword", "%" + keyword + "%");
        return query.list();
    }

    @Override
    public void updateStock(Long productId, int quantity) {
        Session session = getCurrentSession();
        ProductEntity product = session.get(ProductEntity.class, productId);
        if (product != null) {
            product.setStock(product.getStock() - quantity);
            session.update(product);
        }
    }
}