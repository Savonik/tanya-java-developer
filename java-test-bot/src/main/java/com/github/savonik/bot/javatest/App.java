package com.github.savonik.bot.javatest;

import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.UpdatesListener;
import com.pengrad.telegrambot.model.Message;
import com.pengrad.telegrambot.model.Update;
import com.pengrad.telegrambot.request.SendMessage;

public class App {

    public static void main(String[] args) {
        String apiToken = "1389946659:AAG9EkS1VFIaDADyAnQxQV-bFaNCh96dgUQ";
        TelegramBot bot = new TelegramBot(apiToken);
        bot.setUpdatesListener(updates -> {
            for (Update update : updates) {
                Message message = update.message();

                if (message == null) {
                    continue;
                }

                long chatId = message.chat().id();
                String incomeMessage = message.text();
                String outcomeMessage = "Your message was:\n" + incomeMessage;
                bot.execute(new SendMessage(chatId, outcomeMessage));
            }
            return UpdatesListener.CONFIRMED_UPDATES_ALL;
        });
    }
}
