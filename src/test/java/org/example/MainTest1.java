package org.example;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MainTest1 {

    @Test
    void add() {
        assertEquals(8, Main.addNumbers(5, 3));
    }
}