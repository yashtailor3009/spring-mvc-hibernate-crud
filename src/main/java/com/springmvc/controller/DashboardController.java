package com.springmvc.controller;

import com.springmvc.service.UserService;
import com.springmvc.service.ProductService;
import com.springmvc.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class DashboardController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ProductService productService;
    
    @Autowired
    private OrderService orderService;
    
    @GetMapping("/dashboard")
    public String showDashboard(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        // Statistics
        model.addAttribute("totalUsers", userService.getAllUsers().size());
        model.addAttribute("totalProducts", productService.getAllProducts().size());
        model.addAttribute("totalOrders", orderService.getAllOrders().size());
        model.addAttribute("activeUsers", userService.getAllUsers().stream()
            .filter(u -> "ACTIVE".equals(u.getStatus())).count());
        
        // Recent Activities (you can fetch from database)
        List<Map<String, Object>> recentActivities = new ArrayList<>();
        
        Map<String, Object> activity1 = new HashMap<>();
        activity1.put("timestamp", new Date());
        activity1.put("username", session.getAttribute("username"));
        activity1.put("action", "Logged in to dashboard");
        activity1.put("status", "Success");
        activity1.put("statusClass", "active");
        recentActivities.add(activity1);
        
        model.addAttribute("recentActivities", recentActivities);
        
        return "dashboard";
    }
}