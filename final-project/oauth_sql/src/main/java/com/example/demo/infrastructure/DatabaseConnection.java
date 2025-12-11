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
        String createUsersTableSQL = """
            CREATE TABLE IF NOT EXISTS users (
                id SERIAL PRIMARY KEY,
                username VARCHAR(50) UNIQUE NOT NULL,
                password VARCHAR(255) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """;

        String createOsuUsersTableSQL = """
            CREATE TABLE IF NOT EXISTS osu_users (
                osu_user_id BIGINT PRIMARY KEY,
                username VARCHAR(100),
                country_code CHAR(2),
                last_synced_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """;

        String createBeatmapsTableSQL = """
            CREATE TABLE IF NOT EXISTS beatmaps (
                beatmap_id BIGINT PRIMARY KEY,
                beatmapset_id BIGINT,
                version VARCHAR(255),
                mode VARCHAR(20),
                difficulty_rating NUMERIC(6,2),
                total_length INT,
                bpm NUMERIC(7,2),
                title VARCHAR(255),
                artist VARCHAR(255),
                creator VARCHAR(255)
            )
            """;

        String createUserPlaysTableSQL = """
            CREATE TABLE IF NOT EXISTS user_plays (
                play_id BIGSERIAL PRIMARY KEY,
                osu_user_id BIGINT NOT NULL REFERENCES osu_users(osu_user_id) ON DELETE CASCADE,
                beatmap_id BIGINT NOT NULL REFERENCES beatmaps(beatmap_id) ON DELETE CASCADE,
                played_at TIMESTAMP,
                score BIGINT,
                accuracy NUMERIC(5,3),
                max_combo INT,
                rank VARCHAR(5),
                mods VARCHAR(100),
                UNIQUE(osu_user_id, beatmap_id, played_at)
            )
            """;

        // Junction table for many-to-many relation
        String createUserSongsTableSQL = """
            CREATE TABLE IF NOT EXISTS user_songs (
                user_id BIGINT NOT NULL REFERENCES osu_users(osu_user_id) ON DELETE CASCADE,
                song_id BIGINT NOT NULL REFERENCES beatmaps(beatmap_id) ON DELETE CASCADE,
                added_at TIMESTAMP NULL,
                PRIMARY KEY (user_id, song_id)
            )
            """;

        String createIndexesSQL = """
            CREATE INDEX IF NOT EXISTS idx_user_plays_user ON user_plays(osu_user_id);
            CREATE INDEX IF NOT EXISTS idx_user_plays_beatmap ON user_plays(beatmap_id);
            CREATE INDEX IF NOT EXISTS idx_user_plays_played_at ON user_plays(played_at DESC);
            CREATE INDEX IF NOT EXISTS idx_user_songs_user ON user_songs(user_id);
            CREATE INDEX IF NOT EXISTS idx_user_songs_song ON user_songs(song_id);
            """;

        try (Connection connection = getConnection()) {
            // Use a transaction to initialize all objects
            connection.setAutoCommit(false);
            try (PreparedStatement ps1 = connection.prepareStatement(createUsersTableSQL);
                 PreparedStatement ps2 = connection.prepareStatement(createOsuUsersTableSQL);
                 PreparedStatement ps3 = connection.prepareStatement(createBeatmapsTableSQL);
                 PreparedStatement ps4 = connection.prepareStatement(createUserPlaysTableSQL);
                 PreparedStatement ps5 = connection.prepareStatement(createUserSongsTableSQL)) {
                ps1.execute();
                ps2.execute();
                ps3.execute();
                ps4.execute();
                ps5.execute();
            }
            try (PreparedStatement psIdx = connection.prepareStatement(createIndexesSQL)) {
                psIdx.execute();
            }
            // Fill user_songs from existing user_plays
            String backfillUserSongs = """
                INSERT INTO user_songs (user_id, song_id, added_at)
                SELECT up.osu_user_id, up.beatmap_id, MIN(up.played_at) AS added_at
                FROM user_plays up
                GROUP BY up.osu_user_id, up.beatmap_id
                ON CONFLICT (user_id, song_id) DO NOTHING
            """;
            try (PreparedStatement psBackfill = connection.prepareStatement(backfillUserSongs)) {
                psBackfill.executeUpdate();
            }
            connection.commit();

            System.out.println("Database initialized successfully (auth + osu tables)");

            String adminHashedPasswd = passwordAuth.hash("admin");

            // default user
            String insertAdminSQL = """
                INSERT INTO users (username, password)
                VALUES ('admin', ?)
                ON CONFLICT (username) DO NOTHING
            """;

            try (PreparedStatement adminStmt = connection.prepareStatement(insertAdminSQL)) {
                adminStmt.setString(1, adminHashedPasswd);
                adminStmt.executeUpdate();
            }
            connection.commit();

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
