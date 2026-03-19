package com.springmvc.controller;

import com.springmvc.model.UserEntity;
import com.springmvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/login")
    public String showLoginForm(@RequestParam(value = "error", required = false) String error,
                @RequestParam(value = "logout", required = false) String logout, 
                Model model) {
        if (error != null) {
            model.addAttribute("error", "Invalid username or password!");
        }
        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully.");
        }
        return "login";
    }
    
    @PostMapping("/login")
    public String processLogin(@RequestParam("username") String username,
            @RequestParam("password") String password,  // ← YEH SAHI HAI (small p)
            HttpSession session,
            Model model) {
        
        UserEntity user = userService.authenticate(username, password);
        
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            session.setAttribute("username", user.getUsername());
            return "redirect:/dashboard";
        } else {
            model.addAttribute("error", "Invalid username or password!");
            return "login";
        }
    }
    
//    @GetMapping("/dashboard")
//    public String showDashboard(HttpSession session, Model model) {
//        
//        if (session.getAttribute("loggedInUser") == null) {
//            return "redirect:/login";
//        }
//        
//        model.addAttribute("username", session.getAttribute("username"));
//        return "dashboard";
//    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout=true";
    }
}