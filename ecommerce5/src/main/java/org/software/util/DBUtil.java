package org.software.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.sql.Statement;
//import java.sql.Timestamp;
//import java.text.SimpleDateFormat;

public class DBUtil {
	
	public String getValue(String sql, String id) {
	
		String value = "";
				
		DataBase database = new DataBase();
		Connection connection1 = null;
		PreparedStatement preparedStatement1 = null;
		ResultSet rs1 = null;
		
		try {
			connection1 = database.getConnection("admin");
			
			preparedStatement1 = connection1.prepareStatement(sql);
			preparedStatement1.setString(1, id);
			rs1 = preparedStatement1.executeQuery();

			while (rs1.next()) {
				value = rs1.getString(1);
			}
		} catch (Exception e) {
			System.out.println("Error: " + e.toString());
		}
		finally {
			database.closeObject(rs1);
			database.closeObject(preparedStatement1);
			database.closeObject(connection1);
		}
		
		return value;
	}

}
