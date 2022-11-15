package org.software.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
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
		
		System.out.println("JndiDataSourceName: " + JndiDataSourceName);
		
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/" + JndiDataSourceName);
			
			connection = ds.getConnection();
			
		} catch (Exception e) {
			System.out.println("Error: " + e.toString());
		}
		return connection;
	}

	public void closeObject(Connection connection) {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void closeObject(PreparedStatement preparedStatement) {
		try {
			preparedStatement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void closeObject(Statement statement) {
		try {
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void closeObject(ResultSet resultSet) {
		try {
			resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
