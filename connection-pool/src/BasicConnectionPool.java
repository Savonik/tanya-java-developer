import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class BasicConnectionPool implements ConnectionPool {

    private List<Connection> pool = new ArrayList<Connection>();

    private int minCapacity;
    private int maxCapacity;

    @Override
    public Connection getConnection() {
        //return new ConnectionWrapper(pool.get(i));
    }

}
