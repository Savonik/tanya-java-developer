import java.time.Duration;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author Tatiana Savonik
 */
public class DurationParserFormatter implements DurationFormatter, DurationParser {

    private static final long MILLIS_PER_WEEK = 604_800_000;
    private static final long MILLIS_PER_DAY = 86_400_000;
    private static final long MILLIS_PER_HOUR = 3_600_000;
    private static final long MILLIS_PER_MINUTE = 60_000;
    private static final long MILLIS_PER_SECOND = 1_000;

    @Override
    public String format(Duration duration) {
        long millis = duration.toMillis();
        if (millis == 0) {
            return "0ms";
        }
        StringBuilder formatTime = new StringBuilder();

        Map<String, Long> timeUnits = new LinkedHashMap<>();
        timeUnits.put("w", MILLIS_PER_WEEK);
        timeUnits.put("d", MILLIS_PER_DAY);
        timeUnits.put("h", MILLIS_PER_HOUR);
        timeUnits.put("m", MILLIS_PER_MINUTE);
        timeUnits.put("s", MILLIS_PER_SECOND);
        timeUnits.put("ms", 1L);

        for (Map.Entry<String, Long> entry : timeUnits.entrySet()) {
            long units = millis / entry.getValue();
            if (millis > 0 && units > 0) {
                formatTime.append(units).append(entry.getKey());
                millis -= units * entry.getValue();
            }
        }
        return formatTime.toString();
    }

    @Override
    public Duration parse(String durationStr) throws DurationParserException {
        Duration duration = Duration.ofDays(0);
        if (!isCorrect(durationStr)) {
            throw new DurationParserException("Duration string isn't correct [" + durationStr + "]");
        }
        char[] chars = durationStr.toCharArray();
        StringBuilder numbers = new StringBuilder();
        for (int i = 0; i < chars.length; i++) {
            if (!isLetter(chars[i])) {
                numbers.append(chars[i]);
            } else {
                int value = Integer.parseInt(numbers.toString());
                StringBuilder letters = new StringBuilder();
                while (i < chars.length && isLetter(chars[i])) {
                    letters.append(chars[i]);
                    i++;
                }
                String dimension = letters.toString();
                duration = addToDuration(duration, value, dimension);
                i--;
                numbers = new StringBuilder();
            }
        }
        return duration;
    }

    private boolean isCorrect(String durationStr) {
        return durationStr.matches("^([0-9]+w)?([0-9]+d)?([0-9]+h)?([0-9]+m)?([0-9]+s)?([0-9]+ms)?$");
    }

    private Duration addToDuration(Duration duration, int value, String dimension) throws DurationParserException {
        switch (dimension) {
            case "w":
                return duration.plus(value, ChronoUnit.WEEKS);
            case "d":
                return duration.plus(value, ChronoUnit.DAYS);
            case "h":
                return duration.plus(value, ChronoUnit.HOURS);
            case "m":
                return duration.plus(value, ChronoUnit.MINUTES);
            case "s":
                return duration.plus(value, ChronoUnit.SECONDS);
            case "ms":
                return duration.plus(value, ChronoUnit.MILLIS);
            default:
                throw new DurationParserException("Incorrect time unit [" + dimension + "]");
        }
    }

    private static boolean isLetter(char symbol) {
        return symbol >= 'a' && symbol <= 'z';
    }
}

