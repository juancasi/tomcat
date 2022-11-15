package org.software.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DataBase {
	public Connection getConnection(String profile) {
		Connection connection = null;

		String JndiDataSourceName = "";
		
		if (profile.equals("admin")) {
			JndiDataSourceName = "eCommerceAdminDS";
		}
		if (profile.equals("client")) {
			JndiDataSourceName = "eCommerceClientDS";
		}
		if (profile.equals("guest")) {
			JndiDataSourceName = "eCommerceGuestDS";
		}
		
		System.out.println(JndiDataSourceName);
		
		try {
			InitialContext ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:jboss/"+ JndiDataSourceName);
			connection = ds.getConnection();
		} catch (Exception e) {
			System.out.println("Error: " + e.toString());
		}	
		
		return connection;
	}
