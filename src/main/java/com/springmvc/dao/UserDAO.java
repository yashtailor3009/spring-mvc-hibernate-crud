package com.springmvc.dao;

import com.springmvc.model.UserEntity;
import java.util.List;

public interface UserDAO {
    UserEntity findByUsername(String username);
    
//    saare user lao
    List<UserEntity> getAllUsers();
    
//    ID se user lao
    UserEntity getUserById(Long id);
    
//     Naya user save karo
    void saveUser(UserEntity user);
    
//    User update karo
    void updateUser(UserEntity user);
    
//    User delete Karo
    void deleteUser(Long id);
    
//    Search users by keyword
    List<UserEntity> searchUsers(String keyword);
}
