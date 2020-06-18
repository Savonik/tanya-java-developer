import java.util.Collections;
import java.util.List;

/**
 * @author Tatiana Savonik
 */
public class NotEnoughIngredientsException extends Exception {
    private final List<String> ingredients;

    public NotEnoughIngredientsException(List<String> list) {
        this.ingredients = list;
    }

    public List<String> getIngredients() {
        return Collections.unmodifiableList(ingredients);
    }

}
