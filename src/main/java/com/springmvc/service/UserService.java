package com.springmvc.service;

import com.springmvc.model.UserEntity;
import java.util.List;

public interface UserService {
    UserEntity authenticate(String username, String password);
    
    List<UserEntity> getAllUsers();
    UserEntity getUserById(Long id);
    void saveUser(UserEntity user);
    void updateUser(UserEntity user);
    void deleteUser(Long id);
    
    List<UserEntity> searchUsers(String keyword);
}