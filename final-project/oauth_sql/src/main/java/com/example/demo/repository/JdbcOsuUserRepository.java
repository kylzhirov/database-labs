package com.example.demo.repository;

import com.example.demo.infrastructure.DatabaseConnection;
import com.example.demo.model.OsuUser;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.Optional;

@Repository
public class JdbcOsuUserRepository implements OsuUserRepository {
    private final DatabaseConnection db = DatabaseConnection.getInstance();

    @Override
    public void upsert(OsuUser user) throws SQLException {
        String sql = """
                INSERT INTO osu_users (osu_user_id, username, country_code, last_synced_at)
                VALUES (?, ?, ?, COALESCE(?, CURRENT_TIMESTAMP))
                ON CONFLICT (osu_user_id)
                DO UPDATE SET username = EXCLUDED.username,
                              country_code = EXCLUDED.country_code,
                              last_synced_at = EXCLUDED.last_synced_at
                """;
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, user.getOsuUserId());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getCountryCode());
            if (user.getLastSyncedAt() != null) {
                ps.setTimestamp(4, Timestamp.valueOf(user.getLastSyncedAt()));
            } else {
                ps.setTimestamp(4, null);
            }
            ps.executeUpdate();
        }
    }

    @Override
    public Optional<OsuUser> findById(long osuUserId) throws SQLException {
        String sql = "SELECT osu_user_id, username, country_code, last_synced_at FROM osu_users WHERE osu_user_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, osuUserId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    OsuUser u = new OsuUser(
                            rs.getLong(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getTimestamp(4) != null ? rs.getTimestamp(4).toLocalDateTime() : null
                    );
                    return Optional.of(u);
                }
            }
        }
        return Optional.empty();
    }
}
