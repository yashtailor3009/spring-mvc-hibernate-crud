package com.springmvc.service;

import com.springmvc.dao.UserDAO;
import com.springmvc.model.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService{
    
    @Autowired
    private UserDAO userDAO;
    
    @Override
    public UserEntity authenticate (String username, String password){
        UserEntity user = userDAO.findByUsername(username);
        if (user != null && user.getPassword().equals(password)){
            return user;
        }
        return null;
    }
    
    @Override
    public List<UserEntity> getAllUsers(){
        return userDAO.getAllUsers();
    }
    
    @Override
    public UserEntity getUserById(Long id){
        return userDAO.getUserById(id);
    }
    
    @Override
    public void saveUser(UserEntity user){
        if (user.getRole()== null || user.getRole().isEmpty()){
            user.setRole("USER");
        }
        if (user.getStatus() == null || user.getStatus().isEmpty()){
            user.setStatus("ACTIVE");
        }
        userDAO.saveUser(user);
    }
    
    @Override
    public void updateUser(UserEntity user){
        userDAO.updateUser(user);
    }
    
    @Override
    public void deleteUser(Long id){
        userDAO.deleteUser(id);
    }
    
    @Override
    public List<UserEntity> searchUsers(String keyword){
        return userDAO.searchUsers(keyword);
    }
}