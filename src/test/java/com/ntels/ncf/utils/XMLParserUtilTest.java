package com.ntels.ncf.utils;

import static org.junit.Assert.assertNotNull;

import java.util.Properties;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.ntels.avocado.domain.common.ConfigVO;

public class XMLParserUtilTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Test
	public void testXMLParserUtil() {
		
		//-Dcatalina.home=C:\java\workspace_mars\atom_project\configuration
		
		Properties props = new Properties();
		props.setProperty("catalina.home", "C:\\java\\workspace_mars\\atom_project\\configuration");
		System.setProperties(props);
		
		XMLParserUtil xml = new XMLParserUtil();
		
		//logger.debug( "catalina.home : " + System.getProperty("catalina.home"));
		
		assertNotNull(xml);
		
	}

	@Test
	public void testJDBCParse() {
				
		Properties props = new Properties();
		props.setProperty("catalina.home", "C:\\java\\workspace_mars\\atom_project\\configuration");
		System.setProperties(props);
		
		XMLParserUtil xml = new XMLParserUtil();
		
		ConfigVO config = xml.JDBCParse();
		
		logger.debug( "driverClass : " + config.getDriverClass() );
		logger.debug( "url : " + config.getUrl() );
		logger.debug( "username : " + config.getUsername() );
		logger.debug( "password : " + config.getPassword() );
		
		assertNotNull(config);
	}

}
