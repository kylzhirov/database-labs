import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
// import java.sql.*;
 
public class DatabaseConnection {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5432/postgres";
        String username = "postgres";
        String password = System.getenv("DB_PASSWORD");
 
        try {
            // Establish a connection
            Connection connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to the database!");
 
            // Close the connection
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
