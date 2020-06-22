import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class DB {

    private static final String URL = "jdbc:postgresql://localhost/mydb?user=postgres&password=savonik1993";
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

    protected DB() {
        String query = "CREATE TABLE IF NOT EXISTS task_list(task serial primary key, name varchar(50) not null," +
                "done boolean not null default false);";
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
            while (rs.next()) {
                numberTask = rs.getInt("task");
            }
            return numberTask;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            return 0;
        }
    }

    protected int markAsDone(int numberOfTask) {
        String query = "UPDATE task_list set done = true where not done and task = ?";
        try (PreparedStatement stmt = getConnection().prepareStatement(query)) {
            stmt.setInt(1, numberOfTask);
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    protected List<String[]> showList() {
        return runSqlQueryWithRS("select task, name from task_list where not done");
    }

    protected List<String[]> showListOfDone() {
        return runSqlQueryWithRS("select task, name from task_list where done order by task");
    }

    protected List<String[]> runSqlQueryWithRS(String sqlQuery) {
        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(sqlQuery)) {
            ResultSetMetaData rsmd = rs.getMetaData();
            List<String[]> strings = new ArrayList<>();
            String[] titleRow = new String[rsmd.getColumnCount()];
            for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                titleRow[i - 1] = rsmd.getColumnName(i);
            }
            strings.add(titleRow);
            while (rs.next()) {
                String[] row = new String[rsmd.getColumnCount()];
                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    row[i - 1] = rs.getString(rsmd.getColumnName(i));
                }
                strings.add(row);
            }
            return strings;
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}
        
