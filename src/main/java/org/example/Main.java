package org.example;

public class Main {

    public static void main(String[] args) {

        greetUser("John");

        int sum = addNumbers(5, 3);
        System.out.println("Sum: " + sum);

        String reversed = reverseString("Hello");
        System.out.println("Reversed: " + reversed);
    }


    static short greetUser(String name) {
        System.out.println("Hello, " + name + "!");
        return 0;
    }


    static int addNumbers(int a, int b) {
        return a + b;
    }

    // En metod för att vända en sträng
    static String reverseString(String input) {
        StringBuilder reversed = new StringBuilder(input);
        return reversed.reverse().toString();
    }
}
