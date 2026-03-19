package com.springmvc.controller;

import com.springmvc.model.UserEntity;
import com.springmvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/users")
public class UserController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping
    public String listUsers(Model model, HttpSession session){
        if (session.getAttribute("loggedInUser") == null){
            return "redirect:/login";
        }
        
        List<UserEntity> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "user-list";
    }
    
    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session){
        if (session.getAttribute("loggedInUser") == null){
            return "redirect:/login";
        }
        
        model.addAttribute("user", new UserEntity());
        return "user-form";
    }
    
    @PostMapping("/save")
    public String saveUser(@ModelAttribute("user") UserEntity user,
                RedirectAttributes redirectAttributes,
                HttpSession session){
        if (session.getAttribute("loggedInUser") == null){  // FIXED
            return "redirect:/login";
        }
        
        try{
            userService.saveUser(user);
            redirectAttributes.addFlashAttribute("successMessage", "User saved successfully");
        } catch (Exception e){
            redirectAttributes.addFlashAttribute("errorMessage", "Error saving user: " + e.getMessage());
        }
        return "redirect:/users";
    }
    
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, 
                    Model model,
                    HttpSession session,
                    RedirectAttributes redirectAttributes){
        if (session.getAttribute("loggedInUser") == null){  // FIXED
            return "redirect:/login";
        }
        try {
            UserEntity user = userService.getUserById(id);
            if(user == null){
                redirectAttributes.addFlashAttribute("errorMessage", "User not found");
                return "redirect:/users";
            }
            model.addAttribute("user", user);
            return "user-form";
        } catch (Exception e){
            redirectAttributes.addFlashAttribute("errorMessage", "Error: " + e.getMessage());
            return "redirect:/users";
        }
    }
    
    @PostMapping("/update")
    public String updateUser(@ModelAttribute("user") UserEntity user,
                    RedirectAttributes redirectAttributes,
                    HttpSession session){
        
        if (session.getAttribute("loggedInUser") == null){
            return "redirect:/login";
        }
        try {
            userService.updateUser(user);
            redirectAttributes.addFlashAttribute("successMessage", "User updated successfully");
        } catch (Exception e){
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating user: " + e.getMessage());  // FIXED
        }
        return "redirect:/users";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id,
            RedirectAttributes redirectAttributes,
            HttpSession session){
        if(session.getAttribute("loggedInUser") == null){
            return "redirect:/login";
        }
        try {
            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("successMessage", "User deleted successfully");
        } catch (Exception e){
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting user: " + e.getMessage());
        }
        return "redirect:/users";
    }
    
    @GetMapping("/view/{id}")
    public String viewUser(@PathVariable("id") Long id,
             Model model,
             HttpSession session,
             RedirectAttributes redirectAttributes){
         if (session.getAttribute("loggedInUser") == null){
             return "redirect:/login";
         }
         
         try {
             UserEntity user = userService.getUserById(id);
             if (user == null){
                 redirectAttributes.addFlashAttribute("errorMessage", "User not found");
                 return "redirect:/users";
            }
             model.addAttribute("user", user);
             return "user-view";
         } catch (Exception e){
             redirectAttributes.addFlashAttribute("errorMessage", "Error: " + e.getMessage());
            return "redirect:/users";
         }
    }  // ← ADDED MISSING BRACE HERE
    
    @GetMapping("/search")
    public String searchUsers(@RequestParam("keyword") String keyword,
                 Model model,
                 HttpSession session){
         if (session.getAttribute("loggedInUser") == null){
             return "redirect:/login";
         }
        
         List<UserEntity> users = userService.searchUsers(keyword);
         model.addAttribute("users", users);
         model.addAttribute("keyword", keyword);
         return "user-list";
    }
}