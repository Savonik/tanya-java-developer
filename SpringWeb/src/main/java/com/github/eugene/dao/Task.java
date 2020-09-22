package com.github.eugene.dao;

import java.util.Date;

/**
 * @author Tatiana Savonik
 */
public class Task {
    

    int id;
    String name;
    boolean done;
    Date date;

    public Task(int id, String name, boolean done, Date date) {
        this.id = id;
        this.name = name;
        this.done = done;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
