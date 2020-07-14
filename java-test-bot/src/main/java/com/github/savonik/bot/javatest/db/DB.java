package com.github.savonik.bot.javatest.db;

import entities.Answer;
import entities.Question;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;

/**
 * @author Tatiana Savonik
 */
public class DB {
    
    private static final String URL = Config.getDbUrl();
    private Connection conn;
    
    private Connection getConnection() {
        if (conn == null) {
            try {
                conn = DriverManager.getConnection(URL);
            } catch (SQLException e) {
                throw new IllegalStateException("Failed to connect to DB", e);
            }
        }
        return conn;
    }


    private void createTableUserResult() {
        String query = "CREATE TABLE IF NOT EXISTS user_result(user_id INTEGER, question_id INTEGER, passed INTEGER);";
        createTable(query);
    }

    private void createTableQuestion() {
        String query = "CREATE TABLE IF NOT EXISTS question(id INTEGER primary key, text TEXT, chapter_id INTEGER, comment text);";
        createTable(query);
    }

    private void createTableAnswer() {
        String query = "CREATE TABLE IF NOT EXISTS " +
                "answer(id INTEGER PRIMARY KEY, answer TEXT, question_id INTEGER, valid INTEGER);";
        createTable(query);
    }

    private void createTable(String query) {
        try (Statement stmt = getConnection().createStatement()) {
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void createTableChapter() {
        String query = "CREATE TABLE IF NOT EXISTS " +
                "chapter(id INTEGER PRIMARY KEY, chapter TEXT unique);";
        createTable(query);
    }

    public Question getRandomQuestion() {
        Question randomQuestion = null;
        String sqlQuery = "select id, text, chapter_id, comment from question order by random() limit 1";
        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(sqlQuery)) {
            if (rs.next()) {
                randomQuestion = new Question(rs.getInt("id"), rs.getString("text"),
                        rs.getInt("chapter_id"), rs.getString("comment"));
            }
            return randomQuestion;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Answer> getAnswers(int questionId) {
        String sqlQuery = "select letter, answer, question_id, valid from answer where question_id = ?";
        try (PreparedStatement stmt = getConnection().prepareStatement(sqlQuery)) {
            stmt.setInt(1, questionId);
            ResultSet rs = stmt.executeQuery();
            List<Answer> answers = new ArrayList<>();
            while (rs.next()) {
                Answer answer = new Answer(rs.getString("letter"), rs.getString("answer"),
                        rs.getInt("question_id"), rs.getInt("valid") == 1);
                answers.add(answer);
            }
            rs.close();
            return answers;
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}
