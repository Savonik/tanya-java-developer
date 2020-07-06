import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicInteger;

class MergeDirApp {
    private static final String BASIC_MESSAGE = "This program will merge your files from specified directories.\n" +
            "The program receives from 2 to 3 parameters:\n" +
            "1 - path to folder 1\n" +
            "2 - path to folder 2\n" +
            "3 (optional) - path to folder with result of the merge. By default - current_dir/merged";

    public static void main(String[] args) {
        CommandLine cmd;
        Options options = new Options();
        Option filter = new Option("f", "filter", true, "Filter");
        options.addOption(filter);

        Option recursive = new Option("r", "recursive", false, "Recursive");
        options.addOption(recursive);

        CommandLineParser parser = new DefaultParser();
        try {
            cmd = parser.parse(options, args);
        } catch (ParseException e) {
            System.err.println("Parsing failed.  Reason: " + e.getMessage());
            HelpFormatter helpFormatter = new HelpFormatter();
            helpFormatter.printHelp("MergeDirApp [-f <Fileformat>] [-r] <srcdir1> <srcdir2> [<targetdir>]",
                    options);
            return;
        }

        if (args.length < 2) {
            System.out.println(BASIC_MESSAGE);
            return;
        }
        File dir1 = new File(args[0]);
        File dir2 = new File(args[1]);
        File dir3 = new File(args.length == 2 ? (System.getProperty("user.dir") + File.separator + "merged") : args[2]);

        if (directoriesDoesNotExists(dir1, dir2, dir3)) {
            return;
        }
        System.out.println("Your files will be merged to " + dir3);

        String regexp = cmd.getOptionValue("f", ".*");
        boolean recursively = cmd.hasOption("r");
        List<File> allFiles = filterFiles(dir1, dir2, regexp, recursively);
        putFilesIntoDir(dir3, allFiles);
    }

    private static void putFilesIntoDir(File mergedDir, List<File> filesToMerge) {
        AtomicInteger count = new AtomicInteger(Objects.requireNonNull(mergedDir.listFiles()).length + 1);
        System.out.println();
        filesToMerge.stream()
                .sorted(Comparator.comparing(File::lastModified))
                .forEach(file -> {
                    try {
                        Files.copy(Paths.get(file.getPath()),
                                Paths.get(String.format("%s%s%d_%s", mergedDir.getAbsolutePath(),
                                        File.separator, count.getAndIncrement(), file.getName())));
                        System.out.println(file.getName() + " was copied");
                    } catch (IOException e) {
                        System.out.println(file.getName() + " wasn't copied");
                        e.printStackTrace();
                    }
                });
    }

    private static boolean directoriesDoesNotExists(File dir1, File dir2, File dir3) {
        if (!dir1.exists() || !dir2.exists()) {
            System.out.printf("%s%n%s, %s", "Please pass 2 existing directories:",
                    dir1.exists() ? "directory 1 exists" : "directory 1 doesn't exist",
                    dir2.exists() ? "directory 2 exists" : "directory 2 doesn't exist.");
            return true;
        }
        if (!dir3.exists()) {
            if (dir3.mkdir()) {
                System.out.println(dir3 + " is created!");
            } else {
                System.out.println(dir3 + "Failed to create " + dir3);
                return true;
            }
        }
        return false;
    }

    private static List<File> getFiles(File directory, boolean recursively, String regexp) {
        List<File> allFiles = new ArrayList<>();
        for (File file : Objects.requireNonNull(directory.listFiles())) {
            if (!file.isDirectory() && file.getName().matches(regexp)) {
                allFiles.add(file);
            }

            if (recursively && file.isDirectory()) {
                if (Objects.requireNonNull(file.list()).length > 0) {
                    allFiles.addAll(getFiles(file, true, regexp));
                }
            }
        }
        return allFiles;
    }

    private static List<File> filterFiles(File dir1, File dir2, String regexp, boolean recursively) {
        List<File> allFiles = getFiles(dir1, recursively, regexp);
        allFiles.addAll(getFiles(dir2, recursively, regexp));
        return allFiles;
    }
}

