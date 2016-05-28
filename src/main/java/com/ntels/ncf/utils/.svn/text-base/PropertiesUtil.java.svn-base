package com.ntels.ncf.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Properties;

/**
 * 
 * @author smyun@ntels.com
 *
 */
public class PropertiesUtil {
	private static HashMap<String, Properties> propses;
	
	
	public static String get(String prop, String key){
		
		if(load(prop) == true){
			return propses.get(prop).getProperty(key);
		}else{
			return "";
		}
	}
	
	/**
	 * Properties 가 적재되어 있는지 확인
	 * 적재되어 있지 않다면 적재함.
	 * properties 파일이 없을 경우 false return.
	 * 
	 * @param prop
	 * @return
	 */
	private static boolean load(String prop){
		
		// 초기화
		if(propses == null){
			init();
		}
		
		if(propses.containsKey(prop)){
			return true;
		}else{
			try{
				StringBuilder path = new StringBuilder();
//				path.append("config/")
//				.append(prop)
//				.append(".properties");
				
				path.append(System.getProperty("catalina.base"))
					.append(File.separator + "webapps")
					.append(File.separator + "config")
					.append(File.separator + prop)
					.append(".properties");
				

			    InputStream is = new FileInputStream(path.toString());
//				InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream(path.toString());
			    Properties props = new Properties();
			    props.load(is);
	
			    propses.put(prop, props);
			    
			    is.close();

			    return true;			    
			}catch(Exception e){
				e.printStackTrace();
				return false;
			}
		}
	}

	
	/**
	 *  초기화
	 *  
	 */
	private static void init(){
		propses = new HashMap<String, Properties>();
	}
}
