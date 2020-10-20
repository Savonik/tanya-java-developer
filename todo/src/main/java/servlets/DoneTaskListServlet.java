package servlets;

import app.DB;
import app.Task;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;

public class DoneTaskListServlet extends HttpServlet {

    private final DB db = new DB();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Task> tasks = db.getAll();
        List<Task> doneTasks = tasks.stream().filter(Task::isDone).collect(Collectors.toList());
        PrintWriter writer = resp.getWriter();
        TaskWriter taskWriter = new TaskWriter(doneTasks, writer);
        taskWriter.write();
    }
}
