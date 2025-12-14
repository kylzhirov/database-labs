-- Basic queries

-- Insert user if not exists
INSERT INTO osu_users (osu_user_id, username, country_code, last_synced_at)
VALUES (?, ?, ?, COALESCE(?, CURRENT_TIMESTAMP))
    ON CONFLICT (osu_user_id)
                DO UPDATE SET username = EXCLUDED.username,
                           country_code = EXCLUDED.country_code,
                           last_synced_at = EXCLUDED.last_synced_at

-- Upsert user
INSERT INTO osu_users (osu_user_id, username, country_code, last_synced_at)
VALUES (?, ?, ?, COALESCE(?, CURRENT_TIMESTAMP))
    ON CONFLICT (osu_user_id)
                DO UPDATE SET username = EXCLUDED.username,
                           country_code = EXCLUDED.country_code,
                           last_synced_at = EXCLUDED.last_synced_at

-- Advanced queries

-- 1. Count common songs
SELECT COUNT(*)
FROM user_songs u1
         JOIN user_songs u2 ON u2.song_id = u1.song_id
WHERE u1.user_id = ? AND u2.user_id = ?

-- 2. Last 100 songs played by a user (ordered by playtime)
SELECT b.*
FROM user_plays up
         JOIN beatmaps b ON b.beatmap_id = up.beatmap_id
WHERE up.osu_user_id = ?
ORDER BY up.played_at DESC NULLS LAST
    LIMIT 100;

-- 3. Find songs by user
SELECT b.*
FROM user_songs us
         JOIN beatmaps b ON b.beatmap_id = us.song_id
WHERE us.user_id = ?
ORDER BY us.added_at DESC NULLS LAST
    LIMIT ? OFFSET ?


-- 4. Transactions

-- All transaction are managed by JDBC auto-commit
-- each executeUpdate() runs in its own transaction
-- example:

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
