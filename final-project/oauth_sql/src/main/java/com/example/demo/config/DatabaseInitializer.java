package com.example.demo.config;

import com.example.demo.infrastructure.DatabaseConnection;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DatabaseInitializer {

    @Bean
    CommandLineRunner initDatabase() {
        return args -> {
            try {
                DatabaseConnection.getInstance().initializeDatabase();
            } catch (Exception ignored) {
                // Keep boot resilient even if DB is unavailable at startup
            }
        };
    }
}
