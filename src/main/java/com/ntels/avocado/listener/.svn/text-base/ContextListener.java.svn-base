package com.ntels.avocado.listener;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


public class ContextListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	public void contextInitialized(ServletContextEvent sce) {
		try {
			StringBuilder sb = new StringBuilder();
			sb.append(System.getProperty("catalina.home"));
			sb.append(File.separator + "webapps"+File.separator +"configuration"+File.separator +"configuration-properties.xml");
			
			File file = new File(sb.toString());
			FileInputStream fileInput = new FileInputStream(file);
			Properties properties = new Properties();
			properties.loadFromXML(fileInput);
			fileInput.close();
			
			Enumeration<Object> enuKeys = properties.keys();
			String key;
			while (enuKeys.hasMoreElements()) {
				key = (String) enuKeys.nextElement();
				if ("websocket.connect.url".equals(key)) {
					sce.getServletContext().setAttribute(key, properties.getProperty(key));
					break;
				}				
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	


	

}
