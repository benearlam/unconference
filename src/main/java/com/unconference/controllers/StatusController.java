package com.unconference.controllers;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class StatusController {

    @RequestMapping("/status")
    public String status() {
        return "OK!";
    }
}
