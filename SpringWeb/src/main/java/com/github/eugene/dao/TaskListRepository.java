package com.github.eugene.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * @author Tatiana Savonik
 */
@Repository
public class TaskListRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Task> findAll() {
        final String query = "SELECT " +
                "task," +
                "name," +
                "done," +
                "deadline_date " +
                "FROM task_list";

        return jdbcTemplate.query(query, (rs, i) -> new Task(
                rs.getInt("task"),
                rs.getString("name"),
                rs.getBoolean("done"),
                new Date(rs.getDate("deadline_date").getTime())
        ));
    }
}
