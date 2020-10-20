package app;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Scanner;

/**
 * TO DO app is command-line application.
 * User should be able to create to
 * do-tasks, show the list of tasks, mark tasks as done/finished.
 *
 * @author Татьяна
 */

public class Application {

    private static final int MAX_TASK_LENGTH = 50;
    private static final DB TASK_LIST = new DB();
    private static final String HELP_TEXT = "TODO app is command-line application.\n" + "Available commands:\n"
            + ">new \"task_name\"\n" + ">new \"task_name\" -d \"dd/MM/yyyy\"\n" + ">list\n" + ">done \"task_number\"\n" +
            ">list --done\n" + "To exit type \"exit\" or \":q\"\n";

    public static void main(String[] args) {
        runCommandLine(args);
    }

    private static void runCommandLine(String[] args) {
        if (args.length == 0) {
            System.out.println(HELP_TEXT);
            return;
        }
        String command = args[0].toLowerCase();
        switch (command) {
            case "--new":
            case "-n":
                if (args.length == 1) {
                    printHelp("Incorrect query");
                    break;
                }
                String[] newCommandArgs = new String[args.length - 1];
                System.arraycopy(args, 1, newCommandArgs, 0, newCommandArgs.length);
                CommandLine cmd;
                Options options = new Options();
                options.addOption(new Option("d", "date", true, "date"));
                CommandLineParser parser = new DefaultParser();
                try {
                    cmd = parser.parse(options, newCommandArgs);
                } catch (ParseException e) {
                    System.err.println("Adding failed.  Reason: " + e.getMessage());
                    HelpFormatter helpFormatter = new HelpFormatter();
                    helpFormatter.printHelp("TODO app [-n <app.Task name>] [-d <date>]",
                            options);
                    return;
                }
                if (cmd.hasOption("d")) {
                    String stringDate = cmd.getOptionValue("d");
                    Date date = null;
                    try {
                        date = new SimpleDateFormat("dd/MM/yyyy").parse(stringDate);
                    } catch (java.text.ParseException e) {
                        System.out.println("Incorrect date. Please enter date in format \"dd/MM/yyyy\"");
                        e.printStackTrace();
                    }
                    printResultCreateTask(cmd.getArgs()[0], date);
                    break;
                }
                printResultCreateTask(cmd.getArgs()[0]);
                break;
            case "list":
                if (args.length == 1) {
                    List<Task> tasks = TASK_LIST.getNotDone();
                    printTasks(tasks);
                    break;
                }
                if ("--done".equals(args[1])) {
                    List<Task> tasks = TASK_LIST.getDone();
                    printTasks(tasks);
                    break;
                }
                if ("--all".equals(args[1])) {
                    List<Task> tasks = TASK_LIST.getAll();
                    printTasks(tasks);
                    break;
                }
                printHelp("Incorrect query");
                break;
            case "done":
                if (args.length == 1) {
                    printHelp("Incorrect query");
                    break;
                }
                String taskNumberString = args[1];
                printResultMarkAsDone(taskNumberString);
                break;
            case "today":
                List<Task> tasks = TASK_LIST.getToDoToday();
                printTasks(tasks);
                break;
            case "-h":
            case "--help":
                System.out.println(HELP_TEXT);
                break;
            default:
                printHelp("Incorrect query");
                break;
        }
    }

    private static void printHelp(String message) {
        System.out.println(message + "\n" + HELP_TEXT);
    }

    private static void printResultMarkAsDone(String taskNumberString) {
        int taskNumber = Integer.parseInt(taskNumberString);
        int updated = TASK_LIST.markAsDone(taskNumber);
        switch (updated) {
            case (0):
                System.out.println("task " + taskNumber + " already done or doesn't exists");
                break;
            case (1):
                System.out.println("task " + taskNumber + " done");
                break;
            default:
                printHelp("incorrect data");
                break;
        }
    }

    private static void printResultCreateTask(String nameOfTask, Date date) {
        if (nameOfTask.length() > MAX_TASK_LENGTH) {
            System.out.printf("MAX task length is %s char. You exceeded it by %s char.\n",
                    MAX_TASK_LENGTH, nameOfTask.length() - MAX_TASK_LENGTH);
            return;
        }
        int taskNumber = TASK_LIST.createToDoTask(nameOfTask, date);
        if (taskNumber == 0) {
            System.out.println("app.Task wasn't created");
            return;
        }
        System.out.printf("task #%s created\n", taskNumber);
    }

    private static void printResultCreateTask(String nameOfTask) {
        if (nameOfTask.length() > MAX_TASK_LENGTH) {
            System.out.printf("MAX task length is %s char. You exceeded it by %s char.\n",
                    MAX_TASK_LENGTH, nameOfTask.length() - MAX_TASK_LENGTH);
            return;
        }
        int taskNumber = TASK_LIST.createToDoTask(nameOfTask);
        if (taskNumber == 0) {
            System.out.println("app.Task wasn't created");
            return;
        }
        System.out.printf("task #%s created\n", taskNumber);
    }

    private static void printTasks(List<Task> tasks) {
        if (tasks.size() == 0) {
            System.out.println("no tasks yet");
            return;
        }
        System.out.printf(" %5s  %30s  %5s  %20s\n",
                "task", "name", "done", "dead_line");
        for (Task task : tasks) {
            System.out.printf(" %5s  %30s  %5s  %20s",
                    task.getId(), task.getName(), task.isDone(), task.getDeadlineDate());
            System.out.println();
        }
    }
}

