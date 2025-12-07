package com.example.demo.controller;

import com.example.demo.service.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import java.sql.SQLException;

@Controller
public class AuthController {
    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/")
    public RedirectView home() {
        // Serve the static index.html from /static
        return new RedirectView("/index.html");
    }

    @PostMapping("/register")
    public Object register(@RequestParam String username, @RequestParam String password) {
        try {
            boolean created = authService.register(username, password);
            if (!created) {
                return ResponseEntity.badRequest().body("Username already exists");
            }
            return new RedirectView("/register_success.html");
        } catch (SQLException e) {
            return ResponseEntity.internalServerError().body("Database error: " + e.getMessage());
        }
    }

    @PostMapping("/login")
    public Object login(@RequestParam String username, @RequestParam String password) {
        try {
            boolean ok = authService.login(username, password);
            if (ok) {
                return new RedirectView("/success.html");
            }
            return ResponseEntity.status(401).body("Invalid credentials");
        } catch (SQLException e) {
            return ResponseEntity.internalServerError().body("Database error: " + e.getMessage());
        }
    }
}
