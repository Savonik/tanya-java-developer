/*
Application expects 3 parameters: Directory1 and Directory2 - directories to be merged, 
Directory3 - directory were previous directories will be merged.
if Directory1 or Directory2 doesn't exist then application should tell to user about it.
if Directory1 or Directory2 has folders inside - application should skip them.
if Directory3 doesn’t exist - application should create it.
if Directory3 is not provided then merge the foles into current directory.
We expect the following usage of this tool:
merge dir1 dir2 dir3
merge D:\photos\camera D:\photos\phone D:\photos\merged
To test in IDE we need to add these arguments into Run configuration. To do so go to Run → Edit Configurations… 
Choose the merge application on the left side, then on the right side under the tab Configuration find Program arguments and type three arguments-folders.https://www.youtube.com/watch?v=kAAbdoq1to8
 */

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicInteger;

class MergeDirApp {

    public static void main(String[] args) {
        if (args.length < 2) {
            System.out.println("This program will merge your files from specified directories.\n" +
                    "The program receives from 2 to 3 parameters:\n" +
                    "1 - path to folder 1\n" +
                    "2 - path to folder 2\n" +
                    "3 (optional) - path to folder with result of the merge.");
            return;
        }
        File dir1 = new File(args[0]);
        File dir2 = new File(args[1]);
        File dir3 = new File(args.length == 2 ? (System.getProperty("user.dir") + File.separator + "merged") : args[2]);
        merge(dir1, dir2, dir3);
    }

    private static void merge(File dir1, File dir2, File dir3) {
        if (!dir1.exists() || !dir2.exists()) {
            System.out.printf("%s%n%s, %s", "Please pass 2 existing directories:",
                    dir1.exists() ? "directory 1 exists" : "directory 1 doesn't exist",
                    dir2.exists() ? "directory 2 exists" : "directory 2 doesn't exist.");
            return;
        }
        if (!dir3.exists()) {
            if (dir3.mkdir()) {
                System.out.println(dir3 + " is created!");
            } else {
                System.out.println(dir3 + "Failed to create " + dir3);
                return;
            }
        }
        System.out.println("Your photos will merged to " + dir3);
        List<File> allFiles = joinFilesToArray(dir1, dir2);
        AtomicInteger count = new AtomicInteger(Objects.requireNonNull(dir3.listFiles()).length + 1);
        allFiles.stream()
                .sorted(Comparator.comparing(File::lastModified))
                .forEach(file -> {
                    try {
                        Files.copy(Paths.get(file.getPath()),
                                Paths.get(String.format("%s%s%d_%s", dir3.getAbsolutePath(), File.separator, count.getAndIncrement(), file.getName())));
                        System.out.println(file.getName() + " was copied");
                    } catch (IOException e) {
                        System.out.println(file.getName() + " wasn't copied");
                        e.printStackTrace();
                    }
                });
    }

    private static List<File> joinFilesToArray(File dir1, File dir2) {
        List<File> allFiles = new ArrayList<>();
        Arrays.stream(Objects.requireNonNull(dir1.listFiles()))
                .filter(file -> !file.isDirectory())
                .forEachOrdered(allFiles::add);

        Arrays.stream(Objects.requireNonNull(dir2.listFiles()))
                .filter(file -> !file.isDirectory())
                .forEachOrdered(allFiles::add);
        return allFiles;
    }
}

