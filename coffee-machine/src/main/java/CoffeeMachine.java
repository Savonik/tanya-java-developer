import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CoffeeMachine {

    private static int waterAmountInMl = 400;
    private static int coffeeAmountInG = 540;
    private static int milkAmountInMl = 120;
    private static int disposableCupsAmount = 9;
    private static int cashAmountInUsd = 550;

    public boolean fillCoffeeMachine(String product, int amount) {
        switch (product) {
            case "water":
                waterAmountInMl += amount;
                return true;
            case "milk":
                milkAmountInMl += amount;
                return true;
            case "coffee":
                coffeeAmountInG += amount;
                return true;
            case "disposable cups":
                disposableCupsAmount += amount;
                return true;
            default:
                return false;
        }
    }

    public Map<String, Integer> remaining() {
        Map<String, Integer> map = new HashMap<>();
        map.put("water", waterAmountInMl);
        map.put("milk", milkAmountInMl);
        map.put("coffee", coffeeAmountInG);
        map.put("cups", disposableCupsAmount);
        map.put("cash", cashAmountInUsd);
        return map;
    }

    public int take() {
        int currentCash = cashAmountInUsd;
        cashAmountInUsd = 0;
        return currentCash;
    }

    public boolean buy(String typeOfCoffee) throws NotEnoughIngredientsException {
        switch (typeOfCoffee) {
            case "espresso":
                return doEspresso();
            case "latte":
                return doLatte();
            case "cappuccino":
                return doCappuccino();
            default:
        }
        return false;
    }

    private boolean doEspresso() throws NotEnoughIngredientsException {
        return doCoffee(250, 0, 16, 4);
    }

    private boolean doLatte() throws NotEnoughIngredientsException {
        return doCoffee(350, 75, 20, 7);
    }

    private boolean doCappuccino() throws NotEnoughIngredientsException {
        return doCoffee(200, 100, 12, 6);
    }


    private boolean doCoffee(int waterAmountForThisType, int milkAmountForThisType, int coffeeAmountForThisType, int priceForThisType) throws NotEnoughIngredientsException {
        if (isNotEnough(waterAmountForThisType, milkAmountForThisType, coffeeAmountForThisType)) {
            List<String> list = collectNotEnoughIngredients(waterAmountForThisType, milkAmountForThisType, coffeeAmountForThisType);
            throw new NotEnoughIngredientsException(list);
        }
        waterAmountInMl -= waterAmountForThisType;
        milkAmountInMl -= milkAmountForThisType;
        coffeeAmountInG -= coffeeAmountForThisType;
        disposableCupsAmount -= 1;
        cashAmountInUsd += priceForThisType;
        return true;
    }

    private boolean isNotEnough(int waterAmountForThisType, int milkAmountForThisType, int coffeeAmountForThisType) {
        return waterAmountForThisType > waterAmountInMl ||
                milkAmountForThisType > milkAmountInMl ||
                coffeeAmountForThisType > coffeeAmountInG ||
                disposableCupsAmount == 0;
    }

    private List<String> collectNotEnoughIngredients(int waterAmountForThisType, int milkAmountForThisType, int coffeeAmountForThisType) {
        ArrayList<String> arrayList = new ArrayList<>();
        if (waterAmountForThisType > waterAmountInMl) {
            arrayList.add("water");
        }
        if (milkAmountForThisType > milkAmountInMl) {
            arrayList.add("milk");
        }
        if (coffeeAmountForThisType > coffeeAmountInG) {
            arrayList.add("coffee");
        }
        if (disposableCupsAmount == 0) {
            arrayList.add("disposable cups");
        }
        return arrayList;
    }

}
