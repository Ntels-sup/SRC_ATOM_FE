package com.ntels.avocado.listener;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.factory.annotation.Autowired;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.common.ConfigVO;
import com.ntels.ncf.utils.XMLParserUtil;

public class StartupListener implements ServletContextListener {
	
	private Connection conn = null;
	
	@Autowired
	public void contextInitialized(ServletContextEvent event) {
		
		ConfigVO dbInfo = (new XMLParserUtil()).JDBCParse();

		openDB(dbInfo);
		clearSessionInfo();
		closeDB();
	}
	
	private void clearSessionInfo() {
		if (conn != null) {
			PreparedStatement pstmt = null;
			try {
				
				//pstmt = (PreparedStatement) conn.prepareStatement("UPDATE T_NFW_USER_SESSION SET STATUS = 'N' WHERE STATUS = 'Y' AND TYPE = 0 AND SESSION_ID IS NOT NULL");
				//pstmt = (PreparedStatement) conn.prepareStatement("UPDATE TAT_USER_SESSION SET STATUS = 'N' WHERE STATUS = 'Y' AND TYPE = 0 AND SESSION_ID IS NOT NULL AND USER_ID = 'nextman'");
				pstmt = (PreparedStatement) conn.prepareStatement("DELETE FROM TAT_USER_SESSION WHERE STATUS = 'Y' AND TYPE = 0 AND SESSION_ID IS NOT NULL AND USER_ID = 'h'");
//				pstmt = (PreparedStatement) conn.prepareStatement("DELETE FROM TAT_USER_SESSION WHERE STATUS = 'Y' AND TYPE = 0 AND SESSION_ID IS NOT NULL");
				pstmt.executeUpdate();
				
				pstmt = (PreparedStatement) conn.prepareStatement("UPDATE TAT_USER SET RETRY_COUNT = 0, LOGIN_COUNT = 0 WHERE USER_ID = 'h'");
				//pstmt = (PreparedStatement) conn.prepareStatement("UPDATE TAT_USER SET RETRY_COUNT = 0, LOGIN_COUNT = 0");
				pstmt.executeUpdate();
				
				pstmt = (PreparedStatement) conn.prepareStatement("UPDATE TAT_LOGIN_HIST SET LOGOUT_DATE = NOW(), LOGOUT_RESULT = '"+Consts.LOGOUT_RESULT.BY_ADMIN+"' WHERE LOGIN_RESULT = 'Y' AND LOGOUT_DATE IS NULL AND USER_ID = 'h'");
//				pstmt = (PreparedStatement) conn.prepareStatement("UPDATE TAT_LOGIN_HIST SET LOGOUT_DATE = NOW(), LOGOUT_RESULT = '"+Consts.LOGOUT_RESULT.BY_ADMIN+"' WHERE LOGIN_RESULT = 'Y' AND LOGOUT_DATE IS NULL");
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}


	private void openDB(ConfigVO dbInfo) {

		try {
			try {
				java.sql.Driver mySQLDriver = (Driver) Class.forName(dbInfo.getDriverClass()).newInstance();
				DriverManager.registerDriver(mySQLDriver);
			} catch (Exception e) {
				e.printStackTrace();
			}
			conn = DriverManager.getConnection(dbInfo.getUrl(), dbInfo.getUsername(), dbInfo.getPassword());

		} 
		catch (SQLException sqle) {
			sqle.printStackTrace();
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void closeDB() {
		try {
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	public void contextDestroyed(ServletContextEvent arg0) {
		
	}
}
