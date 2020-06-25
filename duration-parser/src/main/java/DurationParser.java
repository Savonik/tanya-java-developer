import java.time.Duration;

/**
 * @author Tatiana Savonik
 */
public interface DurationParser {
    Duration parse(String durationStr) throws DurationParserException;
}
