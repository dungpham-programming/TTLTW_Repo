package com.ltw.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class TransferDataUtil<T> {
    public String toJson(T model) {
        // Builder serializeNulls để parse cả các trường null
        Gson gson = new GsonBuilder().serializeNulls().create();
        return gson.toJson(model);
    }
}
