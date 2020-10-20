package servlets;


import app.DB;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Tatiana Savonik
 */
public class CreateTaskServlet extends HttpServlet {

    private final DB db = new DB();
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws IOException {

        String task = request.getParameter("task_name");
        String deadline = request.getParameter("task_date");

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        if (task.length() == 0) {
            response.getWriter().write("Please enter task name");
            return;
        }
        int taskNumber = 0;
        try {
            taskNumber = db.createToDoTask(task, formatter.parse(deadline));
        } catch (ParseException e) {
            response.getWriter().write("Please choose deadline date");
            e.printStackTrace();
            return;
        }
        response.getWriter().write("Your task " + taskNumber + " was created");
    }
}
