package com.example.demo.repository;

import com.example.demo.infrastructure.DatabaseConnection;
import com.example.demo.model.Beatmap;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class JdbcBeatmapRepository implements BeatmapRepository {
    private final DatabaseConnection db = DatabaseConnection.getInstance();

    @Override
    public void upsert(Beatmap b) throws SQLException {
        String sql = """
                INSERT INTO beatmaps (beatmap_id, beatmapset_id, version, mode, difficulty_rating, total_length, bpm, title, artist, creator)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ON CONFLICT (beatmap_id) DO UPDATE SET
                    beatmapset_id = EXCLUDED.beatmapset_id,
                    version = EXCLUDED.version,
                    mode = EXCLUDED.mode,
                    difficulty_rating = EXCLUDED.difficulty_rating,
                    total_length = EXCLUDED.total_length,
                    bpm = EXCLUDED.bpm,
                    title = EXCLUDED.title,
                    artist = EXCLUDED.artist,
                    creator = EXCLUDED.creator
                """;
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, b.getBeatmapId());
            if (b.getBeatmapsetId() != null) ps.setLong(2, b.getBeatmapsetId());
            else ps.setNull(2, Types.BIGINT);
            ps.setString(3, b.getVersion());
            ps.setString(4, b.getMode());
            if (b.getDifficultyRating() != null)
                ps.setBigDecimal(5, java.math.BigDecimal.valueOf(b.getDifficultyRating()));
            else ps.setNull(5, Types.NUMERIC);
            if (b.getTotalLength() != null) ps.setInt(6, b.getTotalLength());
            else ps.setNull(6, Types.INTEGER);
            if (b.getBpm() != null) ps.setBigDecimal(7, java.math.BigDecimal.valueOf(b.getBpm()));
            else ps.setNull(7, Types.NUMERIC);
            ps.setString(8, b.getTitle());
            ps.setString(9, b.getArtist());
            ps.setString(10, b.getCreator());
            ps.executeUpdate();
        }
    }

    @Override
    public Optional<Beatmap> findById(long beatmapId) throws SQLException {
        String sql = "SELECT beatmap_id, beatmapset_id, version, mode, difficulty_rating, total_length, bpm, title, artist, creator FROM beatmaps WHERE beatmap_id = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, beatmapId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(map(rs));
                }
            }
        }
        return Optional.empty();
    }

    @Override
    public List<Beatmap> findByUserPlayed(long osuUserId) throws SQLException {
        String sql = """
                SELECT b.*
                FROM user_plays up
                JOIN beatmaps b ON b.beatmap_id = up.beatmap_id
                WHERE up.osu_user_id = ?
                ORDER BY up.played_at DESC NULLS LAST
                LIMIT 100;
                """;
        List<Beatmap> list = new ArrayList<>();
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, osuUserId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    private static Beatmap map(ResultSet rs) throws SQLException {
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
