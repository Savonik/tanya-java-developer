package com.github.savonik.bot.javatest;

import com.github.savonik.bot.javatest.db.DB;
import com.github.savonik.bot.javatest.entities.CallBackAnswer;
import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.UpdatesListener;

import com.pengrad.telegrambot.model.CallbackQuery;
import com.pengrad.telegrambot.model.Message;
import com.pengrad.telegrambot.model.Update;
import com.pengrad.telegrambot.model.request.InlineKeyboardButton;
import com.pengrad.telegrambot.model.request.InlineKeyboardMarkup;
import com.pengrad.telegrambot.model.request.ParseMode;
import com.pengrad.telegrambot.request.EditMessageReplyMarkup;
import com.pengrad.telegrambot.request.SendMessage;
import com.github.savonik.bot.javatest.entities.Answer;
import com.github.savonik.bot.javatest.entities.Question;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

public class JavaTestBot {

    private static final String SUBMIT_EXPRESSION = "☑SUBMIT";

    private static final String EMOJI_FINGER_UP = "\uD83D\uDC46";
    private static final String SELECT_ANSWER_OPTION = "Please select an answer option " + EMOJI_FINGER_UP;

    private static final String EMOJI_HAPPY_SMILE = "\uD83D\uDE0D";
    private static final String CORRECT_ANSWER = EMOJI_HAPPY_SMILE + " Correct answer!";

    private static final String EMOJI_CRYING_SMILE = "\uD83D\uDE25";
    private static final String NOT_CORRECT_ANSWER = EMOJI_CRYING_SMILE + " Answer isn't correct. Please try again.";

    private static final String EMOJI_FINGER_RIGHT = "\uD83D\uDC49";
    private static final String CHOSEN_ANSWER = EMOJI_FINGER_RIGHT + "  ";

    private final TelegramBot bot;
    private final DB db;

    private Map<Integer, List<CallBackAnswer>> usersAnswers = new ConcurrentHashMap<>();

    public JavaTestBot(String apiToken, DB db) {
        if (apiToken == null || apiToken.isEmpty()) {
            throw new IllegalArgumentException("ApiToken cannot be empty or null");
        }
        if (db == null) {
            throw new IllegalArgumentException("DB cannot be null");
        }

        this.bot = new TelegramBot(apiToken);
        this.db = db;
    }

    public void run() {
        bot.setUpdatesListener(updates -> {
            for (Update update : updates) {
                if (update.callbackQuery() != null) {
                    processCallBack(update.callbackQuery());
                } else if (update.message() != null) {
                    processMsg(update.message());
                }
            }
            return UpdatesListener.CONFIRMED_UPDATES_ALL;
        });
    }

    private void processMsg(Message message) {
        if ("/start".equals(message.text())) {
            int userId = message.from().id();

            Question question = db.getRandom(Question.class);
            List<Answer> answers = db.getAll(Answer.class, question.getId());

            String msg = getQuizMsg(question, answers);

            bot.execute(new SendMessage(userId, msg).parseMode(ParseMode.HTML)
                    .replyMarkup(getAnswerButtons(question, answers)));
        }
    }

    private void processCallBack(CallbackQuery callbackQuery) {
        int userId = callbackQuery.from().id();
        int messageId = callbackQuery.message().messageId();

        usersAnswers.putIfAbsent(userId, new ArrayList<>());
        String callbackData = callbackQuery.data();

        CallBackAnswer answerCallBack = CallBackAnswer.fromJSON(callbackData);
        String answer = answerCallBack.getAnswer();
        String questionId = answerCallBack.getQuestionId();

        if (SUBMIT_EXPRESSION.equals(answer)) {
            List<CallBackAnswer> userAnswers = usersAnswers.get(userId);
            List<String> userAnswersByQuestionId = getUserAnswersByQuestionId(userAnswers, questionId);
            sendResult(answerCallBack.getQuestionId(), userAnswersByQuestionId, userId);
            //TODO SEND NEW QUESTION
            usersAnswers.remove(userId);
            return;
        }

        List<CallBackAnswer> selectedAnswers = usersAnswers.get(userId);
        List<CallBackAnswer> newSelectedAnswers = getAnswers(selectedAnswers, answerCallBack);

        bot.execute(new EditMessageReplyMarkup(userId, messageId)
                .replyMarkup(getPointedButtons(Integer.parseInt(questionId), newSelectedAnswers)));
    }

