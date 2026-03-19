package com.springmvc.dao;

import com.springmvc.model.UserEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
@Transactional
public class UserDAOImpl implements UserDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public UserEntity findByUsername(String username) {
        Session session = getCurrentSession();
        Query<UserEntity> query = session.createQuery("FROM UserEntity WHERE username = :username", UserEntity.class);
        query.setParameter("username", username);
        return query.uniqueResult();
    }

    @Override
    public List<UserEntity> getAllUsers() {
        Session session = getCurrentSession();
        Query<UserEntity> query = session.createQuery("FROM UserEntity", UserEntity.class);
        return query.list();
    }

    @Override
    public UserEntity getUserById(Long id) {
        Session session = getCurrentSession();
        return session.get(UserEntity.class, id);
    }

    @Override
    public void saveUser(UserEntity user) {
        Session session = getCurrentSession();
        session.save(user);
    }

    @Override
    public void updateUser(UserEntity user) {
        Session session = getCurrentSession();
        session.update(user);
    }

    @Override
    public void deleteUser(Long id) {
        Session session = getCurrentSession();
        UserEntity user = session.get(UserEntity.class, id);
        if (user != null) {
            session.delete(user);
        }
    }
    
    @Override
    public List<UserEntity> searchUsers(String keyword){
        Session session = getCurrentSession();
        Query<UserEntity> query = session.createQuery(
        "FROM UserEntity WHERE username LIKE : keyword or email LIKE :keyword OR fullName LIKE :keyword", 
                UserEntity.class);
        query.setParameter("keyword","%" + keyword + "%");
        return query.list();
    }
}