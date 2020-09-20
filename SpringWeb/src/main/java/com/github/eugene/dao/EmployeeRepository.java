package com.github.eugene.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import javax.xml.transform.Result;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@Repository
public class EmployeeRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Employee> findAll() {
        final String query = "SELECT " +
                                "employee_id," +
                                "first_name," +
                                "last_name," +
                                "department_id," +
                                "job_title," +
                                "gender," +
                                "date_of_birth " +
                             "FROM employee";

        return jdbcTemplate.query(query, (rs, i) -> new Employee(
            rs.getLong("employee_id"),
            rs.getString("first_name"),
            rs.getString("last_name"),
            rs.getLong("department_id"),
            rs.getString("job_title"),
            Gender.valueOf(rs.getString("gender")),
            new Date(rs.getDate("date_of_birth").getTime())
        ));
    }

    public Employee findById(Long id) {
        final String query = "SELECT " +
                                "employee_id," +
                                "first_name," +
                                "last_name," +
                                "department_id," +
                                "job_title," +
                                "gender," +
                                "date_of_birth " +
                             "FROM employee " +
                             "WHERE employee_id = ?";

        return jdbcTemplate.query(query, new Object[]{id}, rs -> {
            if (!rs.next()) {
                return null;
            }
            return new Employee(
                    rs.getLong("employee_id"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getLong("department_id"),
                    rs.getString("job_title"),
                    Gender.valueOf(rs.getString("gender")),
                    new Date(rs.getDate("date_of_birth").getTime())
            );
        });
    }

}
