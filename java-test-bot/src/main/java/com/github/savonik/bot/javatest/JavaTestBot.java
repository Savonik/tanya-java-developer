package com.github.savonik.bot.javatest;

import com.github.savonik.bot.javatest.db.DB;
import com.github.savonik.bot.javatest.entities.CallBackAnswer;
import com.github.savonik.bot.javatest.entities.CurrentUserQuestion;
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
import com.pengrad.telegrambot.response.SendResponse;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

class JavaTestBot {

    private static final String SUBMIT_EXPRESSION = "☑ SUBMIT";

    private static final String EMOJI_FINGER_UP = "\uD83D\uDC46";
    private static final String SELECT_ANSWER_OPTION = "Please select at least 1 option " + EMOJI_FINGER_UP;

    private static final String EMOJI_HAPPY_SMILE = "\uD83D\uDE0D";
    private static final String CORRECT_ANSWER = EMOJI_HAPPY_SMILE + " Correct answer!";

    private static final String EMOJI_CRYING_SMILE = "\uD83D\uDE25";
    private static final String TRY_AGAIN = "You have 1 more attempt ";
    private static final String NOT_CORRECT_ANSWER = EMOJI_CRYING_SMILE + " Answer isn't correct. ";

    private static final String EMOJI_FINGER_RIGHT = "\uD83D\uDC49";
    private static final String CHOSEN_ANSWER = EMOJI_FINGER_RIGHT + "  ";

    private static final String EMOJI_FINGER_DOWN = "\uD83D\uDC47";
    private static final String EMOJI_WORKING = "\uD83D\uDC69\uD83C\uDFFD\u200D\uD83D\uDCBB";
    private static final String NEXT_QUESTION_SUBMIT = "Next question " + EMOJI_WORKING;

    private static final String EXPLANATION = "Explanation:";

    private final TelegramBot bot;
    private final DB db;

    private final Map<Integer, CurrentUserQuestion> usersAnswers = new ConcurrentHashMap<>();

    protected JavaTestBot(String apiToken, DB db) {
        if (apiToken == null || apiToken.isEmpty()) {
            throw new IllegalArgumentException("ApiToken cannot be empty or null");
        }
        if (db == null) {
            throw new IllegalArgumentException("DB cannot be null");
        }

        this.bot = new TelegramBot(apiToken);
        this.db = db;
    }

