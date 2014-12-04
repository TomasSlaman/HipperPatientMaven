/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Tomas
 */
public class DatabaseManager {
    public static final String JDBC_EXCEPTION = "JDBC Exception: ";
    public static final String SQL_EXCEPTION = "SQL Exception: ";

    public static final String DRIVER = "com.mysql.jdbc.Driver";
    public static final String DBURL = "jdbc:mysql://oege.ie.hva.nl:3306/zsnuvert001";
    public static final String DBUSER = "snuvert001";
    public static final String DBPASS = "s9szSf/R3";
    
    private ResultSet result = null;
    private int affectedRows = -1;
    private static Connection connection = null;

    public DatabaseManager() {
    }
    
    public void openConnection() {
        try {
            Class.forName(DRIVER);

            // Open Connection
            connection = DriverManager.getConnection(DBURL, DBUSER, DBPASS);
        } catch (ClassNotFoundException e) {
            System.err.println(JDBC_EXCEPTION + e);
        } catch (java.sql.SQLException e) {
            System.err.println(SQL_EXCEPTION + e);
        }
    }
    
    public void closeConnection() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            System.err.println(SQL_EXCEPTION + e.getMessage());
        }
        connection = null;
    }

    public ResultSet performSelect(PreparedStatement prdstmt) throws SQLException {
        result = prdstmt.executeQuery();

        return result;
    }

    public int performUpdate(PreparedStatement prdstmt) throws SQLException {

        affectedRows = prdstmt.executeUpdate();

        return affectedRows;
    }
    
    public Connection getConnection() {
        return connection;
    }
    
    public ResultSet doQuery(String query) {
        ResultSet result = null;
        try {
            Statement statement = connection.createStatement();
            result = statement.executeQuery(query);
        } catch (java.sql.SQLException e) {
            System.err.println(SQL_EXCEPTION + e);
        }
        return result;
    }
}
