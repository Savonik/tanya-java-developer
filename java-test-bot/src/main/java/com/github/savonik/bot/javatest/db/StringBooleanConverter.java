package com.github.savonik.bot.javatest.db;

public class StringBooleanConverter implements Converter<Boolean, String> {
    @Override
    public Boolean convert(String s) {
        return "T".equals(s) ? Boolean.TRUE : Boolean.FALSE;
    }
}
