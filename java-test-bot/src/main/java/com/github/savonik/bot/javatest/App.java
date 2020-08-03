package com.github.savonik.bot.javatest;

import com.github.savonik.bot.javatest.db.Config;
import com.github.savonik.bot.javatest.db.DB;
import com.github.savonik.bot.javatest.entities.CallBackAnswer;
import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.UpdatesListener;

import com.pengrad.telegrambot.model.Message;
import com.pengrad.telegrambot.model.Update;
import com.pengrad.telegrambot.model.request.InlineKeyboardButton;
import com.pengrad.telegrambot.model.request.InlineKeyboardMarkup;
import com.pengrad.telegrambot.model.request.ParseMode;
import com.pengrad.telegrambot.request.SendMessage;
import com.github.savonik.bot.javatest.entities.Answer;
import com.github.savonik.bot.javatest.entities.Question;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class App {

    private static final String SUBMIT_EXPRESSION = "☑SUBMIT";
    private static final String SELECT_ANSWER_OPTION = "Please select an answer option \uD83D\uDC46";
    private static final String CORRECT_ANSWER = "✅\uD83D\uDE0D Correct answer!";
    private static final String NOT_CORRECT_ANSWER = "\uD83D\uDE25 Answer isn't correct. Please try again.";
    private static final DB DB = new DB();
    private static final String API_TOKEN = Config.getApiToken();
    private static final TelegramBot BOT = new TelegramBot(API_TOKEN);

    public static void main(String[] args) {

        Map<Integer, List<CallBackAnswer>> usersAnswers = new HashMap<>();

        BOT.setUpdatesListener(updates -> {
            for (Update update : updates) {
                Message message = update.message();

                if (message == null) {
                    int userId = update.callbackQuery().from().id();

                    usersAnswers.putIfAbsent(userId, new ArrayList<>());
                    String callbackData = update.callbackQuery().data();

                    CallBackAnswer answerCallBack = CallBackAnswer.fromJSON(callbackData);
                    String answer = answerCallBack.getAnswer();
                    String questionId = answerCallBack.getQuestionId();

                    if (SUBMIT_EXPRESSION.equals(answer)) {
                        List<String> userAnswers = getUserAnswersByQuestionId(usersAnswers, userId, questionId);
                        sendResult(answerCallBack.getQuestionId(), userAnswers, userId);
                        usersAnswers.remove(userId);
                        continue;
                    }

                    List<CallBackAnswer> answers = usersAnswers.get(userId);

                    if (answers.contains(answerCallBack)) {
                        answers.remove(answerCallBack);
                    } else {
                        answers.add(answerCallBack);
                    }
                    continue;
                }

                int userId = message.from().id();

                Question question = DB.getRandom(Question.class);
                List<Answer> answers = DB.getAll(Answer.class, question.getId());

                String msg = getQuizMsg(question, answers);

                BOT.execute(new SendMessage(userId, msg).parseMode(ParseMode.HTML)
                        .replyMarkup(getAnswerButtons(question, answers)));
            }
            return UpdatesListener.CONFIRMED_UPDATES_ALL;
        });
    }
    

    private static List<String> getUserAnswersByQuestionId(Map<Integer, List<CallBackAnswer>> usersAnswers, int userId, String questionId) {
        List<String> userAnswers = new ArrayList<>();
        for (CallBackAnswer callBackAnswer : usersAnswers.get(userId)) {
            if (callBackAnswer.getQuestionId().equals(questionId)) {
                userAnswers.add(callBackAnswer.getAnswer());
            }
        }
        return userAnswers;
    }

    private static InlineKeyboardMarkup getAnswerButtons(Question question, List<Answer> answers) {
        InlineKeyboardButton[][] buttons = new InlineKeyboardButton[answers.size() + 1][];
        for (int i = 0; i < buttons.length - 1; i++) {
            buttons[i] = newButton(question.getId(), answers.get(i).getLetter());
        }
        buttons[buttons.length - 1] = newButton(question.getId(), SUBMIT_EXPRESSION);
        return new InlineKeyboardMarkup(buttons);
    }

    private static String getQuizMsg(Question question, List<Answer> answers) {
        StringBuilder msg = new StringBuilder();
        msg.append(question.getText()).append("\n");
     
        for (Answer answer : answers) {
            msg.append(answer.getLetter()).append(") ").append(answer.getAnswer()).append("\n");
        }
        return msg.toString();
    }

    private static void sendResult(String questionId, List<String> userAnswers, int userId) {
        if (userAnswers.isEmpty()) {
            BOT.execute(new SendMessage(userId, SELECT_ANSWER_OPTION));
            return;
        }
        BOT.execute(new SendMessage(userId, isCorrectAnswers(questionId, userAnswers) ? CORRECT_ANSWER : NOT_CORRECT_ANSWER));
    }

    private static InlineKeyboardButton[] newButton(int questionId, String answerLetter) {
        CallBackAnswer answerCallBack = new CallBackAnswer();
        answerCallBack.setAnswer(answerLetter);
        answerCallBack.setQuestionId(String.valueOf(questionId));
        String callBack = answerCallBack.toJSON();
        return new InlineKeyboardButton[]{new InlineKeyboardButton(answerLetter).callbackData(callBack)};
    }

    private static boolean isCorrectAnswers(String questionID, List<String> userAnswers) {
        List<Answer> answers = DB.getAll(Answer.class, Integer.parseInt(questionID));
        List<Answer> validAnswers = answers.stream().filter(Answer::isValid).collect(Collectors.toList());
        if (validAnswers.size() != userAnswers.size()) {
            return false;
        }
        for (Answer answer : validAnswers) {
            if (!userAnswers.contains(answer.getLetter())) {
                return false;
            }
        }
        return true;
    }
}

