import au.com.bytecode.opencsv.CSVWriter;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

/**
 * this class process user's queries
 *
 * @author Tatiana Savonik
 */
public class DBClient {

    private static final String URL = "jdbc:postgresql://lob?usercalhost/myd=postgres&password=savonik1993";

    public static void main(String[] args) {
        run();
    }

    private static void run() {
        System.out.println("Enter the required query");
        Scanner s = new Scanner(System.in);

        while (true) {
            String query = s.nextLine();
            if (query.toLowerCase().equals("exit")) {
                return;
            }
            String[] splitQuery = query.split(" ", 2);
            if (splitQuery.length < 2) {
                System.out.println("Query is too short");
                continue;
            }
            String firstWord = splitQuery[0].toUpperCase();
            try (Connection conn = DriverManager.getConnection(URL)) {
                Statement stmt = conn.createStatement();
                switch (firstWord) {
                    case "EXPORT":
                        export(splitQuery[1], stmt);
                        break;
                    case "SELECT":
                        ResultSet rs = stmt.executeQuery(query);
                        ResultSetMetaData rsmd = rs.getMetaData();
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
                        rs.close();
                        break;
                    case "INSERT":
                    case "UPDATE":
                    case "DELETE":
                        System.out.println(stmt.executeUpdate(query) + " rows affected");
                        break;
                    case "CREATE":
                    case "ALTER":
                    case "DROP":
                        System.out.println(stmt.execute(query));
                        break;
                    default:
                        System.out.println("Your query is incorrect");
                }
                stmt.close();
            } catch (SQLException | IOException e) {
                e.printStackTrace();
            }
        }
    }

    private static void export(String query, Statement stmt) throws IOException, SQLException {
        String[] splitQuery = query.split(" ", 2);
        String command = splitQuery[0];
        if (splitQuery.length < 2) {
            System.out.println("Query is too short");
            return;
        }
        String filename = System.getProperty("user.dir") + File.separator + "DB.csv";
        try (CSVWriter writer = new CSVWriter(new FileWriter(filename, true))) {
            if ("SELECT".equalsIgnoreCase(command)) {
                writer.writeAll(stmt.executeQuery(command + splitQuery[1]), true);
                System.out.println("Data was written into DB.csv ");
            } else if ("TABLE".equalsIgnoreCase(command)) {
                writer.writeAll(stmt.executeQuery("SELECT * FROM " + splitQuery[1]), true);
                System.out.println("Data was written into DB.csv ");
            } else {
                System.out.println("Your query isn't correct");
            }
        }
    }
}
