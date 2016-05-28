package com.ntels.ncf.utils.database;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.SQLWarning;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;

public class DBUtil {
	private static Logger log = LoggerFactory.getLogger(DBUtil.class);
	
	public static boolean checkConnection(String driver,String url,String id,String pass) {
		log.debug("{}","check");
		try {

			Class.forName(driver);

			// Enable logging
			DriverManager.setLogWriter(new PrintWriter((System.err)));

			Connection conn = DriverManager.getConnection(url, id, pass); // user,
			// passwd

			// If a SQLWarning object is available, print its
			// warning(s). There may be multiple warnings chained.

			SQLWarning warn = conn.getWarnings();
			while (warn != null) {
				System.out.println("SQLState: " + warn.getSQLState());
				System.out.println("Message:  " + warn.getMessage());
				System.out.println("Vendor:   " + warn.getErrorCode());
				System.out.println("");
				warn = warn.getNextWarning();
			}

			// Do something with the connection here...

			conn.close(); // All done with that DB connection
			
			return true;

		} catch (ClassNotFoundException e) {
			System.out.println("Can't load driver " + e);
			return false;
		} catch (SQLException e) {
			System.out.println("Database access failed " + e);
			return false;
		} catch (Exception e){
			System.out.println("Runtime Exception " + e);
			return false;
		}
	}

	
	public static boolean checkConnection(DataSource dataSource) {
		log.debug("{}","check");
		try {

			Connection conn = dataSource.getConnection();

			SQLWarning warn = conn.getWarnings();
			while (warn != null) {
				System.out.println("SQLState: " + warn.getSQLState());
				System.out.println("Message:  " + warn.getMessage());
				System.out.println("Vendor:   " + warn.getErrorCode());
				System.out.println("");
				warn = warn.getNextWarning();
			}

			// Do something with the connection here...

			conn.close(); // All done with that DB connection
			
			return true;

		} catch (SQLException e) {
			System.out.println("Database access failed " + e);
			return false;
		} catch (Exception e){
			System.out.println("Runtime Exception " + e);
			return false;
		}
	}
	// DataSource 생성
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static DataSource makeDataSource(String driverClass, String url,String username, String password) {
		log.debug("{}","check");
		try {
			SimpleDriverDataSource ds = new SimpleDriverDataSource();
			Class driver;
			driver = Class.forName(driverClass);
			ds.setDriverClass(driver);
			ds.setUrl(url);
			ds.setUsername(username);
			ds.setPassword(password);
			return ds;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static Connection openDB(String driverClass,String jdbcURL,String username,String password) {
		log.debug("{}","check");
		
		Connection conn=null;
		try {
			try {
				java.sql.Driver mySQLDriver = (Driver) Class.forName(
						driverClass).newInstance();
				DriverManager.registerDriver(mySQLDriver);
			} catch (Exception e) {
				e.printStackTrace();
			}
			conn = DriverManager.getConnection(jdbcURL, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static void closeDB(Connection conn) {
		log.debug("{}","check");
		
		try {
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
