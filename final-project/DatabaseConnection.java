import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
// import java.sql.*;
 
public class DatabaseConnection {
    public static void main(String[] args) {

        String port = System.getenv("DB_PORT"); 
        String database = System.getenv("DB_NAME");

        String username = "postgres";
        String password = System.getenv("DB_PASSWORD");

        if (port == null) port = "5432";
        if (database == null) database = "postgres";

        String url = "jdbc:postgresql://localhost:" + port + "/" +  database;
 
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
