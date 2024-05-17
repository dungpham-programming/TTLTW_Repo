package com.ltw.dao.intf;

import java.util.List;

public interface IDaoNonUpdate<T> {
    List<T> getAll();
    int create(T t);
    int delete(int[] ids);
}
