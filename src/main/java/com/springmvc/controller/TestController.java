package com.springmvc.controller;

import com.springmvc.model.UserEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;

@Controller
public class TestController {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "✅ Spring MVC is working!";
    }
    
    @GetMapping("/test-db")
    @ResponseBody
    public String testDatabase() {
        
        StringBuilder result = new StringBuilder();
        
        try {
            Session session = sessionFactory.openSession();
            Transaction tx = session.beginTransaction();
            
            // FIXED: Use "UserEntity" not "User"
            List<UserEntity> users = session.createQuery("FROM UserEntity", UserEntity.class).list();
            
            // FIXED: Use "UserEntity" not "User"
            Long count = (Long) session.createQuery("SELECT COUNT(*) FROM UserEntity").uniqueResult();
            
            tx.commit();
            session.close();
            
            result.append("✅ DATABASE CONNECTION SUCCESSFUL!\n\n");
            result.append("Total Users in Database: ").append(count).append("\n\n");
            result.append("User List:\n");
            result.append("===================\n");
            
            for (UserEntity user : users) {
                result.append("ID: ").append(user.getId())
                      .append(", Username: ").append(user.getUsername())
                      .append(", Email: ").append(user.getEmail())
                      .append(", Role: ").append(user.getRole())
                      .append("\n");
            }
            
        } catch (Exception e) {
            result.append("❌ DATABASE CONNECTION FAILED!\n\n");
            result.append("Error: ").append(e.getMessage()).append("\n\n");
            e.printStackTrace();
        }
        
        return result.toString().replace("\n", "<br>"); // For better HTML display
    }
}