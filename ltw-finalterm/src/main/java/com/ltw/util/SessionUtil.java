package com.ltw.util;

import javax.servlet.http.HttpServletRequest;

public class SessionUtil {
    private static SessionUtil session;

    public static SessionUtil getInstance() {
        if (session == null) {
            session = new SessionUtil();
        }
        return session;
    }

    public void putValue(HttpServletRequest req, String key, Object value) {
        req.getSession().setAttribute(key, value);
    }

    public Object getValue(HttpServletRequest req, String key) {
        return req.getSession().getAttribute(key);
    }

    public void removeValue(HttpServletRequest req, String key) {
        req.getSession().removeAttribute(key);
    }
}
