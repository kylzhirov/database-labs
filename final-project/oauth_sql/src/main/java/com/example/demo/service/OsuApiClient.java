package com.example.demo.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Optional;

@Component
public class OsuApiClient {
    private final HttpClient http = HttpClient.newHttpClient();
    private final ObjectMapper mapper = new ObjectMapper();

    @Value("${osu.api.base:https://osu.ppy.sh/api/v2}")
    private String apiBase;

    @Value("${osu.oauth.token:https://osu.ppy.sh/oauth/token}")
    private String tokenUrl;

    @Value("${osu.client.id:}")
    private String clientId;

    @Value("${osu.client.secret:}")
    private String clientSecret;

    private volatile String cachedToken;
    private volatile long tokenExpiresAt = 0L;

    private String getAccessToken() throws IOException, InterruptedException {
        long now = System.currentTimeMillis();
        if (cachedToken != null && now < tokenExpiresAt - 10_000) {
            return cachedToken;
        }

        if (clientId == null || clientId.isBlank() || clientSecret == null || clientSecret.isBlank()) {
            throw new IllegalStateException("OSU API credentials are not configured (osu.client.id / osu.client.secret)");
        }

        String body = "client_id=" + URLEncoder.encode(clientId, StandardCharsets.UTF_8) +
                "&client_secret=" + URLEncoder.encode(clientSecret, StandardCharsets.UTF_8) +
                "&grant_type=client_credentials&scope=public";
        HttpRequest req = HttpRequest.newBuilder(URI.create(tokenUrl))
                .timeout(Duration.ofSeconds(20))
                .header("Content-Type", "application/x-www-form-urlencoded")
                .POST(HttpRequest.BodyPublishers.ofString(body))
                .build();
        HttpResponse<String> resp = http.send(req, HttpResponse.BodyHandlers.ofString());
        if (resp.statusCode() >= 200 && resp.statusCode() < 300) {
            JsonNode json = mapper.readTree(resp.body());
            this.cachedToken = json.path("access_token").asText();
            int expires = json.path("expires_in").asInt(3600);
            this.tokenExpiresAt = System.currentTimeMillis() + expires * 1000L;
            return cachedToken;
        }
        throw new IOException("Failed to obtain OSU token: HTTP " + resp.statusCode() + " body=" + resp.body());
    }

    public JsonNode getUserRecentScores(long osuUserId, int limit) throws IOException, InterruptedException {
        String token = getAccessToken();
        String url = apiBase + "/users/" + osuUserId + "/scores/recent?include_fails=1&limit=" + Math.min(Math.max(limit, 1), 50);
        HttpRequest req = HttpRequest.newBuilder(URI.create(url))
                .timeout(Duration.ofSeconds(20))
                .header("Authorization", "Bearer " + token)
                .GET()
                .build();
        HttpResponse<String> resp = http.send(req, HttpResponse.BodyHandlers.ofString());
        if (resp.statusCode() >= 200 && resp.statusCode() < 300) {
            return mapper.readTree(resp.body());
        }
        throw new IOException("Failed to fetch recent scores: HTTP " + resp.statusCode() + " body=" + resp.body());
    }

    public Optional<JsonNode> getBeatmap(long beatmapId) throws IOException, InterruptedException {
        String token = getAccessToken();
        String url = apiBase + "/beatmaps/" + beatmapId;
        HttpRequest req = HttpRequest.newBuilder(URI.create(url))
                .timeout(Duration.ofSeconds(20))
                .header("Authorization", "Bearer " + token)
                .GET()
                .build();
        HttpResponse<String> resp = http.send(req, HttpResponse.BodyHandlers.ofString());
        if (resp.statusCode() == 404) return Optional.empty();
        if (resp.statusCode() >= 200 && resp.statusCode() < 300) {
            return Optional.of(mapper.readTree(resp.body()));
        }
        throw new IOException("Failed to fetch beatmap: HTTP " + resp.statusCode() + " body=" + resp.body());
    }

    public JsonNode getUserBestScores(long osuUserId, int limit) throws IOException, InterruptedException {
        String token = getAccessToken();
        String url = apiBase + "/users/" + osuUserId + "/scores/best?limit=" + Math.min(Math.max(limit, 1), 50);
        HttpRequest req = HttpRequest.newBuilder(URI.create(url))
                .timeout(Duration.ofSeconds(20))
                .header("Authorization", "Bearer " + token)
                .GET()
                .build();
        HttpResponse<String> resp = http.send(req, HttpResponse.BodyHandlers.ofString());
        if (resp.statusCode() >= 200 && resp.statusCode() < 300) {
            return mapper.readTree(resp.body());
        }
        throw new IOException("Failed to fetch best scores: HTTP " + resp.statusCode() + " body=" + resp.body());
    }
}
