package com.github.savonik.bot.javatest.db;

public class NoConverter implements Converter {
    @Override
    public Object convert(Object o) {
        return o;
    }
}
