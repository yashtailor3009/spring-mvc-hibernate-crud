package com.springmvc.dao;

import com.springmvc.model.OrderEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
@Transactional
public class OrderDAOImpl implements OrderDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public List<OrderEntity> getAllOrders() {
        Session session = getCurrentSession();
        Query<OrderEntity> query = session.createQuery("FROM OrderEntity ORDER BY orderDate DESC", OrderEntity.class);
        return query.list();
    }

    @Override
    public OrderEntity getOrderById(Long id) {
        Session session = getCurrentSession();
        return session.get(OrderEntity.class, id);
    }

    @Override
    public List<OrderEntity> getOrdersByUser(Long userId) {
        Session session = getCurrentSession();
        Query<OrderEntity> query = session.createQuery(
            "FROM OrderEntity WHERE user.id = :userId ORDER BY orderDate DESC", OrderEntity.class);
        query.setParameter("userId", userId);
        return query.list();
    }

    @Override
    public void saveOrder(OrderEntity order) {
        Session session = getCurrentSession();
        session.save(order);
    }

    @Override
    public void updateOrder(OrderEntity order) {
        Session session = getCurrentSession();
        session.update(order);
    }

    @Override
    public void deleteOrder(Long id) {
        Session session = getCurrentSession();
        OrderEntity order = session.get(OrderEntity.class, id);
        if (order != null) {
            session.delete(order);
        }
    }

    @Override
    public List<OrderEntity> getOrdersByStatus(String status) {
        Session session = getCurrentSession();
        Query<OrderEntity> query = session.createQuery(
            "FROM OrderEntity WHERE status = :status ORDER BY orderDate DESC", OrderEntity.class);
        query.setParameter("status", status);
        return query.list();
    }
}