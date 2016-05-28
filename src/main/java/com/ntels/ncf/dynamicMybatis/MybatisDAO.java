package com.ntels.ncf.dynamicMybatis;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletContext;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;

import com.ntels.ncf.utils.PropertiesUtil;

public abstract class MybatisDAO {
	private static Logger logger = LoggerFactory.getLogger(MybatisDAO.class);
	
	@Autowired
	private ServletContext servletContext;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public SqlSession getSqlSession(String system_id){
		logger.debug("check");
		
		
		if(system_id==null || "".equals(system_id))return null;
		
		SqlSession session = null;
		
		if(servletContext==null){
			return session;
		}
		
		if(servletContext.getAttribute("sqlSessionFactoryMap")==null){
			boolean madeSession = reset();
			if(madeSession==false){
				return null;
			}
		}
		HashMap<String,SqlSessionFactory> sqlSessionFactoryMap=(HashMap) servletContext.getAttribute("sqlSessionFactoryMap");
		try {
			SqlSessionFactory sqlSessionFactory = sqlSessionFactoryMap.get(system_id);
			//SqlSessionFactory sqlSessionFactory;
			try {
				//sqlSessionFactory = SqlConnection.getSessionFactory(system_id);
				if(sqlSessionFactory!=null){
					session = sqlSessionFactory.openSession(true);
				}
			} catch (Exception e) {
				
				e.printStackTrace();
				return null;
			}
		} catch (PersistenceException e) {
			e.printStackTrace();
			return null;
		}
		
		return session;
	}
	public void closeSession(SqlSession session){
		if(session != null){
			logger.debug("check {}",session.getConfiguration());

			session.close();
			session=null;
		}
	}
	
		
	private boolean reset(){
		logger.debug("check {}");
		
		try {
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
			} catch (IOException e) {
				
				e.printStackTrace();
			}
			
			SqlSessionFactoryManager dynamicDBManager = new SqlSessionFactoryManager(jdbcDriverClass, jdbcURL, id, password, dynamicMybatisMapper);
			
			//DB로부터 세션팩토리맵을 만들어 저장함
			HashMap<String,SqlSessionFactory> sqlSessionFactoryMap = dynamicDBManager.reloadSessionFactory();
			
			servletContext.setAttribute("sqlSessionFactoryMap", sqlSessionFactoryMap);
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
	}
	
}
