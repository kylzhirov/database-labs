package com.example.demo.model;

public class Beatmap {
    private long beatmapId;
    private Long beatmapsetId;
    private String version;
    private String mode;
    private Double difficultyRating;
    private Integer totalLength;
    private Double bpm;
    private String title;
    private String artist;
    private String creator;

    public long getBeatmapId() {
        return beatmapId;
    }

    public void setBeatmapId(long beatmapId) {
        this.beatmapId = beatmapId;
    }

    public Long getBeatmapsetId() {
        return beatmapsetId;
    }

    public void setBeatmapsetId(Long beatmapsetId) {
        this.beatmapsetId = beatmapsetId;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public Double getDifficultyRating() {
        return difficultyRating;
    }

    public void setDifficultyRating(Double difficultyRating) {
        this.difficultyRating = difficultyRating;
    }

    public Integer getTotalLength() {
        return totalLength;
    }

    public void setTotalLength(Integer totalLength) {
        this.totalLength = totalLength;
    }

    public Double getBpm() {
        return bpm;
    }

    public void setBpm(Double bpm) {
        this.bpm = bpm;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }
}
