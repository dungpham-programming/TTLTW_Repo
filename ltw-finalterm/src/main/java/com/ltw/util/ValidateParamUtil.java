package com.ltw.util;

public class ValidateParamUtil {
    public static boolean isInteger(String param) {
        if (param == null || param.isEmpty()) {
            return false;
        }
        try {
            Integer.parseInt(param);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isDouble(String param) {
        if (param == null && param.isEmpty()) {
            return false;
        }
        try {
            Double.parseDouble(param);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
