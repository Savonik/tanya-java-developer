package tasks.filtering_rules;

/**
 * @author Tatiana Savonik
 */
public class Rule implements Comparable<Rule> {
    
    private final String name;
    private final String type;
    private final int weight;

    public Rule(String name, String type, int weight) {
        this.name = name;
        this.type = type;
        this.weight = weight;
    }

    public String getName() {
        return name;
    }

    public String getType() {
        return type;
    }

    public int getWeight() {
        return weight;
    }

    /**
     * @return value of priority type parameter.
     */
    public int getTypePriority() {
        switch (type) {
            case "child":
                return 3;
            case "sub":
                return 2;
            case "root":
                return 1;
        }
        return 0;
    }

    /**
     * Compares rules by priority:
     * The rule name (not unique in input, but should be unique in output).
     * Rule type can be one of 3 values: root, sub and child. The child rule is the most important;
     * the sub is of average importance and then the root is the least important.
     * The weight specifies the rule importance within same type.
     * The greater the weight value is, the more important the rule is. Weight is a positive integer.
     */
    
    @Override
    public int compareTo(Rule o) {
        
        int result = name.compareTo(o.name);
        if (result != 0) {
            return result / Math.abs(result);
        }

        result = weight - o.getWeight();
        if (result != 0) {
            return result / Math.abs(result);
        }

        result = getTypePriority() - o.getTypePriority();
        if (result != 0) {
            return result / Math.abs(result);
        }

        return 0;
    }
}

