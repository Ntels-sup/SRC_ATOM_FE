package com.ntels.ncf.dynamicMybatis;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connect {
	static Connect c;

	// 내부망
	String dbDriver;
	String dbURL;
	String dbId;
	String dbPwd;
	Connection conn;
	long startTime;
	final int LIMIT_TIME = 2000; // DB 상태 확인 제한 시간 2초
	final int CHECK_INTERVAL = 5000; // 체크 주기 5초
	Thread check;

	// 외부망
	// String dbURL = "jdbc:Altibase://60.11.40.134:20300/mydb";

	private Connect() {
	}

	public static Connect getInstance() {
		if (c == null)
			c = new Connect();

		return c;
	}

	public static void main(String[] av) {
		try {
			Connect c = Connect.getInstance();

			String url = "jdbc:Altibase://192.168.1.202:20300/oanm";
			String driver = "Altibase.jdbc.driver.AltibaseDriver";
			String id = "pcrf2";
			String pwd = "pcrf1234";

			c.checkDBConn(driver, url, id, pwd);
			c.checkDBConn(driver, url, id, pwd);
			c.checkDBConn(driver, url, id, pwd);
			c.checkDBConn(driver, url, id, pwd);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@SuppressWarnings("deprecation")
	public void checkDBConn(String driver, String url, String id, String pwd) {
		if(check != null && check.isAlive()){
			return;
		}

		this.dbDriver = driver;
		this.dbURL = url;
		this.dbId = id;
		this.dbPwd = pwd;

		this.check = null;
		this.check = new Thread(new Runnable() {
			// @Override
			public void run() {
				while (true) {
					try {
						// Load the jdbc-odbc bridge driver
						Class.forName(dbDriver);

						// Enable logging
						DriverManager.setLogWriter(new PrintWriter((System.err)));

						Thread x = new Thread(new Runnable() {
							// @Override
							public void run() {
								try {
									startTime = System.currentTimeMillis();
									conn = null;
									conn = DriverManager.getConnection(dbURL, dbId, dbPwd); // user,
								} catch (Exception e) {
									e.printStackTrace();
								}
							}
						});

						x.start();
						// 확인대기 시간 2초
						Thread.sleep(LIMIT_TIME);
						x.stop();

						if (conn == null) {
							System.out.println("Connection not connected !!");
						} else {
							System.out.println("Connection connected !!");
							conn.close();
						}

						// 5초간 (반복주기) 대기
						Thread.sleep(CHECK_INTERVAL);
					} catch (ClassNotFoundException e) {
						System.out.println("Can't load driver " + e);
					} catch (SQLException e) {
						System.out.println("Database access failed " + e);
					} catch (Exception e) {
						System.out.println("Exception Fail : " + e);
					} finally{
						try {
							conn.close();
						} catch (SQLException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}
					}
				}

				// stop = false;
			}
		}, "checkDBConn");

		this.check.start();
	}
}