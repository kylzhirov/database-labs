package com.example.demo.infrastructure;

import com.example.demo.util.PasswordAuthentication;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/auth_db";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = System.getenv("DB_PASSWORD");

    private static DatabaseConnection instance;
    private PasswordAuthentication passwordAuth;

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL JDBC Driver not found", e);
        }

        System.out.println("Connecting to database: " + DB_URL);
        Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        System.out.println("Database connection is successful");
        return connection;
    }

    private DatabaseConnection() {
        this.passwordAuth = new PasswordAuthentication();
    }

    public static DatabaseConnection getInstance() {
        if (instance == null) {
            instance = new DatabaseConnection();
        }
        return instance;
    }

    public void initializeDatabase() {
        String createTableSQL = """
            CREATE TABLE IF NOT EXISTS users (
                id SERIAL PRIMARY KEY,
                username VARCHAR(50) UNIQUE NOT NULL,
                password VARCHAR(255) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(createTableSQL)) {
            preparedStatement.execute();

            System.out.println("Database initialized successfully");

            String adminHashedPasswd = passwordAuth.hash("admin");

            String insertAdminSQL = """
                INSERT INTO users (username, password)
                VALUES ('admin', ?)
                ON CONFLICT (username) DO NOTHING
            """;

            try (PreparedStatement adminStmt = connection.prepareStatement(insertAdminSQL)) {
                adminStmt.setString(1, adminHashedPasswd);
                adminStmt.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println("Error initializing database: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void testConnection() {
        try (Connection connection = getConnection()) {
            System.out.println("Database connection test: fail");
        } catch (SQLException e) {
            System.out.println("Database connection test: success");
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
