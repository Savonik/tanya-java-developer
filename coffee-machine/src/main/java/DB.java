import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Tatiana Savonik
 */
public class DB {
    private static final String url = "jdbc:postgresql://localhost/mydb?user=postgres&password=savonik1993";
    private Connection conn;

    public static void main(String[] args) {
        DB db= new DB();
        
    }

    protected DB() {
        if (runSqlQueryWithRS("SELECT 1 FROM coffee_machine_state1 LIMIT 1").size()==0){
            String query = "CREATE TABLE coffee_machine_state(id serial primary key, name varchar not null," +
                    "amount int default 0);";
            runSqlQuery(query);
        }
    }

    private Connection getConnection() {
        if (conn == null) {
            try {
                conn = DriverManager.getConnection(url);
            } catch (SQLException e) {
                throw new IllegalStateException("Failed to connect to DB", e);
            }
        }
        return conn;
    }

    protected int runSqlQuery(String sqlQuery) {
        try (Statement stmt = getConnection().createStatement()) {
            
            return stmt.executeUpdate(sqlQuery);
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
    protected List<String> runSqlQueryWithRS(String sqlQuery) {
        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(sqlQuery)) {
            ResultSetMetaData rsmd = rs.getMetaData();
            List<String> strings = new ArrayList<>();
            StringBuilder meta = new StringBuilder();
            for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                meta.append(rsmd.getColumnName(i)).append("%");
            }
            strings.add(meta.toString());
            while (rs.next()) {
                StringBuilder dataString = new StringBuilder();
                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    dataString.append(rs.getString(rsmd.getColumnName(i))).append("%");
                }
                strings.add(dataString.toString());
            }
            return strings;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
