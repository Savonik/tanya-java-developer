package com.github.savonik.bot.javatest;

import com.github.savonik.bot.javatest.db.DB;

/**
 * @author Tatiana Savonik
 */
public class App {
    public static void main(String[] args) {
        DB db = new DB(Config.getDbUrl());
        JavaTestBot bot = new JavaTestBot(Config.getApiToken(), db);
        bot.run();
    }
}
