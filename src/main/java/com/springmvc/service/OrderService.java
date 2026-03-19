package com.springmvc.service;

import com.springmvc.model.OrderEntity;
import com.springmvc.model.OrderItemEntity;
import com.springmvc.model.ProductEntity;
import com.springmvc.model.UserEntity;
import java.util.List;

public interface OrderService {
    List<OrderEntity> getAllOrders();
    OrderEntity getOrderById(Long id);
    List<OrderEntity> getOrdersByUser(Long userId);
    OrderEntity createOrder(UserEntity user, List<OrderItemEntity> items);
    void updateOrderStatus(Long orderId, String status);
    void cancelOrder(Long orderId);
    List<OrderEntity> getOrdersByStatus(String status);
}