package com.ntels.avocado;

import static org.junit.Assert.assertEquals;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/datasource-config.xml",
        "classpath:/junit_test/root-context.xml"
})
@WebAppConfiguration
public class PropertiesTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Value("#{configuration['jdbc.driverClass.master']}")
	private String driverClass;
	
	@Value("#{configuration['jdbc.url.master']}")
	private String jdbcURL;
    
	@Value("#{configuration['jdbc.username.master']}")
	private String id;
	
	@Value("#{configuration['jdbc.password.master']}")
	private String password;
	
	@Test
	public void test() {

		logger.debug( "driverClass : " + driverClass );
		logger.debug( "jdbcURL : " + jdbcURL );
		logger.debug( "id : " + id );
		logger.debug( "password : " + password );

		assertEquals( "com.mysql.jdbc.Driver", driverClass );
		assertEquals( "jdbc:mysql://61.40.220.43:3306/ATOM", jdbcURL );
		assertEquals( "atom", id );
		assertEquals( "atom", password );
	}

}
