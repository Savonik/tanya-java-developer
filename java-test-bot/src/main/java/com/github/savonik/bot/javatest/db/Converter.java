package com.github.savonik.bot.javatest.db;

public interface Converter<T, E> {

    T convert(E e);

}
