package com.ntels.avocado.listener;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.common.ConfigVO;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.ncf.utils.XMLParserUtil;

public class SessionListener implements HttpSessionListener {

	private Logger logger = Logger.getLogger(this.getClass());
	
	private Connection conn;
	
	public void sessionCreated(HttpSessionEvent hse) {}

	public void sessionDestroyed(HttpSessionEvent hse) {
        
    	 HttpSession session= hse.getSession();
         SessionUser user 	= (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
         
         if( user!=null ) {
//        	 WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
//             UserDestoryService userDestoryService = (UserDestoryService)ctx.getBean("userDestoryService");
//             userDestoryService.userDestoryHistory(user, session.getId());
        	 
        	 ConfigVO dbInfo = (new XMLParserUtil()).JDBCParse();
        	 
        	 openDB(dbInfo);
        	 userCloseHistory(user, session.getId());
 			 closeDB();
         }
    }
	
	private void userCloseHistory(SessionUser user, String session_id) {
		if (conn != null) {
			PreparedStatement pstmt = null;
			
			logger.debug("===================CLOSE SESSION===========================");
			
			try {
				//pstmt = (PreparedStatement) conn.prepareStatement("UPDATE T_NFW_USER_SESSION SET STATUS = 'N' WHERE USER_ID = '" + user.getUser_id() + "'");
				//pstmt = (PreparedStatement) conn.prepareStatement("UPDATE TAT_USER_SESSION SET STATUS = 'N' WHERE USER_ID = '" + user.getUserId() + "' AND SESSION_ID='"+session_id+"' AND TYPE = 0");
				pstmt = (PreparedStatement) conn.prepareStatement("DELETE FROM TAT_USER_SESSION WHERE USER_ID = '" + user.getUserId() + "' AND SESSION_ID='"+session_id+"' AND TYPE = 0");
				int rst = pstmt.executeUpdate();
				
				logger.debug( "userId : " + user.getUserId() );
				logger.debug( "userLoginDate : " + user.getUserLoginDate()  );
				logger.debug( "loginGatewayIp : " + user.getUserIpAddress() );
				logger.debug( "session_id : " + session_id );
				
				if (rst > 0) {
					
					pstmt = (PreparedStatement) conn.prepareStatement("UPDATE TAT_USER SET LOGIN_COUNT = LOGIN_COUNT-1 WHERE USER_ID = '" + user.getUserId() + "'");
					pstmt.executeUpdate();
					
					pstmt = (PreparedStatement) conn.prepareStatement("SELECT LOGOUT_RESULT FROM TAT_LOGIN_HIST WHERE USER_ID = '"+
							user.getUserId()+"' AND LOGIN_DATE=STR_TO_DATE('"+user.getUserLoginDate()+"','%Y%m%d %H%i%s')");
					ResultSet rs = pstmt.executeQuery();
					while( rs.next() ) {
						String logoutResult = rs.getString("LOGOUT_RESULT");
	
						logger.debug( "[mirinae.maru] logoutResult : " + logoutResult );
						
						if( logoutResult==null || logoutResult.equals(Consts.EMPTY_STRING)) {
							logger.debug( "[mirinae.maru] 로그아웃 처리해야됨" );
						}
						else {
							logger.debug( "[mirinae.maru] 이미 로그아웃 처리됨" );
						}
						
						if( logoutResult==null || logoutResult.equals(Consts.EMPTY_STRING)) {
							logger.debug("UPDATE TAT_LOGIN_HIST");
							pstmt = (PreparedStatement) conn
									.prepareStatement("UPDATE TAT_LOGIN_HIST SET LOGOUT_DATE = NOW(), LOGOUT_RESULT = '" + Consts.LOGOUT_RESULT.ABNORMAL+ "'"	// 사용자가 브라우저를 닫을 경우.
											+ "WHERE USER_ID = '"
											+ user.getUserId()
											+ "' AND LOGIN_DATE = STR_TO_DATE( '" 
											+ user.getUserLoginDate()
											+ "', '%Y%m%d %H%i%s')"
											+ " AND LOGIN_IP = '"
											+ user.getUserIpAddress()
											+ "'" );
							pstmt.executeUpdate();
						}
					}
				} else {
					logger.debug("No UPDATE TAT_LOGIN_HIST");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			logger.debug("===================CLOSE SESSION LOGGING===================");
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
}
