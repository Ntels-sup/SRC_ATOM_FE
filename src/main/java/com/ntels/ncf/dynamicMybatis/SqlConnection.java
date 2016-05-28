package com.ntels.ncf.dynamicMybatis;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.sql.DataSource;

import org.apache.ibatis.mapping.Environment;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.transaction.TransactionFactory;
import org.apache.ibatis.transaction.jdbc.JdbcTransactionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ntels.ncf.utils.database.DBUtil;


public class SqlConnection {
	private static Logger logger = LoggerFactory.getLogger(SqlConnection.class);
	//private static Logger logger = Logger.getLogger(SqlConnection.class);

	private static SqlConnection sqlFactory = null;
	private static HashMap<String,SqlSessionFactory> factoryMap=new HashMap<String,SqlSessionFactory>();

	private static String driverClass;
	private static String jdbcURL;
	private static String username;
	private static String password;
	private static String dynamicMybatisMapper;

	private static HashMap<String, DataSource> remoteDBInfo = new HashMap<String, DataSource>();

	private SqlConnection() {
	}
	
	private static SqlConnection getInstance(String system_id) throws IOException {
		logger.debug("system_id = {}", system_id);
		
		SqlSessionFactory sessionFactory = null;
		
		if(factoryMap.get(system_id) == null){
			Configuration configuration = getConfiguration(system_id);
			sqlFactory = new SqlConnection();
			sessionFactory = new SqlSessionFactoryBuilder().build(configuration);
			factoryMap.put(system_id, sessionFactory);
		}
		return sqlFactory;
	}
 
	public static synchronized SqlSessionFactory getSessionFactory(String system_id) throws IOException {
		logger.debug("system_id = {}, factoryMap.get(system_id) == null {}",system_id, (factoryMap.get(system_id) == null)+"");
		
		if(factoryMap.get(system_id) == null) {
			getInstance(system_id);
		}
		//if(DBUtil.checkConnection(remoteDBInfo.get(system_id))==false)return null;
		return factoryMap.get(system_id);
	}
 
	public Object clone() throws CloneNotSupportedException {
		logger.debug("{}","check");
		
		throw new CloneNotSupportedException();
	}


	private static Configuration getConfiguration(String system_id) {
		logger.debug("{} system_id = {}","check", system_id);
		ResultSet rs = null;
		
		Configuration configuration = null;
		Connection conn=DBUtil.openDB(driverClass, jdbcURL, username, password);
		
		if (conn != null) {
			try {
				PreparedStatement pstmt = null;
				rs = null;
				pstmt = (PreparedStatement) conn
						.prepareStatement("SELECT SYSTEM_ID,JDBC_DRIVER,JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD FROM T_NFW_EMS_SYSTEM WHERE SYSTEM_ID='"+system_id+"'");
				rs = pstmt.executeQuery();
				
				DataSource dataSource = null;
				while (rs.next()) {
					dataSource = DBUtil.makeDataSource(rs.getString("JDBC_DRIVER"), 
						rs.getString("JDBC_URL"), 
						rs.getString("JDBC_USERNAME"), 
						rs.getString("JDBC_PASSWORD"));
					
					remoteDBInfo.put(system_id,dataSource);
				}
				
				TransactionFactory transactionFactory = new JdbcTransactionFactory();
				Environment environment = new Environment("pfnm",
						transactionFactory, dataSource);

				configuration = new Configuration(environment);
				configuration.setDefaultStatementTimeout(1000);
				configuration.setCacheEnabled(true);

				List<String> mapperList = new ArrayList<String>();
				try {
					BufferedReader in = new BufferedReader(new FileReader(
							dynamicMybatisMapper));
					String mapperClassString;

					while ((mapperClassString = in.readLine()) != null) {
						if (mapperClassString != null
								&& mapperClassString.isEmpty() == false) {
							logger.info("mapperClassString=>{}", mapperClassString);
							mapperList.add(mapperClassString);
						}
					}
					in.close();
					// //////////////////////////////////////////////////////////////
				} catch (IOException e) {
					logger.debug("{}", e); // 에러가 있다면 메시지 출력
					DBUtil.closeDB(conn);
					return null;
				}

				for (int i = 0; i < mapperList.size(); i++) {
					configuration.addMapper(Class.forName((String) mapperList
							.get(i)));
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
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				rs = null;
			}
			DBUtil.closeDB(conn);
		}

		return configuration;
	}

	public static void setDriverClass(String driverClass) {
		logger.debug("{} {}","check", driverClass);
		SqlConnection.driverClass = driverClass;
	}
	public static void setJdbcURL(String jdbcURL) {
		logger.debug("{} {} ","check", jdbcURL);
		SqlConnection.jdbcURL = jdbcURL;
	}
	public static void setUsername(String username) {
		logger.debug("{} {}","check", username);
		SqlConnection.username = username;
	}
	public static void setPassword(String password) {
		logger.debug("{} {}","check", password);
		SqlConnection.password = password;
	}		
	public static void setDynamicMybatisMapper(String dynamicMybatisMapper) {
		logger.debug("{} {}","check", dynamicMybatisMapper);
		SqlConnection.dynamicMybatisMapper = dynamicMybatisMapper;
	}

}
