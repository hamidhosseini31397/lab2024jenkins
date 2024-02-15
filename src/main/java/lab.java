public class lab {

    public static void greetUser(String name) {
        System.out.println("Hello, " + name + "!");
    }

    public static int addNumbers(int a, int b) {
        return a + b;
    }

    public static String reverseString(String input) {
        StringBuilder reversed = new StringBuilder(input);
        return reversed.reverse().toString();
    }
}
