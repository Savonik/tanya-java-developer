package com.github.savonik.bot.javatest.entities;


import com.google.gson.Gson;

/**
 * @author Tatiana Savonik
 */
public class CallBackAnswer {

    private String answer;
    private String questionId;

    public String getAnswer() {
        return answer;
    }

    public String getQuestionId() {
        return questionId;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    public static CallBackAnswer fromJSON(String callbackData) {
        Gson g = new Gson();
        return g.fromJson(callbackData, CallBackAnswer.class);
    }
    
    public String toJSON() {
        Gson g = new Gson();
        return g.toJson(this);
    }
}
