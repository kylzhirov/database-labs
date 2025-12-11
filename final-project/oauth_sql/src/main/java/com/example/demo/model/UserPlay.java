package com.example.demo.model;

import java.time.LocalDateTime;

public class UserPlay {
    private long playId;
    private long osuUserId;
    private long beatmapId;
    private LocalDateTime playedAt;
    private Long score;
    private Double accuracy;
    private Integer maxCombo;
    private String rank;
    private String mods;

    public long getPlayId() {
        return playId;
    }

    public void setPlayId(long playId) {
        this.playId = playId;
    }

    public long getOsuUserId() {
        return osuUserId;
    }

    public void setOsuUserId(long osuUserId) {
        this.osuUserId = osuUserId;
    }

    public long getBeatmapId() {
        return beatmapId;
    }

    public void setBeatmapId(long beatmapId) {
        this.beatmapId = beatmapId;
    }

    public LocalDateTime getPlayedAt() {
        return playedAt;
    }

    public void setPlayedAt(LocalDateTime playedAt) {
        this.playedAt = playedAt;
    }

    public Long getScore() {
        return score;
    }

    public void setScore(Long score) {
        this.score = score;
    }

    public Double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(Double accuracy) {
        this.accuracy = accuracy;
    }

    public Integer getMaxCombo() {
        return maxCombo;
    }

    public void setMaxCombo(Integer maxCombo) {
        this.maxCombo = maxCombo;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public String getMods() {
        return mods;
    }

    public void setMods(String mods) {
        this.mods = mods;
    }
}
