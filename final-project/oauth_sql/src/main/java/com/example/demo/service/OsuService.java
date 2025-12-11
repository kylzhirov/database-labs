package com.example.demo.service;

import com.example.demo.model.Beatmap;
import com.example.demo.model.OsuUser;
import com.example.demo.model.UserPlay;
import com.example.demo.repository.BeatmapRepository;
import com.example.demo.repository.OsuUserRepository;
import com.example.demo.repository.UserPlayRepository;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.sql.SQLException;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class OsuService {
    private final OsuApiClient apiClient;
    private final OsuUserRepository osuUserRepository;
    private final BeatmapRepository beatmapRepository;
    private final UserPlayRepository userPlayRepository;

    private static final Pattern CMD = Pattern.compile("^o_check\\s+(beatmaps|best)\\s+!user\\s+(\\d+)\\s*$", Pattern.CASE_INSENSITIVE);

    public OsuService(OsuApiClient apiClient, OsuUserRepository osuUserRepository, BeatmapRepository beatmapRepository, UserPlayRepository userPlayRepository) {
        this.apiClient = apiClient;
        this.osuUserRepository = osuUserRepository;
        this.beatmapRepository = beatmapRepository;
        this.userPlayRepository = userPlayRepository;
    }

    public List<Beatmap> processCommand(String command) throws IOException, InterruptedException, SQLException {
        Matcher m = CMD.matcher(command == null ? "" : command.trim());
        if (!m.matches()) {
            throw new IllegalArgumentException("Unsupported command. Use: o_check beatmaps !user <id> or o_check best !user <id>");
        }
        String type = m.group(1).toLowerCase();
        long osuUserId = Long.parseLong(m.group(2));
        if ("best".equals(type)) {
            // (API client's max per call)
            return syncUserBestBeatmaps(osuUserId, 50);
        }
        return syncUserRecentBeatmaps(osuUserId, 20);
    }

    public List<Beatmap> syncUserRecentBeatmaps(long osuUserId, int limit) throws IOException, InterruptedException, SQLException {
        JsonNode scores = apiClient.getUserRecentScores(osuUserId, limit);

        // Upsert OSU user with minimal info
        OsuUser user = new OsuUser();
        user.setOsuUserId(osuUserId);
        user.setUsername(null);
        user.setCountryCode(null);
        osuUserRepository.upsert(user);

        List<Beatmap> result = new ArrayList<>();
        for (JsonNode s : scores) {
            JsonNode bmNode = s.path("beatmap");
            long beatmapId = bmNode.path("id").asLong(0);
            if (beatmapId == 0) {
                // Fallback: try nested beatmap id elsewhere
                beatmapId = s.path("beatmap_id").asLong(0);
            }
            Beatmap b = new Beatmap();
            if (beatmapId != 0) {
                // map from node or call API to get details
                b.setBeatmapId(beatmapId);
                if (!bmNode.isMissingNode() && bmNode.size() > 0) {
                    mapBeatmapFromJson(b, bmNode);
                } else {
                    apiClient.getBeatmap(beatmapId).ifPresent(json -> mapBeatmapFromJson(b, json));
                }
                // Enrich missing textual fields (title/artist/creator) if absent on score.beatmap
                if (b.getTitle() == null || b.getArtist() == null || b.getCreator() == null) {
                    apiClient.getBeatmap(beatmapId).ifPresent(json -> mapBeatmapFromJson(b, json));
                }
                beatmapRepository.upsert(b);
                result.add(b);
            }

            // Insert play
            UserPlay p = new UserPlay();
            p.setOsuUserId(osuUserId);
            p.setBeatmapId(beatmapId);
            String endedAt = s.path("ended_at").asText(null);
            if (endedAt == null) endedAt = s.path("created_at").asText(null);
            if (endedAt != null) {
                try {
                    p.setPlayedAt(OffsetDateTime.parse(endedAt).toLocalDateTime());
                } catch (Exception ignore) {
                } // ignore parse errors
            }
            if (s.has("score")) p.setScore(s.path("score").asLong());
            if (s.has("accuracy")) p.setAccuracy(s.path("accuracy").asDouble());
            if (s.has("max_combo")) p.setMaxCombo(s.path("max_combo").asInt());
            p.setRank(s.path("rank").asText(null));

            if (s.has("mods") && s.path("mods").isArray()) {
                StringBuilder mods = new StringBuilder();
                for (JsonNode mod : s.path("mods")) {
                    if (mods.length() > 0) mods.append(',');
                    mods.append(mod.asText());
                }
                p.setMods(mods.toString());
            }
            userPlayRepository.insertIfNotExists(p);
        }
        return result;
    }

    public List<Beatmap> syncUserBestBeatmaps(long osuUserId, int limit) throws IOException, InterruptedException, SQLException {
        JsonNode scores = apiClient.getUserBestScores(osuUserId, limit);

        // Upsert OSU user with minimal info
        OsuUser user = new OsuUser();
        user.setOsuUserId(osuUserId);
        user.setUsername(null);
        user.setCountryCode(null);
        osuUserRepository.upsert(user);

        List<Beatmap> result = new ArrayList<>();
        for (JsonNode s : scores) {
            JsonNode bmNode = s.path("beatmap");
            long beatmapId = bmNode.path("id").asLong(0);
            if (beatmapId == 0) {
                // Fallback: try nested beatmap id elsewhere
                beatmapId = s.path("beatmap_id").asLong(0);
            }
            Beatmap b = new Beatmap();
            if (beatmapId != 0) {
                // map from node or call API to get details
                b.setBeatmapId(beatmapId);
                if (!bmNode.isMissingNode() && bmNode.size() > 0) {
                    mapBeatmapFromJson(b, bmNode);
                } else {
                    apiClient.getBeatmap(beatmapId).ifPresent(json -> mapBeatmapFromJson(b, json));
                }
                // Enrich missing textual fields if absent
                if (b.getTitle() == null || b.getArtist() == null || b.getCreator() == null) {
                    apiClient.getBeatmap(beatmapId).ifPresent(json -> mapBeatmapFromJson(b, json));
                }
                beatmapRepository.upsert(b);
                result.add(b);
            }

            // Insert play
            UserPlay p = new UserPlay();
            p.setOsuUserId(osuUserId);
            p.setBeatmapId(beatmapId);
            String endedAt = s.path("ended_at").asText(null);
            if (endedAt == null) endedAt = s.path("created_at").asText(null);
            if (endedAt != null) {
                try {
                    p.setPlayedAt(OffsetDateTime.parse(endedAt).toLocalDateTime());
                } catch (Exception ignore) { /* ignore parse errors */ }
            }
            if (s.has("score")) p.setScore(s.path("score").asLong());
            if (s.has("accuracy")) p.setAccuracy(s.path("accuracy").asDouble());
            if (s.has("max_combo")) p.setMaxCombo(s.path("max_combo").asInt());
            p.setRank(s.path("rank").asText(null));
            // mods is an array of strings
            if (s.has("mods") && s.path("mods").isArray()) {
                StringBuilder mods = new StringBuilder();
                for (JsonNode mod : s.path("mods")) {
                    if (mods.length() > 0) mods.append(',');
                    mods.append(mod.asText());
                }
                p.setMods(mods.toString());
            }
            userPlayRepository.insertIfNotExists(p);
        }
        return result;
    }

    private static void mapBeatmapFromJson(Beatmap b, JsonNode bm) {
        if (bm == null) return;
        if (bm.has("id")) b.setBeatmapId(bm.path("id").asLong());
        if (bm.has("beatmapset_id"))
            b.setBeatmapsetId(bm.path("beatmapset_id").isNull() ? null : bm.path("beatmapset_id").asLong());
        b.setVersion(bm.path("version").asText(null));
        b.setMode(bm.path("mode").asText(null));
        if (bm.has("difficulty_rating"))
            b.setDifficultyRating(bm.path("difficulty_rating").isNumber() ? bm.path("difficulty_rating").asDouble() : null);
        if (bm.has("total_length"))
            b.setTotalLength(bm.path("total_length").isInt() ? bm.path("total_length").asInt() : null);
        if (bm.has("bpm")) b.setBpm(bm.path("bpm").isNumber() ? bm.path("bpm").asDouble() : null);

        if (bm.has("beatmapset") && bm.path("beatmapset").isObject()) {
            JsonNode bs = bm.path("beatmapset");
            b.setTitle(bs.path("title").asText(null));
            b.setArtist(bs.path("artist").asText(null));
            b.setCreator(bs.path("creator").asText(null));
        }
    }
}
