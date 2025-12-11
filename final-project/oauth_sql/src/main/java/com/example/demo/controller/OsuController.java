package com.example.demo.controller;

import com.example.demo.model.Beatmap;
import com.example.demo.repository.BeatmapRepository;
import com.example.demo.service.OsuService;
import com.example.demo.service.SongService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/osu")
public class OsuController {
    private final OsuService osuService;
    private final BeatmapRepository beatmapRepository;
    private final SongService songService;

    public OsuController(OsuService osuService, BeatmapRepository beatmapRepository, SongService songService) {
        this.osuService = osuService;
        this.beatmapRepository = beatmapRepository;
        this.songService = songService;
    }

    // Example: POST /osu/check  {"command":"o_check beatmaps !user 3215"}
    @PostMapping("/check")
    public ResponseEntity<?> check(@RequestBody Map<String, String> body) {
        String command = body.getOrDefault("command", "");
        try {
            List<Beatmap> beatmaps = osuService.processCommand(command);
            return ResponseEntity.ok(beatmaps);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        } catch (IOException | InterruptedException e) {
            return ResponseEntity.status(502).body(Map.of("error", "Failed to reach OSU API", "details", e.getMessage()));
        } catch (SQLException e) {
            return ResponseEntity.internalServerError().body(Map.of("error", "Database error", "details", e.getMessage()));
        }
    }

    // Cached/local: GET /osu/plays/{osuUserId} returns beatmaps the user played from DB
    @GetMapping("/plays/{osuUserId}")
    public ResponseEntity<?> getPlays(@PathVariable long osuUserId) {
        try {
            List<Beatmap> list = beatmapRepository.findByUserPlayed(osuUserId);
            return ResponseEntity.ok(list);
        } catch (SQLException e) {
            return ResponseEntity.internalServerError().body(Map.of("error", "Database error", "details", e.getMessage()));
        }
    }

    // New: list songs (unique beatmaps) for a user via user_songs junction table
    @GetMapping("/songs/{osuUserId}")
    public ResponseEntity<?> listUserSongs(@PathVariable long osuUserId,
                                           @RequestParam(defaultValue = "50") int limit,
                                           @RequestParam(defaultValue = "0") int offset) {
        try {
            return ResponseEntity.ok(songService.listUserSongs(osuUserId, limit, offset));
        } catch (SQLException e) {
            return ResponseEntity.internalServerError().body(Map.of("error", "Database error", "details", e.getMessage()));
        }
    }

    // New: compare two users' songs
    @GetMapping("/songs/compare")
    public ResponseEntity<?> compareUsers(@RequestParam("u1") long u1,
                                          @RequestParam("u2") long u2,
                                          @RequestParam(defaultValue = "50") int limit,
                                          @RequestParam(defaultValue = "0") int offset) {
        try {
            return ResponseEntity.ok(songService.compareUsers(u1, u2, limit, offset));
        } catch (SQLException e) {
            return ResponseEntity.internalServerError().body(Map.of("error", "Database error", "details", e.getMessage()));
        }
    }
}