    private List<CallBackAnswer> getAnswers(List<CallBackAnswer> selectedAnswers, CallBackAnswer newAnswer) {
        for (CallBackAnswer backAnswer : selectedAnswers) {
            if (backAnswer.equals(newAnswer)) {
                selectedAnswers.remove(backAnswer);
                return selectedAnswers;
            }
        }
        selectedAnswers.add(newAnswer);
        return selectedAnswers;
    }

    private InlineKeyboardMarkup getPointedButtons(int questionId, List<CallBackAnswer> userAnswers) {
        List<Answer> answers = db.getAll(Answer.class, questionId);
        InlineKeyboardButton[][] buttons = new InlineKeyboardButton[answers.size() + 1][];
        for (int i = 0; i < buttons.length - 1; i++) {
            boolean pointedAnswer = false;
            for (CallBackAnswer callBackAnswer : userAnswers) {
                if (callBackAnswer.getAnswer().contains(answers.get(i).getLetter())) {
                    pointedAnswer = true;
                    break;
                }
            }
            String displayedName = pointedAnswer ? CHOSEN_ANSWER + answers.get(i).getLetter() : answers.get(i).getLetter();
            buttons[i] = newButton(questionId, displayedName, answers.get(i).getLetter());
        }
        buttons[buttons.length - 1] = newButton(questionId, SUBMIT_EXPRESSION);
        return new InlineKeyboardMarkup(buttons);
    }

    private InlineKeyboardMarkup getAnswerButtons(Question question, List<Answer> answers) {
        InlineKeyboardButton[][] buttons = new InlineKeyboardButton[answers.size() + 1][];
        for (int i = 0; i < buttons.length - 1; i++) {
            buttons[i] = newButton(question.getId(), answers.get(i).getLetter());
        }
        buttons[buttons.length - 1] = newButton(question.getId(), SUBMIT_EXPRESSION);
        return new InlineKeyboardMarkup(buttons);
    }

    private List<String> getUserAnswersByQuestionId(List<CallBackAnswer> usersAnswers, String questionId) {
        List<String> userAnswers = new ArrayList<>();
        for (CallBackAnswer callBackAnswer : usersAnswers) {
            if (callBackAnswer.getQuestionId().equals(questionId)) {
                userAnswers.add(callBackAnswer.getAnswer());
            }
        }
        return userAnswers;
    }

    private String getQuizMsg(Question question, List<Answer> answers) {
        StringBuilder msg = new StringBuilder();
        msg.append(question.getText()).append("\n");

        for (Answer answer : answers) {
            msg.append(answer.getLetter()).append(") ").append(answer.getAnswer()).append("\n");
        }
        return msg.toString();
    }

    private void sendResult(String questionId, List<String> userAnswers, int userId) {
        if (userAnswers.isEmpty()) {
            bot.execute(new SendMessage(userId, SELECT_ANSWER_OPTION));
            return;
        }
        bot.execute(new SendMessage(userId, isCorrectAnswers(questionId, userAnswers) ?
                CORRECT_ANSWER : NOT_CORRECT_ANSWER));
    }

    private InlineKeyboardButton[] newButton(int questionId, String text) {
        return newButton(questionId, text, text);
    }

    private InlineKeyboardButton[] newButton(int questionId, String displayedText, String callbackText) {
        CallBackAnswer answerCallBack = new CallBackAnswer();
        answerCallBack.setAnswer(callbackText);
        answerCallBack.setQuestionId(String.valueOf(questionId));
        String callBack = answerCallBack.toJSON();
        return new InlineKeyboardButton[]{new InlineKeyboardButton(displayedText).callbackData(callBack)};
    }

    private boolean isCorrectAnswers(String questionID, List<String> userAnswers) {
        List<Answer> answers = db.getAll(Answer.class, Integer.parseInt(questionID));
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

