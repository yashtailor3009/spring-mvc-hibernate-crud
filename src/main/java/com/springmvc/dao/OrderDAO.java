package com.springmvc.dao;

import com.springmvc.model.OrderEntity;
import java.util.List;

public interface OrderDAO {
    List<OrderEntity> getAllOrders();
    OrderEntity getOrderById(Long id);
    List<OrderEntity> getOrdersByUser(Long userId);
    void saveOrder(OrderEntity order);
    void updateOrder(OrderEntity order);
    void deleteOrder(Long id);
    List<OrderEntity> getOrdersByStatus(String status);
}