    protected void run() {
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
            sendNewQuestion(userId);
        }
    }

    private void sendNewQuestion(int userId) {
        Question question = db.getRandom(Question.class);
        List<Answer> answers = db.getAll(Answer.class, question.getId());
        String msg = getQuizMsg(question, answers);

        SendResponse response = bot.execute(new SendMessage(userId, msg).parseMode(ParseMode.HTML)
                .replyMarkup(getAnswerButtons(question.getId(), answers)));

        if (!response.isOk()) {
            throw new IllegalStateException("Bad request: " + response.description() + "\n QUESTION ID: " + question.getId());
        }
        int lastMessageId = response.message().messageId();
        usersAnswers.putIfAbsent(userId, new CurrentUserQuestion(lastMessageId, question, answers));
    }

    private void processCallBack(CallbackQuery callbackQuery) {
        int userId = callbackQuery.from().id();
        int messageId = callbackQuery.message().messageId();

        if (usersAnswers.get(userId) != null && messageId != usersAnswers.get(userId).getMessageId()) {
            return;
        }

        String callbackData = callbackQuery.data();

        if (NEXT_QUESTION_SUBMIT.equals(callbackData)) {
            sendNewQuestion(userId);
            return;
        }
        
        CallBackAnswer answerCallBack = CallBackAnswer.fromJSON(callbackData);
        String answer = answerCallBack.getAnswer();
        String questionId = answerCallBack.getQuestionId();

        if (SUBMIT_EXPRESSION.equals(answer)) {
            processSubmitCallback(userId);
            return;
        }

        if (usersAnswers.get(userId) != null) {
            updateAnswers(usersAnswers.get(userId), answerCallBack);
            bot.execute(new EditMessageReplyMarkup(userId, messageId)
                    .replyMarkup(getAnswerButtons(Integer.parseInt(questionId), usersAnswers.get(userId).getAnswers(),
                            usersAnswers.get(userId).getUserAnswers())));
        }
    }

    private void processSubmitCallback(int userId) {
        CurrentUserQuestion userAnswers = usersAnswers.get(userId);

        if (sendEmptyResult(userId, userAnswers)) {
            return;
        }

        sendResult(userAnswers, userId);

        if (isCorrectAnswers(userAnswers) || userAnswers.getHaveIncorrectAnswer()) {
            bot.execute(new SendMessage(userId, EXPLANATION + "\n\n" + userAnswers.getComment()).parseMode(ParseMode.HTML).replyMarkup(getNewQuestionButtons()));
            usersAnswers.remove(userId);
        } else {
            userAnswers.setHaveIncorrectAnswer();
        }
    }

    private boolean sendEmptyResult(int userId, CurrentUserQuestion userAnswers) {
        if (userAnswers == null || userAnswers.getUserAnswers() == null || userAnswers.getUserAnswers().isEmpty()) {
            bot.execute(new SendMessage(userId, SELECT_ANSWER_OPTION));
            return true;
        }
        return false;
    }

    private void updateAnswers(CurrentUserQuestion selectedAnswers, CallBackAnswer newAnswer) {
        for (String backAnswer : selectedAnswers.getUserAnswers()) {
            if (backAnswer.equals(newAnswer.getAnswer())) {
                selectedAnswers.removeAnswer(backAnswer);
                return;
            }
        }
        selectedAnswers.addAnswer(newAnswer.getAnswer());
    }

    private InlineKeyboardMarkup getAnswerButtons(int questionId, List<Answer> answers) {
        return getAnswerButtons(questionId, answers, new ArrayList<String>());
    }

    private InlineKeyboardMarkup getAnswerButtons(int questionId, List<Answer> answers, List<String> userAnswers) {
        final int cols = 2;
        int rowsForAnswers = answers.size() / cols + (answers.size() % cols == 0 ? 0 : 1);
        boolean submitInSeparateRow = answers.size() % cols == 0;

        InlineKeyboardButton[][] buttons = new InlineKeyboardButton[rowsForAnswers + (submitInSeparateRow ? 1 : 0)][cols];
        int answersIndex = 0;
        for (int j = 0; j < cols; j++) {
            for (int i = 0; i < rowsForAnswers; i++) {
                String currentLetter = answers.get(answersIndex).getLetter();
                boolean isAnswerSelected = userAnswers.contains(currentLetter);
                String displayedName = isAnswerSelected ? CHOSEN_ANSWER + currentLetter : currentLetter;
                buttons[i][j] = newButton(questionId, displayedName, currentLetter);

                answersIndex++;
                if (answersIndex == answers.size()) {
                    break;
                }
            }
        }

        if (submitInSeparateRow) {
            buttons[buttons.length - 1] = newButtonLine(questionId, SUBMIT_EXPRESSION);
        } else {
            buttons[buttons.length - 1][cols - 1] = newButton(questionId, SUBMIT_EXPRESSION);
        }
        return new InlineKeyboardMarkup(buttons);
    }

    private InlineKeyboardMarkup getNewQuestionButtons() {
        InlineKeyboardButton[] inlineKeyboardButton = new InlineKeyboardButton[]
                {new InlineKeyboardButton(NEXT_QUESTION_SUBMIT).callbackData(NEXT_QUESTION_SUBMIT)};
        return new InlineKeyboardMarkup(inlineKeyboardButton);
    }

    private String getQuizMsg(Question question, List<Answer> answers) {
        StringBuilder msg = new StringBuilder();
        msg.append(question.getText()).append("\n");
        for (Answer answer : answers) {
            msg.append(answer.getLetter()).append(") ").append(answer.getAnswer()).append("\n");
        }
        return msg.toString();
    }

    private void sendResult(CurrentUserQuestion userAnswers, int userId) {
        bot.execute(new SendMessage(userId, isCorrectAnswers(userAnswers) ? CORRECT_ANSWER :
                userAnswers.getHaveIncorrectAnswer() ? NOT_CORRECT_ANSWER : NOT_CORRECT_ANSWER + TRY_AGAIN));
    }

    private boolean isCorrectAnswers(CurrentUserQuestion currentUserQuestion) {
        List<Answer> answers = currentUserQuestion.getAnswers();
        List<Answer> validAnswers = answers.stream().filter(Answer::isValid).collect(Collectors.toList());
        if (validAnswers.size() != currentUserQuestion.getUserAnswers().size()) {
            return false;
        }
        for (Answer answer : validAnswers) {
            if (!currentUserQuestion.getUserAnswers().contains(answer.getLetter())) {
                return false;
            }
        }
        return true;
    }

    private InlineKeyboardButton[] newButtonLine(int questionId, String text) {
        return newButtonLine(questionId, text, text);
    }

    private InlineKeyboardButton newButton(int questionId, String text) {
        return newButtonLine(questionId, text, text)[0];
    }

    private InlineKeyboardButton newButton(int questionId, String text, String callbackText) {
        return newButtonLine(questionId, text, callbackText)[0];
    }

    private InlineKeyboardButton[] newButtonLine(int questionId, String displayedText, String callbackText) {
        CallBackAnswer answerCallBack = new CallBackAnswer();
        answerCallBack.setAnswer(callbackText);
        answerCallBack.setQuestionId(String.valueOf(questionId));
        String callBack = answerCallBack.toJSON();
        return new InlineKeyboardButton[]{new InlineKeyboardButton(displayedText).callbackData(callBack)};
    }
}

