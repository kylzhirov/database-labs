package com.example.demo.repository;

import com.example.demo.model.Beatmap;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface BeatmapRepository {
    void upsert(Beatmap beatmap) throws SQLException;

    Optional<Beatmap> findById(long beatmapId) throws SQLException;

    List<Beatmap> findByUserPlayed(long osuUserId) throws SQLException;
}
