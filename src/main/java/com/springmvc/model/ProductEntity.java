package com.springmvc.model;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "products")
public class ProductEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    private String description;
    
    @Column(nullable = false)
    private Double price;
    
    private Integer stock;
    
    private String category;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date")
    private Date createdDate;
    
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<OrderItemEntity> orderItems;
    
    // Constructors
    public ProductEntity() {
        this.createdDate = new Date();
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    
    public Integer getStock() { return stock; }
    public void setStock(Integer stock) { this.stock = stock; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    
    public List<OrderItemEntity> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItemEntity> orderItems) { this.orderItems = orderItems; }
}