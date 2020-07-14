package com.github.savonik.bot.javatest;

import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.UpdatesListener;
import com.pengrad.telegrambot.model.Message;
import com.pengrad.telegrambot.model.Update;
import com.pengrad.telegrambot.model.request.InlineKeyboardButton;
import com.pengrad.telegrambot.model.request.InlineKeyboardMarkup;
import com.pengrad.telegrambot.model.request.ParseMode;
import com.pengrad.telegrambot.request.SendMessage;
import entities.Answer;
import com.github.savonik.bot.javatest.db.DB;
import entities.Question;

import java.util.List;


public class App {

    public static void main(String[] args) {

        DB db = new DB();

        String apiToken = "1389946659:AAG9EkS1VFIaDADyAnQxQV-bFaNCh96dgUQ";
        TelegramBot bot = new TelegramBot(apiToken);
        bot.setUpdatesListener(updates -> {
            for (Update update : updates) {
                Message message = update.message();

                if (message == null) {
                    continue;
                }

                long chatId = message.chat().id();

                Question question = db.getRandomQuestion();
                List<Answer> answers = db.getAnswers(question.getId());

                StringBuilder msg = new StringBuilder();
                msg.append(question.getText()).append("\n");
                for (Answer answer : answers) {
                    msg.append(answer.getLetter()).append(") ").append(answer.getAnswer()).append("\n");
                }

                InlineKeyboardButton[][] buttons = new InlineKeyboardButton[answers.size()][];

                for (int i = 0; i < buttons.length; i++) {
                    buttons[i] = newButton(question.getId(), answers.get(i).getLetter());
                }
                InlineKeyboardMarkup markupButtons = new InlineKeyboardMarkup(buttons);
                bot.execute(new SendMessage(chatId, msg.toString()).parseMode(ParseMode.HTML).replyMarkup(markupButtons));

            }
            return UpdatesListener.CONFIRMED_UPDATES_ALL;
        });
    }

    private static InlineKeyboardButton[] newButton(int questionId, String answerLetter) {
        return new InlineKeyboardButton[]{new InlineKeyboardButton(answerLetter).callbackData(questionId + " " + answerLetter)};
    }
    
}
