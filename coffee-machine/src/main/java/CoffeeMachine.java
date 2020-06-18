import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CoffeeMachine {
   
    private static final DB DB = new DB();

    public boolean fillCoffeeMachine(String product, int amount) {
        switch (product) {
            case "water":
                return DB.fill("water", amount);
            case "milk":
                return DB.fill("milk", amount);
            case "coffee":
                return DB.fill("coffee", amount);
            case "disposable cups":
                return DB.fill("disposable cups", amount);
            default:
                return false;
        }
    }

    public Map<String, String> remaining() {
        Map<String, String> map = new HashMap<>();
        map.put("water", DB.getAmount("water"));
        map.put("milk", DB.getAmount("milk"));
        map.put("coffee", DB.getAmount("coffee"));
        map.put("cups", DB.getAmount("cups"));
        map.put("cash", DB.getAmount("cash"));
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
