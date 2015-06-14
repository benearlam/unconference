package com.unconference.controllers;

import junit.framework.TestCase;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.assertThat;

public class StatusControllerTest extends TestCase {
    StatusController controller = new StatusController();

    public void testStatus() throws Exception {
        assertThat(controller.status(), is("OK!"));
    }
}