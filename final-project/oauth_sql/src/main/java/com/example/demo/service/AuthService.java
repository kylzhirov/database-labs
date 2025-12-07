package com.example.demo.service;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.util.PasswordAuthentication;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.Optional;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordAuthentication passwordAuth = new PasswordAuthentication();

    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    /**
     * Attempts to create a new user.
     * @return true when inserted, false when username already exists
     */
    public boolean register(String username, String password) throws SQLException {
        if (userRepository.existsByUsername(username)) {
            return false;
        }
        String hashedPassword = passwordAuth.hash(password);
        User user = new User(username, hashedPassword);
        userRepository.save(user);
        return true;
    }

    /**
     * Verifies provided credentials.
     */
    public boolean login(String username, String password) throws SQLException {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isEmpty()) {
            return false;
        }
        String storedPassword = userOpt.get().getPassword();
        return passwordAuth.authenticate(password, storedPassword);
    }
}
