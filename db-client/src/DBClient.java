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
        System.out.println("Введите требуемый запрос");
        Scanner s = new Scanner(System.in);
        String query = s.nextLine().toUpperCase();
        String[] first = query.split(" ");
        try (Connection conn = DriverManager.getConnection(url)) {
            Statement stmt = conn.createStatement();
            switch (first[0]) {
                case "SELECT":
                    ResultSet rs = stmt.executeQuery(query);
                    ResultSetMetaData rsmd = rs.getMetaData();
                    while (rs.next()) {
                        for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                            System.out.print(rs.getString(rsmd.getColumnName(i)) + "   ");
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
                    System.out.println("Ваш запрос некорректен");
            }

            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

}
