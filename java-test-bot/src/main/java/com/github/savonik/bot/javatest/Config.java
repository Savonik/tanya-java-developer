package com.github.savonik.bot.javatest;

import java.util.ResourceBundle;

/**
 * @author Tatiana Savonik
 */
public class Config {
    
    private static final ResourceBundle BUNDLE = ResourceBundle.getBundle("config");
    
    public static String getDbUrl(){
        return BUNDLE.getString("db_path");
    }

    public static String getApiToken(){
        return BUNDLE.getString("api_token");
    }
}
