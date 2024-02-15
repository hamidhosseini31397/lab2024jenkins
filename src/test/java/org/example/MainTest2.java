package org.example;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MainTest2 {

    @Test
    void testReverse() {
        assertEquals("olleH", Main.reverseString("Hello"));
    }
}
