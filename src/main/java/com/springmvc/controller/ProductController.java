package com.springmvc.controller;

import com.springmvc.model.ProductEntity;
import com.springmvc.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public String listProducts(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        List<ProductEntity> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "product-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("product", new ProductEntity());
        return "product-form";
    }

    @PostMapping("/save")
    public String saveProduct(@ModelAttribute ProductEntity product,
                             RedirectAttributes redirectAttributes,
                             HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        try {
            productService.saveProduct(product);
            redirectAttributes.addFlashAttribute("successMessage", "Product saved successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error: " + e.getMessage());
        }
        return "redirect:/products";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        try {
            ProductEntity product = productService.getProductById(id);
            if (product == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Product not found!");
                return "redirect:/products";
            }
            model.addAttribute("product", product);
            return "product-form";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error: " + e.getMessage());
            return "redirect:/products";
        }
    }

    @PostMapping("/update")
    public String updateProduct(@ModelAttribute ProductEntity product,
                               RedirectAttributes redirectAttributes,
                               HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        try {
            productService.updateProduct(product);
            redirectAttributes.addFlashAttribute("successMessage", "Product updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error: " + e.getMessage());
        }
        return "redirect:/products";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id,
                               RedirectAttributes redirectAttributes,
                               HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        try {
            productService.deleteProduct(id);
            redirectAttributes.addFlashAttribute("successMessage", "Product deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error: " + e.getMessage());
        }
        return "redirect:/products";
    }

    @GetMapping("/search")
    public String searchProducts(@RequestParam String keyword, Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        List<ProductEntity> products = productService.searchProducts(keyword);
        model.addAttribute("products", products);
        model.addAttribute("keyword", keyword);
        return "product-list";
    }
}