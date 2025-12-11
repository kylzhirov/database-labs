package com.example.demo.repository;

import com.example.demo.model.UserPlay;

import java.sql.SQLException;
import java.util.List;

public interface UserPlayRepository {
    void insertIfNotExists(UserPlay play) throws SQLException;
    List<UserPlay> findByUser(long osuUserId) throws SQLException;
}
