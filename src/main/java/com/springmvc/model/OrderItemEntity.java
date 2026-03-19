package com.springmvc.model;

import javax.persistence.*;

@Entity
@Table(name = "order_items")
public class OrderItemEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "order_id", nullable = false)
    private OrderEntity order;
    
    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private ProductEntity product;
    
    private Integer quantity;
    
    private Double price;
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public OrderEntity getOrder() { return order; }
    public void setOrder(OrderEntity order) { this.order = order; }
    
    public ProductEntity getProduct() { return product; }
    public void setProduct(ProductEntity product) { this.product = product; }
    
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    
    // Helper method to calculate subtotal
    public Double getSubtotal() {
        return price * quantity;
    }
}