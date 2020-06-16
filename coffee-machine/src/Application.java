import java.util.Map;
import java.util.Scanner;

class Application {
    
    private static final Scanner scanner = new Scanner(System.in);
    private static final CoffeeMachine coffeeMachine = new CoffeeMachine();

    public static void main(String[] args) {
        run();
    }

    private static void run() {

        while (true) {
            System.out.print("Write action (buy, fill, take, remaining, exit):\n>");
            String command = getString();
            switch (command) {
                case "buy":
                    buyCoffee();
                    break;
                case "take":
                    System.out.println("I gave you $" + coffeeMachine.take());
                    break;
                case "fill":
                    fillProducts();
                    break;
                case "remaining":
                    Map<String, Integer> map = coffeeMachine.remaining();
                    System.out.printf("The coffee machine has:\n %s ml of water\n %s ml of milk\n %s g of coffee beans\n %s pcs of disposable cups\n $%s of money\n",
                            map.get("water"), map.get("milk"), map.get("coffee"), map.get("cups"), map.get("cash"));
                    break;
                case "exit":
                    return;
                default:
                    System.out.println("Your line is incorrect");
            }
        }

    }

    private static void buyCoffee() {
        System.out.print("What do you want to buy? 1 - espresso, 2 - latte, 3 - cappuccino, back - to main menu:\n>");
        String typeOfCoffee = getString();
        switch (typeOfCoffee) {
            case "1":
                typeOfCoffee = "espresso";
                break;
            case "2":
                typeOfCoffee = "latte";
                break;
            case "3":
                typeOfCoffee = "cappuccino";
                break;
            case "back":
                return;
            default:
                System.out.println("Your choice isn't correct, you are redirected to main menu");
                return;
        }
        try {
            System.out.println(coffeeMachine.buy(typeOfCoffee) ? "I have enough resources, making you a coffee!" : 
                    "Your line is incorrect");
        } catch (NotEnoughIngredientsException e) {
            System.out.print("Sorry, cannot make " + typeOfCoffee + ". Not enough: ");
            System.out.println(String.join(", ", e.getIngredients()));
        }
    }

    private static void fillProducts() {
        System.out.println("Write how many ml of water do you want to add:");
        int amount = Integer.parseInt(scanner.nextLine());
        coffeeMachine.fillCoffeeMachine("water", amount);

        System.out.println("Write how many ml of milk do you want to add:");
        amount = Integer.parseInt(scanner.nextLine());
        coffeeMachine.fillCoffeeMachine("milk", amount);

        System.out.println("Write how many grams of coffee beans do you want to add:");
        amount = Integer.parseInt(scanner.nextLine());
        coffeeMachine.fillCoffeeMachine("coffee", amount);

        System.out.println("Write how many disposable cups of coffee do you want to add:");
        amount = Integer.parseInt(scanner.nextLine());
        coffeeMachine.fillCoffeeMachine("disposable cups", amount);
    }

    private static String getString() {
        return scanner.nextLine().toLowerCase();
    }
}
