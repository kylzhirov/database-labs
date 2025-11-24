import java.net.Socket;
import java.io.InputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.BufferedOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Client implements Runnable {

    private Socket clientSocket;
    private Thread thread;

    public Client(Socket clientSocket) {
        this.clientSocket = clientSocket;
        thread = new Thread(this);
        
        // Initialize database on first client connection
        DatabaseConnection.initializeDatabase();
    }

    public void run() {
        System.out.println("New Client Connection");

        try {
            handleRequest();
        } catch (Exception e) {
            System.out.println("Unexpected error: " + e.getMessage());
        } finally {
            closeSocket();
        }
    }

    private void handleRequest() {
        try {
            InputStream in = clientSocket.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(in));

            String requestLine = reader.readLine();
            if (requestLine == null) {
                System.out.println("Empty request");
                return;
            }
            
            System.out.println("Current request: " + requestLine);

            String method = "GET";
            String requestedPath = "/index.html";

            if (requestLine.startsWith("GET")) {
                String[] parts = requestLine.split(" ");
                requestedPath = parts[1];
                method = "GET";
            } else if (requestLine.startsWith("POST")) {
                String[] parts = requestLine.split(" ");
                requestedPath = parts[1];
                method = "POST";
            }

            int contentLength = 0;
            String header;
            while (true) {
                header = reader.readLine();
                if (header == null || header.isEmpty()) {
                    break;
                } else if (header.startsWith("Content-Length:")) {
                    String[] parts = header.split(":");
                    contentLength = Integer.parseInt(parts[1].trim());
                }
            }

            if ("POST".equals(method) && "/register".equals(requestedPath)) {
                handleRegistration(reader, contentLength);
                return;
            }

            if ("POST".equals(method) && "/login".equals(requestedPath)) {
                handleLogin(reader, contentLength);
                return;
            }

            serveFile(requestedPath);

        } catch (IOException ioe) {
            System.out.println("Error: failed to handle request: " + ioe.getMessage());
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error: SHA-256 algorithm not available");
        }
    }

    private void handleRegistration(BufferedReader bufferedReader, int contentLength) {
        try {
            System.out.println("CONTENT LENGTH: " + contentLength);
            char[] body = new char[contentLength];
            bufferedReader.read(body, 0, contentLength);
            System.out.println(body);
            String postData = new String(body);
            
            String[] pairsBody = postData.split("&");
            String username = null;
            String password = null;
            
            for (String authCredentials : pairsBody) {
                String[] pairsAuthCredentials = authCredentials.split("=");
                if (pairsAuthCredentials.length == 2) {
                    if ("username".equals(pairsAuthCredentials[0])) {
                        username = java.net.URLDecoder.decode(pairsAuthCredentials[1], "UTF-8");
                    } else if ("password".equals(pairsAuthCredentials[0])) {
                        password = java.net.URLDecoder.decode(pairsAuthCredentials[1], "UTF-8");
                    }
                }
            }
            
            if (!username.trim().isEmpty() && !password.trim().isEmpty()) {
                String checkUserSQL = "SELECT id FROM users WHERE username = ?";
                try (Connection conn = DatabaseConnection.getConnection();
                     PreparedStatement checkStatement = conn.prepareStatement(checkUserSQL)) {
                    
                    checkStatement.setString(1, username.trim());
                    ResultSet rs = checkStatement.executeQuery();
                    
                    if (rs.next()) {
                        sendError(409, "Username already exists");
                    } else {
                        // Insert new user
                        String insertSQL = "INSERT INTO users (username, password) VALUES (?, ?)";
                        try (PreparedStatement insertStatement = conn.prepareStatement(insertSQL)) {
                            String hashedPassword = hashPassword(password);
                            insertStatement.setString(1, username.trim());
                            insertStatement.setString(2, hashedPassword);
                            insertStatement.executeUpdate();
                            
                            System.out.println("New user registered: " + username);
                            serveFile("/register_success.html");
                        }
                    }
                } catch (SQLException e) {
                    System.out.println("Database error during registration: " + e.getMessage());
                    e.printStackTrace();
                    sendError(500, "Database connection error: " + e.getMessage());
                }
            } else {
                sendError(400, "Invalid registration data");
            }
            
        } catch (Exception e) {
            System.out.println("Error handling registration: " + e.getMessage());
            e.printStackTrace();
            sendError(500, "Internal server error: " + e.getMessage());
        }
    }

    private void handleLogin(BufferedReader bufferedReader, int contentLength) {
    try {
        char[] body = new char[contentLength];
        bufferedReader.read(body, 0, contentLength);
        String postData = new String(body);
        
        String[] pairsBody = postData.split("&");
        String username = null;
        String password = null;
        
        for (String authCredentials : pairsBody) {
            String[] pairsAuthCredentials = authCredentials.split("=");
            if (pairsAuthCredentials.length == 2) {
                if ("username".equals(pairsAuthCredentials[0])) {
                    username = java.net.URLDecoder.decode(pairsAuthCredentials[1], "UTF-8");
                } else if ("password".equals(pairsAuthCredentials[0])) {
                    password = java.net.URLDecoder.decode(pairsAuthCredentials[1], "UTF-8");
                }
            }
        }
        
        if (username != null && password != null && !username.trim().isEmpty() && !password.trim().isEmpty()) {
            String selectSQL = "SELECT password FROM users WHERE username = ?";
            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(selectSQL)) {
                
                stmt.setString(1, username.trim());
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
                    String storedHashedPassword = rs.getString("password");
                    String providedHashedPassword = hashPassword(password);
                    
                    System.out.println("Stored hash for '" + username + "': '" + storedHashedPassword + "'");
                    System.out.println("Provided hash: '" + providedHashedPassword + "'");
                    
                    if (storedHashedPassword.equals(providedHashedPassword)) {
                        System.out.println("User logged in: " + username);
                        serveFile("/success.html");
                    } else {
                        System.out.println("Password mismatch for user: " + username);
                        sendError(401, "Invalid username or password");
                    }
                } else {
                    System.out.println("User not found: " + username);
                    sendError(401, "Invalid username or password");
                }
            } catch (SQLException e) {
                System.out.println("Database error during login: " + e.getMessage());
                e.printStackTrace(); // Add this to see the full stack trace
                sendError(500, "Database connection error: " + e.getMessage());
            }
        } else {
            sendError(400, "Invalid login data");
        }
        
        } catch (Exception e) {
            System.out.println("Error handling login: " + e.getMessage());
            e.printStackTrace();
            sendError(500, "Internal server error: " + e.getMessage());
        }
    }


    private void serveFile(String requestedPath) {
        try {
            String filePath;
            
            if (requestedPath.equals("/success.html")) {
                filePath = "frontend/success.html";
            } else if (requestedPath.equals("/register_success.html")) {
                filePath = "frontend/register_success.html";
            } else if (requestedPath.equals("/register.html")) {
                filePath = "frontend/register.html";
            } else if (requestedPath.equals("/") || requestedPath.equals("/index.html")) {
                filePath = "frontend/index.html";
            } else {
                sendError(404, "Not found: " + requestedPath);
                return;
            }

            System.out.println("Serving file: " + filePath);

            Path path = Paths.get(filePath);
            if (!Files.exists(path)) {
                System.out.println("File not found: " + path.toAbsolutePath());
                sendError(404, "File not found: " + filePath);
                return;
            }

            byte[] fileContent = Files.readAllBytes(path);
            sendResponse(200, "OK", fileContent, "text/html");
            System.out.println("Response sent successfully");

        } catch (IOException ioe) {
            System.out.println("Error serving file: " + ioe.getMessage());
        }
    }

    private void sendResponse(int statusCode, String statusMessage, byte[] data, String dataType) throws IOException {
        OutputStream out = clientSocket.getOutputStream();
        PrintWriter printWriter = new PrintWriter(out, true);

        printWriter.println("HTTP/1.1 " + statusCode + " " + statusMessage);
        printWriter.println("Server: Java HTTP Server from Intern Labs 7.0");
        printWriter.println("Content-type: " + dataType);
        printWriter.println("Content-length: " + data.length);
        printWriter.println("Connection: close");
        printWriter.println();
        printWriter.flush();

        BufferedOutputStream dataOut = new BufferedOutputStream(out);
        dataOut.write(data, 0, data.length);
        dataOut.flush();
    }

    private void sendError(int statusCode, String message) {
        try {
            String errorHtml =
            """
                <html>
                    <body>
                        <h1>%d Error</h1>
                        <p>%s</p>
                    </body>
                </html>
            """.formatted(statusCode, message);
            
            byte[] errorData = errorHtml.getBytes("UTF-8");
            sendResponse(statusCode, "Error", errorData, "text/html");
            
        } catch (IOException e) {
            System.out.println("Failed to send error: " + e.getMessage());
        }
    }

    private void closeSocket() {
        try {
            if (clientSocket != null) {
                clientSocket.close();
                System.out.println("Socket closed\n");
            }
        } catch (IOException e) {
            System.out.println("Failed to close socket: " + e);
        }
    }

    public void go() {
        thread.start();
    }
}
