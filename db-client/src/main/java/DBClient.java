/*
Create java application that sends all SQL queries written by user to DB and return responses.
If query is SELECT - result is the table.
If query is INSERT, UPDATE, DELETE - result is count of rows affected.
If query is CREATE, ALTER table - result is successful or failed.
In general it should be similar to `psql` application, a bit simpler.
 */

import java.sql.*;
import java.util.Scanner;

public class DBClient {

    public static void main(String[] args) {
        run();
    }

    static String url = "jdbc:postgresql://localhost/mydb?user=postgres&password=savonik1993";

    static void run() {
        System.out.println("Enter the required query");
        Scanner s = new Scanner(System.in);

        while (true) {
            String query = s.nextLine();
            if (query.toLowerCase().equals("exit")) {
                return;
            }
            String firstWord = (query.split(" "))[0].toUpperCase();
            try (Connection conn = DriverManager.getConnection(url)) {
                Statement stmt = conn.createStatement();

                switch (firstWord) {
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
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
