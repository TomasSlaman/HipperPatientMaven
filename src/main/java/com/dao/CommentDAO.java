/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.database.DatabaseManager;
import com.model.Comment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tomas
 */
public class CommentDAO {
    
    private static final DatabaseManager db = new DatabaseManager();
    
    public static void createComment() {
    }
    
    public static List<Comment> readCommentsByUserId(int id) throws SQLException {
        List<Comment> comments = new ArrayList<>();
        ResultSet rs = null;
        PreparedStatement ps = null;
        
        String query = "SELECT * FROM Comment WHERE patientId = ?;";
        
        db.openConnection();
        
        ps = db.getConnection().prepareStatement(query);
        ps.setLong(1, id);
        rs = db.performSelect(ps);
        
        while (rs.next()) {
            Comment comment = new Comment();
            comment.setComment(rs.getString("comment"));
            comment.setCommentId(rs.getLong("commentId"));
            //comment.setDate();
            comment.setExersiseId(rs.getLong("exerciseId"));
            comment.setPatientId(rs.getLong("patientId"));
            comments.add(comment);
        }
        
        if (db != null) {
            db.closeConnection();
        }
        
        return comments;
    }
    
    public static void updateComment() {
    }
    
    public static void deleteComment() {
    }
}
