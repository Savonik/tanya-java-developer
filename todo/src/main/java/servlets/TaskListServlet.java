package servlets;

import app.DB;
import app.Task;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class TaskListServlet extends HttpServlet {

    DB db = new DB();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Task> tasks = db.getAll();
        PrintWriter writer = resp.getWriter();
        TaskWriter taskWriter = new TaskWriter(tasks,writer);
        taskWriter.write();
    }

}
