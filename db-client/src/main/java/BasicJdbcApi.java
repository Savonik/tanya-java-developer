import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

class BasicJdbcApi {
    private static final String URL = "jdbc:postgresql://localhost/mydb?user=postgres&password=savonik1993";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(URL)) {
            try {
                conn.setAutoCommit(false);
                createTableIfNotExists(conn);
                insertContact(conn, "Роман", "Сорокни");
                selectAndPrintAll(conn);
                conn.commit();
            } catch (SQLException throwables) {
                conn.rollback();
                System.out.println("Transaction is rolled back");
                throwables.printStackTrace();
            }
        } catch (SQLException throwables) {
            System.out.println("Connection cannot be created");
            throwables.printStackTrace();
        }
    }

    private static void selectAndPrintAll(Connection conn) throws SQLException {
        final String sqlQuery = "select * from contacts";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sqlQuery)) {
            ResultSetMetaData rsmd = rs.getMetaData();
            while (rs.next()) {
                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    System.out.printf(" %-15.10s", rsmd.getColumnName(i));
                }
                System.out.println();
                while (rs.next()) {
                    for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                        System.out.printf(" %-15.10s", rs.getString(rsmd.getColumnName(i)));
                    }
                    System.out.println();
                }
            }
        }
    }

    private static void createTableIfNotExists(Connection conn) throws SQLException {
        String sqlQuery = "CREATE TABLE IF NOT EXISTS contacts (contact_id serial primary key, " +
                "first_name varchar(20), second_name varchar(20), phone_number int);";
        try (Statement stmt = conn.createStatement()) {
            stmt.execute(sqlQuery);
        }
    }

    private static void insertContact(Connection conn, String firstName, String secondName) throws SQLException {
        Random r = new Random(5000);
        int phoneNumber = r.nextInt(400000000);
        String sqlQuery = "INSERT INTO contacts(first_name,second_name,phone_number) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sqlQuery)) {
            stmt.setString(1, firstName);
            stmt.setString(2, secondName);
            stmt.setInt(3, phoneNumber);
            stmt.executeUpdate();
        }
    }
}
