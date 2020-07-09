import java.util.Date;

/**
 * @author Tatiana Savonik
 */
public class Task {
    private int id;
    private String name;
    private boolean done;
    private Date deadlineDate;

    public Task(int id, String name, boolean done, Date deadlineDate) {
        this.id = id;
        this.name = name;
        this.done = done;
        this.deadlineDate = deadlineDate;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public boolean isDone() {
        return done;
    }

    public Date getDeadlineDate() {
        return deadlineDate;
    }

  
}
