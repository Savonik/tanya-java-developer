package app;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public class DB {

    private static final String URL = "jdbc:postgresql://localhost/mydb";
    private Connection conn;
    private Connection getConnection() {
        if (conn == null) {

            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }

            try {
                conn = DriverManager.getConnection(URL, "postgres", "savonik1993");
            } catch (SQLException e) {
                throw new IllegalStateException("Failed to connect to app.DB", e);
            }
        }
        return conn;
    }

    public DB() {
        String query = "CREATE TABLE IF NOT EXISTS task_list(task serial primary key, name varchar(50) NOT NULL," +
                "done boolean NOT NULL DEFAULT false, deadline_date date NOT NULL DEFAULT now());";
        try (Statement stmt = getConnection().createStatement()) {
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected int createToDoTask(String nameOfTask) {
        String sqlQuery = "INSERT INTO task_list(name) VALUES (?) RETURNING task";
        try (PreparedStatement stmt = getConnection().prepareStatement(sqlQuery)) {
            stmt.setString(1, nameOfTask);
            ResultSet rs = stmt.executeQuery();
            int numberTask = 0;
            if (rs.next()) {
                numberTask = rs.getInt("task");
            }
            return numberTask;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            return 0;
        }
    }

    public int createToDoTask(String nameOfTask, Date date) {
        String sqlQuery = "INSERT INTO task_list(name, deadline_date) VALUES (?,?) RETURNING task";
        try (PreparedStatement stmt = getConnection().prepareStatement(sqlQuery)) {
            stmt.setString(1, nameOfTask);
            stmt.setDate(2, new java.sql.Date(date.getTime()));
            ResultSet rs = stmt.executeQuery();
            int numberTask = 0;
            if (rs.next()) {
                numberTask = rs.getInt("task");
            }
            rs.close();
            return numberTask;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            return 0;
        }
    }

    protected int markAsDone(int numberOfTask) {
        String query = "UPDATE task_list SET done = TRUE WHERE not done AND task = ?";
        try (PreparedStatement stmt = getConnection().prepareStatement(query)) {
            stmt.setInt(1, numberOfTask);
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    protected List<Task> getNotDone() {
        return getTasks("SELECT task, name, done, deadline_date FROM task_list WHERE not done");
    }

    protected List<Task> getDone() {
        return getTasks("SELECT task, name, done, deadline_date FROM task_list WHERE done ORDER BY task");
    }

    public List<Task> getAll() {
        return getTasks("SELECT task, name, done, deadline_date FROM task_list ORDER BY task");
    }

    protected List<Task> getToDoToday() {
        return getTasks("SELECT task, name, done, deadline_date FROM task_list " +
                "WHERE deadline_date <= now() AND not done ORDER BY task");
    }

    private List<Task> getTasks(String sqlQuery) {
        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(sqlQuery)) {
            List<Task> tasks = new ArrayList<>();
            while (rs.next()) {
                Task task = new Task(rs.getInt("task"), rs.getString("name"),
                        rs.getBoolean("done"), rs.getDate("deadline_date"));
                tasks.add(task);
            }
            rs.close();
            return tasks;
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}
        
