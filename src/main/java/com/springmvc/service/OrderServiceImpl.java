package com.springmvc.service;

import com.springmvc.dao.OrderDAO;
import com.springmvc.dao.ProductDAO;
import com.springmvc.model.OrderEntity;
import com.springmvc.model.OrderItemEntity;
import com.springmvc.model.ProductEntity;
import com.springmvc.model.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDAO orderDAO;
    
    @Autowired
    private ProductDAO productDAO;

    @Override
    public List<OrderEntity> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    @Override
    public OrderEntity getOrderById(Long id) {
        return orderDAO.getOrderById(id);
    }

    @Override
    public List<OrderEntity> getOrdersByUser(Long userId) {
        return orderDAO.getOrdersByUser(userId);
    }

    @Override
    public OrderEntity createOrder(UserEntity user, List<OrderItemEntity> items) {
        OrderEntity order = new OrderEntity();
        order.setUser(user);
        
        double total = 0.0;
        for (OrderItemEntity item : items) {
            item.setOrder(order);
            total += item.getSubtotal();
            
            // Update product stock
            ProductEntity product = item.getProduct();
            product.setStock(product.getStock() - item.getQuantity());
            productDAO.updateProduct(product);
        }
        
        order.setTotalAmount(total);
        order.setOrderItems(items);
        
        orderDAO.saveOrder(order);
        return order;
    }

    @Override
    public void updateOrderStatus(Long orderId, String status) {
        OrderEntity order = orderDAO.getOrderById(orderId);
        if (order != null) {
            order.setStatus(status);
            orderDAO.updateOrder(order);
        }
    }

    @Override
    public void cancelOrder(Long orderId) {
        OrderEntity order = orderDAO.getOrderById(orderId);
        if (order != null && "PENDING".equals(order.getStatus())) {
            // Restore stock
            for (OrderItemEntity item : order.getOrderItems()) {
                ProductEntity product = item.getProduct();
                product.setStock(product.getStock() + item.getQuantity());
                productDAO.updateProduct(product);
            }
            order.setStatus("CANCELLED");
            orderDAO.updateOrder(order);
        }
    }

    @Override
    public List<OrderEntity> getOrdersByStatus(String status) {
        return orderDAO.getOrdersByStatus(status);
    }
}