package com.ntels.ncf.dynamicMybatis;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.ntels.ncf.utils.database.DBUtil;


@Component
public class SqlSessionFactoryManager {

	private Logger logger = LoggerFactory.getLogger(SqlSessionFactoryManager.class);

	Connection conn = null;

	private String driverClass;
	private String jdbcURL;
	private String username;
	private String password;
	private String dynamicMybatisMapper;

	public SqlSessionFactoryManager() {
		super();
	}

	public SqlSessionFactoryManager(String driverClass, String jdbcURL,
			String username, String password, String dynamicMybatisMapper) {
		
		super();
		
		logger.debug("{}","\nsuper();\nthis.driverClass = driverClass;\nthis.jdbcURL = jdbcURL;\nthis.username = username;\nthis.password = password;\nthis.dynamicMybatisMapper = dynamicMybatisMapper;\n");
		
		this.driverClass = driverClass;
		this.jdbcURL = jdbcURL;
		this.username = username;
		this.password = password;
		this.dynamicMybatisMapper = dynamicMybatisMapper;
	}

	// SessionFactory를 모은 HashMap 생성
	public HashMap<String, SqlSessionFactory> reloadSessionFactory() {
		logger.debug("{}","check");
		
		HashMap<String, SqlSessionFactory> sqlSessionFactoryMap = new HashMap<String, SqlSessionFactory>();
		Connection conn=DBUtil.openDB(driverClass, jdbcURL, username, password);
		
		if (conn != null) {
			ResultSet rs = null;
			try {
				PreparedStatement pstmt = null;

				pstmt = (PreparedStatement) conn
						.prepareStatement("SELECT SYSTEM_ID FROM T_NFW_EMS_SYSTEM");
				rs = pstmt.executeQuery();
				while (rs.next()) {

					SqlConnection.setDriverClass(driverClass);
					SqlConnection.setJdbcURL(jdbcURL);
					SqlConnection.setUsername(username);
					SqlConnection.setPassword(password);
					SqlConnection.setDynamicMybatisMapper(dynamicMybatisMapper);

					sqlSessionFactoryMap.put(rs.getString("SYSTEM_ID"), SqlConnection.getSessionFactory(rs.getString("SYSTEM_ID")) );
				}
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException e1) {
						e1.printStackTrace();
						DBUtil.closeDB(conn);
					}
					rs = null;
				}
			} catch (Exception e) {

				e.printStackTrace();

				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
					rs = null;
				}
				DBUtil.closeDB(conn);
				return null;
			}
			DBUtil.closeDB(conn);
		}
				
		return sqlSessionFactoryMap;
	}	
	
}
