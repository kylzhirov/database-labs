package com.example.demo.repository;

import com.example.demo.model.Beatmap;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

public interface UserSongRepository {
    void insertIfNotExists(long userId, long songId, LocalDateTime addedAt) throws SQLException;

    List<Beatmap> findSongsByUser(long userId, int limit, int offset) throws SQLException;

    List<Beatmap> findCommonSongs(long userId1, long userId2, int limit, int offset) throws SQLException;

    int countSongsByUser(long userId) throws SQLException;

    int countCommonSongs(long userId1, long userId2) throws SQLException;
}
