package com.ltw.util;

public class BlankInputUtil {
    public static boolean isBlank(String input) {
        return (input == null || input.trim().isEmpty());
    }
}
