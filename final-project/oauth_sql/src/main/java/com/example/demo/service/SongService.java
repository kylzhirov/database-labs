package com.example.demo.service;

import com.example.demo.model.Beatmap;
import com.example.demo.repository.UserSongRepository;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SongService {
    private final UserSongRepository userSongRepository;

    public SongService(UserSongRepository userSongRepository) {
        this.userSongRepository = userSongRepository;
    }

    public List<Beatmap> listUserSongs(long userId, int limit, int offset) throws SQLException {
        return userSongRepository.findSongsByUser(userId, limit, offset);
    }

    public Map<String, Object> compareUsers(long u1, long u2, int limit, int offset) throws SQLException {
        int c1 = userSongRepository.countSongsByUser(u1);
        int c2 = userSongRepository.countSongsByUser(u2);
        int common = userSongRepository.countCommonSongs(u1, u2);
        double jaccard = (c1 + c2 - common) == 0 ? 0.0 : (double) common / (double) (c1 + c2 - common);
        List<Beatmap> commonList = userSongRepository.findCommonSongs(u1, u2, limit, offset);

        Map<String, Object> result = new HashMap<>();
        result.put("user1Count", c1);
        result.put("user2Count", c2);
        result.put("commonCount", common);
        result.put("jaccard", jaccard);
        result.put("commonSongs", commonList);
        return result;
    }
}
