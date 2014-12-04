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
    
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView showIndex() {
        
        /*List<Comment> comments = new ArrayList<>();
        try {
            comments = CommentDAO.readCommentsByUserId(1);
        } catch (SQLException e) {
        }

        for (int i = 0; i < comments.size(); i++) {
            System.out.println(comments.get(i).getComment());
        }*/
        
        System.out.println("CONTROLLER RUNS");
        return new ModelAndView("index");
    }
}
