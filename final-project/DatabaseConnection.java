import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class DatabaseConnection {
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/auth_db";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = System.getenv("DB_PASSWORD");
    
    public static Connection getConnection() throws SQLException {
        try {
            // Load PostgreSQL driver
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL JDBC Driver not found", e);
        }
        
        System.out.println("Connecting to database: " + DB_URL);
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        System.out.println("Database connection is successful");
        return conn;
    }
    
    public static void initializeDatabase() {
        String createTableSQL = """
            CREATE TABLE IF NOT EXISTS users (
                id SERIAL PRIMARY KEY,
                username VARCHAR(50) UNIQUE NOT NULL,
                password VARCHAR(255) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """;
            
        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(createTableSQL)) {
            preparedStatement.execute();

            System.out.println("Database initialized successfully");

            // Add Default user
            String insertAdminSQL = """
                INSERT INTO users (username, password) 
                VALUES ('admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918')
            """;

            try (PreparedStatement adminStmt = conn.prepareStatement(insertAdminSQL)) {
                adminStmt.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println("Error initializing database: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Test method to verify connection
    public static void testConnection() {
        try (Connection conn = getConnection()) {
            System.out.println("Database connection test: fail");
        } catch (SQLException e) {
            System.out.println("Database connection test: success");
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
