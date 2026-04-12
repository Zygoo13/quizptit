package com.quizptit.community.entity;

public class ModerationMapper {

    public static ModerationAction map(String status) {
        if (status == null) return ModerationAction.HIDE;

        return switch (status.toUpperCase()) {
            case "VISIBLE" -> ModerationAction.RESTORE;
            case "HIDDEN" -> ModerationAction.HIDE;
            default -> throw new IllegalArgumentException("Invalid status: " + status);
        };
    }
}
