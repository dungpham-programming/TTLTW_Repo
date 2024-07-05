package com.ltw.util;

public class NumberValidateUtil {
    public static boolean isNumeric(String input) {
        try {
            Integer.parseInt(replaceDot(input));
            return true;
        } catch (NumberFormatException n) {
            return false;
        }
    }

    public static int toInt(String input) {
        return Integer.parseInt(replaceDot(input));
    }

    public static double toDouble(String input) {
        return Double.parseDouble(replaceDot(input));
    }

    public static boolean isValidPrice(String input) {
        return toDouble(input) <= 0;
    }

    public static boolean isValidQuantity(String input) {
        return toInt(input) <= 0;
    }
    public static boolean isValidPercent(String input) {
        return toDouble(input) > 0 || toDouble(input) < 100;
    }

    private static String replaceDot(String input) {
        return input.replace(".", "");
    }
}
