import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Objects;

/**
 * This program exports the contents of a directory
 * or the contents of a directory with all its subdirectories to a txt file.
 *
 * @author Tatiana Savonik
 */
class PrintDirectories {

    private static final File USER_DIRECTORY = new File(System.getProperty("user.dir"));
    private static final String BASIC_MESSAGE = "Status of operation: ";

    public static void main(String[] args) {

        if (args.length == 0) {
            System.out.printf("%s %s", BASIC_MESSAGE, exportCurrentFiles(USER_DIRECTORY) ? "done" : "not done");
            return;
        }

        switch (args[0]) {
            case ("-r"):
                File inputDirectory = USER_DIRECTORY;
                if (args.length > 1) {
                    inputDirectory = new File(args[1]);
                }
                System.out.printf("%s %s", BASIC_MESSAGE,
                        exportCurrentFilesRecursively(inputDirectory) ? "done" : "not done");
                break;
            case ("-h"):
            case ("--help"):
                System.out.println("MyApp [-r] [Directory]\n-r - for recursion" +
                        "\ndirectory - for exact directory that you want to index.");
                break;
            default:
                System.out.printf("%s %s", BASIC_MESSAGE,
                        exportCurrentFiles(new File(args[0])) ? "done" : "not done");
                break;
        }
    }

    private static boolean exportCurrentFilesRecursively(File currentDirectory) {
        String exportFileName = currentDirectory + File.separator + "CurrentFilesRecursively.txt";
        System.out.println("Your directory with recursive will index to " + exportFileName);
        if (isNotDirectory(currentDirectory)) {
            return false;
        }
        try (FileWriter writer = new FileWriter(exportFileName)) {
            return exportCurrentFilesRecursively(currentDirectory, writer);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static boolean exportCurrentFilesRecursively(File currentDirectory, FileWriter writer) throws IOException {
        for (File file : Objects.requireNonNull(currentDirectory.listFiles())) {
            if (file.isFile()) {
                writer.write(file.getAbsolutePath() + "\n");
            } else {
                writer.write(file.getAbsolutePath() + File.separator + "\n");
                exportCurrentFilesRecursively(file, writer);
            }
        }
        return true;
    }

    private static boolean isNotDirectory(File currentDirectory) {
        if (!currentDirectory.isDirectory()) {
            System.out.println("Directory PATH doesn't exist");
            return true;
        }
        return false;
    }

    private static boolean exportCurrentFiles(File currentDirectory) {
        String exportFileName = currentDirectory + File.separator + "CurrentFiles.txt";
        System.out.println("Your directory will index to " + exportFileName);
        if (isNotDirectory(currentDirectory)) {
            return false;
        }
        try (FileWriter writer = new FileWriter(exportFileName)) {
            for (File file : Objects.requireNonNull(currentDirectory.listFiles())) {
                writer.write(file.isFile() ?
                        file.getAbsolutePath() + "\n" : file.getAbsolutePath() + File.separator + "\n");
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}
