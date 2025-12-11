package com.example.demo.repository;

import com.example.demo.infrastructure.DatabaseConnection;
import com.example.demo.model.Beatmap;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Repository
public class JdbcUserSongRepository implements UserSongRepository {
    private final DatabaseConnection db = DatabaseConnection.getInstance();

    @Override
    public void insertIfNotExists(long userId, long songId, LocalDateTime addedAt) throws SQLException {
        String sql = """
            INSERT INTO user_songs (user_id, song_id, added_at)
            VALUES (?, ?, ?)
            ON CONFLICT (user_id, song_id) DO NOTHING
            """;
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, songId);
            if (addedAt != null) ps.setTimestamp(3, Timestamp.valueOf(addedAt)); else ps.setNull(3, Types.TIMESTAMP);
            ps.executeUpdate();
        }
    }

    @Override
    public List<Beatmap> findSongsByUser(long userId, int limit, int offset) throws SQLException {
        String sql = """
                SELECT b.*
                FROM user_songs us
                JOIN beatmaps b ON b.beatmap_id = us.song_id
                WHERE us.user_id = ?
                ORDER BY us.added_at DESC NULLS LAST
                LIMIT ? OFFSET ?
                """;
        List<Beatmap> list = new ArrayList<>();
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setInt(2, Math.max(1, limit));
            ps.setInt(3, Math.max(0, offset));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapBeatmap(rs));
            }
        }
        return list;
    }

    @Override
    public List<Beatmap> findCommonSongs(long userId1, long userId2, int limit, int offset) throws SQLException {
        String sql = """
            SELECT b.*
            FROM beatmaps b
            JOIN user_songs u1 ON u1.song_id = b.beatmap_id AND u1.user_id = ?
            JOIN user_songs u2 ON u2.song_id = b.beatmap_id AND u2.user_id = ?
            ORDER BY b.title NULLS LAST, b.artist NULLS LAST
            LIMIT ? OFFSET ?
            """;
        List<Beatmap> list = new ArrayList<>();
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId1);
            ps.setLong(2, userId2);
            ps.setInt(3, Math.max(1, limit));
            ps.setInt(4, Math.max(0, offset));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapBeatmap(rs));
            }
        }
        return list;
    }

    @Override
    public int countSongsByUser(long userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM user_songs WHERE user_id = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    @Override
    public int countCommonSongs(long userId1, long userId2) throws SQLException {
        String sql = """
            SELECT COUNT(*)
            FROM user_songs u1
            JOIN user_songs u2 ON u2.song_id = u1.song_id
            WHERE u1.user_id = ? AND u2.user_id = ?
            """;
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId1);
            ps.setLong(2, userId2);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    private static Beatmap mapBeatmap(ResultSet rs) throws SQLException {
        Beatmap b = new Beatmap();
        b.setBeatmapId(rs.getLong("beatmap_id"));
        long bms = rs.getLong("beatmapset_id");
        b.setBeatmapsetId(rs.wasNull() ? null : bms);
        b.setVersion(rs.getString("version"));
        b.setMode(rs.getString("mode"));
        java.math.BigDecimal dr = rs.getBigDecimal("difficulty_rating");
        b.setDifficultyRating(dr != null ? dr.doubleValue() : null);
        int tl = rs.getInt("total_length");
        b.setTotalLength(rs.wasNull() ? null : tl);
        java.math.BigDecimal bpm = rs.getBigDecimal("bpm");
        b.setBpm(bpm != null ? bpm.doubleValue() : null);
        b.setTitle(rs.getString("title"));
        b.setArtist(rs.getString("artist"));
        b.setCreator(rs.getString("creator"));
        return b;
    }
}
