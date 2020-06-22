import java.util.List;
import java.util.Scanner;
import java.util.stream.IntStream;

/**
 * TO DO app is command-line application.
 * User should be able to create to
 * do-tasks, show the list of tasks, mark tasks as done/finished.
 *
 * @author Татьяна
 */

class Application {

    private static final int MAX_TASK_LENGTH = 50;
    private static final DB TASK_LIST = new DB();
    private static final String HELP_TEXT = "TODO app is command-line application.\n" + "Available commands:\n"
            + ">new \"task_name\"\n" + ">list\n" + ">done \"task_number\"\n" +
            ">list --done\n" + "To exit type \"exit\" or \":q\"\n";

    public static void main(String[] args) {
        runCommandLine();
    }

    private static void runCommandLine() {
        while (true) {
            System.out.print("> ");
            String commandLine = new Scanner(System.in).nextLine().trim();
            if (commandLine.isEmpty()) {
                System.out.println(HELP_TEXT);
                continue;
            }
            String[] args = commandLine.split(" ", 2);
            String command = args[0].toLowerCase();
            switch (command) {
                case "exit":
                case ":q":
                    return;
                case "new":
                    if (args.length == 1) {
                        printHelp("Incorrect query");
                        break;
                    }
                    String taskName = args[1];
                    printResultCreateTask(taskName);
                    break;
                case "list":
                    if (args.length == 1) {
                        List<String[]> strings = TASK_LIST.showList();
                        printResult(strings);
                        break;
                    }
                    if (args[1].equals("--done")) {
                        List<String[]> strings = TASK_LIST.showListOfDone();
                        printResult(strings);
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
                case "-h":
                case "--help":
                    System.out.println(HELP_TEXT);
                    break;
                default:
                    printHelp("Incorrect query");
                    break;
            }
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

    private static void printResultCreateTask(String nameOfTask) {
        if (nameOfTask.length() > MAX_TASK_LENGTH) {
            System.out.printf("MAX task length is %s char. You exceeded it by %s char.\n",
                    MAX_TASK_LENGTH, nameOfTask.length() - MAX_TASK_LENGTH);
            return;
        }
        int taskNumber = TASK_LIST.createToDoTask(nameOfTask);
        if (taskNumber == 0) {
            System.out.println("Task wasn't created");
            return;
        }
        System.out.printf("task #%s created\n", taskNumber);
    }

    private static void printResult(List<String[]> strings) {
        if (strings.size() == 1) {
            System.out.println("no tasks yet");
            return;
        }
        for (String[] string : strings) {
            IntStream.range(0, string.length).forEach(i -> System.out.printf(" %-5.20s", string[i]));
            System.out.println();
        }
    }
}

