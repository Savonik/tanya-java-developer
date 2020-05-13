import java.sql.Connection;

public interface ConnectionPool {

    Connection getConnection();

    int getMinCapacity();

    int getMaxCapacity();

    void close();

}
