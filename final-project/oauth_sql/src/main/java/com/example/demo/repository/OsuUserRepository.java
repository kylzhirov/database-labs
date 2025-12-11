package com.example.demo.repository;

import com.example.demo.model.OsuUser;

import java.sql.SQLException;
import java.util.Optional;

public interface OsuUserRepository {
    void upsert(OsuUser user) throws SQLException;
    Optional<OsuUser> findById(long osuUserId) throws SQLException;
}
