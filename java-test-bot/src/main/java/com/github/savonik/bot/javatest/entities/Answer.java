package com.github.savonik.bot.javatest.entities;

import com.github.savonik.bot.javatest.db.Column;
import com.github.savonik.bot.javatest.db.ID;
import com.github.savonik.bot.javatest.db.IntBooleanConverter;
import com.github.savonik.bot.javatest.db.Table;

/**
 * @author Tatiana Savonik
 */
@Table("Answer")
public class Answer {
    @Column("letter")
    private String letter;
    @Column("answer")
    private String answer;
    @Column("question_id")
    @ID
    private int questionId;
    @Column(value = "valid", convert = IntBooleanConverter.class)
    private boolean valid;

    public Answer() {

    }

    public Answer(String letter, String answer, int questionId, boolean valid) {
        this.letter = letter;
        this.answer = answer;
        this.questionId = questionId;
        this.valid = valid;
    }

    public String getLetter() {
        return letter;
    }

    public String getAnswer() {
        return answer;
    }

    public int getQuestionId() {
        return questionId;
    }

    public boolean isValid() {
        return valid;
    }
}
