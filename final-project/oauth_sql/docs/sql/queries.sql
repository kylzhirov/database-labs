-- Basic queries

-- 1) All beatmaps a given OSU user has played (last )
SELECT b.*
FROM user_plays up
JOIN beatmaps b ON b.beatmap_id = up.beatmap_id
WHERE up.osu_user_id = :osu_user_id
ORDER BY up.played_at DESC NULLS LAST
LIMIT 100;

-- 2) Distinct beatmaps ever played by user
SELECT DISTINCT b.beatmap_id, b.title, b.artist, b.version
FROM user_plays up
JOIN beatmaps b ON b.beatmap_id = up.beatmap_id
WHERE up.osu_user_id = :osu_user_id
ORDER BY b.title;


-- Advanced queries

-- A) Top 10 most played beatmaps across all users
SELECT b.title, b.artist, COUNT(*) AS play_count
FROM user_plays up
JOIN beatmaps b ON b.beatmap_id = up.beatmap_id
GROUP BY b.title, b.artist
ORDER BY play_count DESC
LIMIT 10;

-- B) User's accuracy percentiles per day (window function)
WITH plays AS (
  SELECT osu_user_id,
         date_trunc('day', played_at) AS day,
         accuracy
  FROM user_plays
  WHERE osu_user_id = :osu_user_id
)
SELECT day,
       percentile_cont(0.50) WITHIN GROUP (ORDER BY accuracy) AS p50,
       percentile_cont(0.90) WITHIN GROUP (ORDER BY accuracy) AS p90
FROM plays
GROUP BY day
ORDER BY day DESC;

-- C) Recent plays with rank and mods aggregated
SELECT up.played_at,
       b.title,
       b.version,
       up.rank,
       up.mods,
       up.score,
       round(up.accuracy * 100, 2) AS accuracy_percent
FROM user_plays up
JOIN beatmaps b ON b.beatmap_id = up.beatmap_id
WHERE up.osu_user_id = :osu_user_id
ORDER BY up.played_at DESC NULLS LAST
LIMIT 50;


-- Transactions demonstration
BEGIN;
  -- Example: Insert a new beatmap and a play atomically
  INSERT INTO beatmaps (beatmap_id, title, artist, version)
  VALUES (123456, 'Example Title', 'Example Artist', 'Hard')
  ON CONFLICT (beatmap_id) DO UPDATE SET title = EXCLUDED.title;

  INSERT INTO user_plays (osu_user_id, beatmap_id, played_at)
  VALUES (3215, 123456, NOW())
  ON CONFLICT (osu_user_id, beatmap_id, played_at) DO NOTHING;
COMMIT;


-- Index usage examples
-- The following predicates and sort orders use the created indexes:
-- user_plays(osu_user_id)
EXPLAIN ANALYZE SELECT * FROM user_plays WHERE osu_user_id = 3215;
-- user_plays(beatmap_id)
EXPLAIN ANALYZE SELECT * FROM user_plays WHERE beatmap_id = 123456;
-- user_plays(played_at DESC)
EXPLAIN ANALYZE SELECT * FROM user_plays WHERE osu_user_id = 3215 ORDER BY played_at DESC NULLS LAST;
