package com.example.demo.repository;

import com.example.demo.infrastructure.DatabaseConnection;
import com.example.demo.model.UserPlay;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Repository
public class JdbcUserPlayRepository implements UserPlayRepository {
    private final DatabaseConnection db = DatabaseConnection.getInstance();

    @Override
    public void insertIfNotExists(UserPlay p) throws SQLException {
        String sql = """
                INSERT INTO user_plays (osu_user_id, beatmap_id, played_at, score, accuracy, max_combo, rank, mods)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                ON CONFLICT (osu_user_id, beatmap_id, played_at) DO NOTHING
                """;
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, p.getOsuUserId());
            ps.setLong(2, p.getBeatmapId());
            if (p.getPlayedAt() != null) {
                ps.setTimestamp(3, Timestamp.valueOf(p.getPlayedAt()));
            } else {
                ps.setTimestamp(3, null);
            }
            if (p.getScore() != null) ps.setLong(4, p.getScore());
            else ps.setNull(4, Types.BIGINT);
            if (p.getAccuracy() != null) ps.setBigDecimal(5, java.math.BigDecimal.valueOf(p.getAccuracy()));
            else ps.setNull(5, Types.NUMERIC);
            if (p.getMaxCombo() != null) ps.setInt(6, p.getMaxCombo());
            else ps.setNull(6, Types.INTEGER);
            ps.setString(7, p.getRank());
            ps.setString(8, p.getMods());
            ps.executeUpdate();

            // Maintain user_songs junction table
            String upsertUserSong = """
                    INSERT INTO user_songs (user_id, song_id, added_at)
                    VALUES (?, ?, ?)
                    ON CONFLICT (user_id, song_id) DO NOTHING
                    """;
            try (PreparedStatement ps2 = conn.prepareStatement(upsertUserSong)) {
                ps2.setLong(1, p.getOsuUserId());
                ps2.setLong(2, p.getBeatmapId());
                if (p.getPlayedAt() != null) {
                    ps2.setTimestamp(3, Timestamp.valueOf(p.getPlayedAt()));
                } else {
                    ps2.setNull(3, Types.TIMESTAMP);
                }
                ps2.executeUpdate();
            }
        }
    }

    @Override
    public List<UserPlay> findByUser(long osuUserId) throws SQLException {
        String sql = "SELECT play_id, osu_user_id, beatmap_id, played_at, score, accuracy, max_combo, rank, mods FROM user_plays WHERE osu_user_id = ? ORDER BY played_at DESC NULLS LAST";
        List<UserPlay> list = new ArrayList<>();
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, osuUserId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserPlay p = new UserPlay();
                    p.setPlayId(rs.getLong(1));
                    p.setOsuUserId(rs.getLong(2));
                    p.setBeatmapId(rs.getLong(3));
                    Timestamp ts = rs.getTimestamp(4);
                    p.setPlayedAt(ts != null ? ts.toLocalDateTime() : null);
                    long sc = rs.getLong(5);
                    p.setScore(rs.wasNull() ? null : sc);
                    java.math.BigDecimal acc = rs.getBigDecimal(6);
                    p.setAccuracy(acc != null ? acc.doubleValue() : null);
                    int mc = rs.getInt(7);
                    p.setMaxCombo(rs.wasNull() ? null : mc);
                    p.setRank(rs.getString(8));
                    p.setMods(rs.getString(9));
                    list.add(p);
                }
            }
        }
        return list;
    }
}
