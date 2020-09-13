package com.github.savonik.bot.javatest.entities;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Tatiana Savonik
 */
public class CurrentUserQuestion {

    private final int messageId;
    private final String explanation;

    private boolean haveIncorrectAnswer;
    private final List<String> userAnswerLetters = new ArrayList<>();

    private final List<Answer> answers;

    public CurrentUserQuestion(int lastMessageId, Question question, List<Answer> answers) {
        this.messageId = lastMessageId;
        int questionId = question.getId();
        this.explanation = question.getExplanation();
        this.answers = answers;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public boolean getHaveIncorrectAnswer() {
        return haveIncorrectAnswer;
    }

    public int getMessageId() {
        return messageId;
    }

    public String getExplanation() {
        return explanation;
    }

    public List<String> getUserAnswers() {
        return userAnswerLetters;
    }

    public void setHaveIncorrectAnswer() {
        haveIncorrectAnswer = true;
    }

    public void removeAnswer(String answerLetter) {
        userAnswerLetters.remove(answerLetter);
    }

    public void addAnswer(String answerLetter) {
        userAnswerLetters.add(answerLetter);
    }
}
