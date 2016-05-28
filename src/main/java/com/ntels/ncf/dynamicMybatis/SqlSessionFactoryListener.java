package com.ntels.ncf.dynamicMybatis;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;

import com.ntels.ncf.utils.PropertiesUtil;

public class SqlSessionFactoryListener implements ServletContextListener {
	private Logger log = LoggerFactory.getLogger(SqlSessionFactoryManager.class);

	
	public void contextInitialized(ServletContextEvent event) {
		log.debug("{}","check");
		ServletContext sc = event.getServletContext();
		
		String propName = "jdbc";
		
		String jdbcDriverClass = PropertiesUtil.get(propName, "jdbc.driverClass");
		String jdbcURL = PropertiesUtil.get(propName, "jdbc.url");
		String id = PropertiesUtil.get(propName, "jdbc.username");
		String password = PropertiesUtil.get(propName, "jdbc.password");
		String dynamicMybatisMapperProperty = PropertiesUtil.get(propName, "dynamicMybatisMapper.path");

		ClassPathResource resource = new ClassPathResource(dynamicMybatisMapperProperty, this.getClass());

		String dynamicMybatisMapper=null;
		try {
			dynamicMybatisMapper = resource.getFile().getAbsolutePath();
			//logger.debug("dynamicMybatisMapper===>"+resource.getFile().getAbsolutePath());
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
		//
		SqlSessionFactoryManager dynamicDBManager = new SqlSessionFactoryManager(jdbcDriverClass, jdbcURL, id, password, dynamicMybatisMapper);
		
		//DB로부터 세션팩토리맵을 만들어 저장함
		HashMap<String,SqlSessionFactory> sqlSessionFactoryMap = dynamicDBManager.reloadSessionFactory();
		
		sc.setAttribute("sqlSessionFactoryMap", sqlSessionFactoryMap);
	}

	public void contextDestroyed(ServletContextEvent event) {
		log.debug("{}","check");
		ServletContext sc = event.getServletContext();
		sc.removeAttribute("sqlSessionFactoryMap");
	}

}
