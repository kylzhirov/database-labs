package com.example.demo.model;

import java.time.LocalDateTime;

public class OsuUser {
    private long osuUserId;
    private String username;
    private String countryCode;
    private LocalDateTime lastSyncedAt;

    public OsuUser() {}

    public OsuUser(long osuUserId, String username, String countryCode, LocalDateTime lastSyncedAt) {
        this.osuUserId = osuUserId;
        this.username = username;
        this.countryCode = countryCode;
        this.lastSyncedAt = lastSyncedAt;
    }

    public long getOsuUserId() {
        return osuUserId;
    }

    public void setOsuUserId(long osuUserId) {
        this.osuUserId = osuUserId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public LocalDateTime getLastSyncedAt() {
        return lastSyncedAt;
    }

    public void setLastSyncedAt(LocalDateTime lastSyncedAt) {
        this.lastSyncedAt = lastSyncedAt;
    }
}
