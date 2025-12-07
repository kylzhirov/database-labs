package com.example.demo.repository;

import com.example.demo.infrastructure.DatabaseConnection;
import com.example.demo.model.User;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.Optional;

@Repository
public class JdbcUserRepository implements UserRepository {

    private final DatabaseConnection db = DatabaseConnection.getInstance();

    @Override
    public Optional<User> findByUsername(String username) throws SQLException {
        String sql = "SELECT id, username, password, created_at FROM users WHERE username = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    User user = mapRow(resultSet);
                    return Optional.of(user);
                }
            }
        }
        return Optional.empty();
    }

    @Override
    public boolean existsByUsername(String username) throws SQLException {
        String sqlQuery = "SELECT 1 FROM users WHERE username = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery)) {
            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    @Override
    public User save(User user) throws SQLException {
        String sqlQuery = "INSERT INTO users (username, password) VALUES (?, ?) RETURNING id, created_at";
        try (Connection conn = db.getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(sqlQuery)) {
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    long id = resultSet.getLong(1);
                    Timestamp timestamp = resultSet.getTimestamp(2);
                    user.setId(id);
                    if (timestamp != null) {
                        user.setCreatedAt(timestamp.toLocalDateTime());
                    }
                }
            }
        }
        return user;
    }

    private static User mapRow(ResultSet resultSet) throws SQLException {
        Long id = resultSet.getLong("id");
        String username = resultSet.getString("username");
        String password = resultSet.getString("password");
        Timestamp timestamp = resultSet.getTimestamp("created_at");
        LocalDateTime createdAt = timestamp != null ? timestamp.toLocalDateTime() : null;
        return new User(id, username, password, createdAt);
    }
}
