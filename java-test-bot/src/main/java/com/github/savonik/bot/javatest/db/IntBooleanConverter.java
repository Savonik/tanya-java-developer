package com.github.savonik.bot.javatest.db;

/**
 * @author Tatiana Savonik
 */
public class IntBooleanConverter implements Converter<Boolean, Integer>{
    @Override
    public Boolean convert(Integer integer) {
        return integer.equals(1) ? Boolean.TRUE : Boolean.FALSE;
    }
}
