package com.Major.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Databaseconfig {
	public static Connection getConnection() throws Exception {
		
		String dbUrl = "jdbc:mysql://localhost:3306/careerchowk";
		String userName = "root";
		String pass = "Prashant";
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		return DriverManager.getConnection(dbUrl,userName,pass);		
	}
}
