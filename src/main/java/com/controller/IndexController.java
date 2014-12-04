/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Tomas
 */
@Controller
public class IndexController {
    
    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView showIndex() {
        System.out.println("CONTROLLER RUNS");
        return new ModelAndView("index");
    }
}
