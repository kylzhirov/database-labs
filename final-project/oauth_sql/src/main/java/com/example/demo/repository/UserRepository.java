package com.example.demo.repository;

import com.example.demo.model.User;

import java.sql.SQLException;
import java.util.Optional;

public interface UserRepository {
    Optional<User> findByUsername(String username) throws SQLException;
    boolean existsByUsername(String username) throws SQLException;
    User save(User user) throws SQLException;
}
