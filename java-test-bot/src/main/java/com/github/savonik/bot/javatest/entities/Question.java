package com.github.savonik.bot.javatest.entities;

import com.github.savonik.bot.javatest.db.Column;
import com.github.savonik.bot.javatest.db.ID;
import com.github.savonik.bot.javatest.db.Table;

/**
 * @author Tatiana Savonik
 */
@Table("Question")
public class Question {
    @Column("id")
    @ID
    private int id;
    @Column("text")
    private String text;
    @Column("chapter_id")
    private int chapterId;
    @Column("comment")
    private String comment;

    public Question() {
    }

    public Question(int id, String text, int chapterId, String comment) {
        this.id = id;
        this.text = text;
        this.chapterId = chapterId;
        this.comment = comment;
    }

    public int getId() {
        return id;
    }

    public String getText() {
        return text;
    }

    public int getChapterId() {
        return chapterId;
    }

    public String getComment() {
        return comment;
    }
}
