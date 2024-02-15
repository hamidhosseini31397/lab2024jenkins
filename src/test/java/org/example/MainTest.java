
package org.example;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {

    @org.junit.jupiter.api.Test
    void testGreetUser() {
        assertEquals(0, Main.greetUser("John"));
    }

    @org.junit.jupiter.api.Test
    void add() {
        assertEquals(8, Main.addNumbers(5, 3));
        
    }

    @org.junit.jupiter.api.Test
    void testReverse() {
        assertEquals("olleH", Main.reverseString("Hello"));
    }
}

