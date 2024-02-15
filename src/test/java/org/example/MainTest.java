package org.example;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {

    @org.junit.jupiter.api.Test
    void testGreetUser() {
        assertEquals(0, Main.greetUser("John"));
    }
}
