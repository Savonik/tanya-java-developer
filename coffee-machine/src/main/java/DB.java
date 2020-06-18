import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
    private static Connection conn;

    protected DB() {
        if (runSqlQueryWithRS("SELECT 1 FROM coffee_machine_state LIMIT 1") == null) {
            int cashAmountInUsd = 550;
            int disposableCupsAmount = 9;
            int milkAmountInMl = 120;
            int coffeeAmountInG = 540;
            int waterAmountInMl = 400;
            String query = "CREATE TABLE coffee_machine_state(id serial primary key, name varchar not null," +
                    "amount int default 0);" +
                    "INSERT INTO coffee_machine_state(name, amount) values " +
                    "('coffee'," + coffeeAmountInG + ")," +
                    "('water'," + waterAmountInMl + ")," +
                    "('milk'," + milkAmountInMl + "),"+
                    "('disposable cups'," + disposableCupsAmount + "),"+
                    "('cash'," + cashAmountInUsd + ");";
            runSqlQuery(query);
        }
    }
    
    protected boolean fill(String productName, int amount){
        String query = "update coffee_machine_state set amount = amount + ? where name =?;";
        try (PreparedStatement stmt = getConnection().prepareStatement(query)) {
            stmt.setInt(1, amount);
            stmt.setString(2, productName);
            return stmt.executeUpdate()==1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private static Connection getConnection() {
        if (conn == null) {
            try {
                conn = DriverManager.getConnection(url);
            } catch (SQLException e) {
                throw new IllegalStateException("Failed to connect to DB", e);
            }
        }
        return conn;
    }

    protected static int runSqlQuery(String sqlQuery) {
        try (Statement stmt = getConnection().createStatement()) {
            return stmt.executeUpdate(sqlQuery);
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
    public String getAmount(String product) {
        String query = "select amount from coffee_machine_state where name ='"+product+"'";
        List<String> value = runSqlQueryWithRS(query);
        return value.get(1);
    }

    protected List<String> runSqlQueryWithRS(String sqlQuery) {
        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(sqlQuery)) {
            ResultSetMetaData rsmd = rs.getMetaData();
            List<String> strings = new ArrayList<>();
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
