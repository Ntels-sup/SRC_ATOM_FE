package com.ntels.ncf.utils;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBaseProviderTest {
	public static void main(String[] args) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con;
			try {
				con = DriverManager.getConnection("jdbc:oracle:thin:@61.40.220.35:1521:orcl","OFCS","OFCS");
				DatabaseMetaData databaseMetaData = con.getMetaData(); 
				System.err.println(databaseMetaData.getDatabaseProductName()); 
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
