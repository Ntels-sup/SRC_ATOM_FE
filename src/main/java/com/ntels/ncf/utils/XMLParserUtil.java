package com.ntels.ncf.utils;

import java.io.File;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.ntels.avocado.domain.common.ConfigVO;
import com.ntels.avocado.exception.AtomException;

//import com.ntels.constants.LoggingWriter;
//import com.ntels.exception.ExceptionCode;
//import com.ntels.exception.ExceptionManager;
//import com.ntels.model.ConfigProperties;
//import com.ntels.model.ConfigVO;

public class XMLParserUtil {
	
	private static final Logger logger = Logger.getLogger(XMLParserUtil.class);
	private static final DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	private DocumentBuilder builder;
	private Document document;
	
	public XMLParserUtil() {
		try {
			StringBuilder sb = new StringBuilder();
			//sb.append(System.getenv("CATALINA_BASE"));
			sb.append(System.getProperty("catalina.home"));
			sb.append(File.separator + "webapps"+File.separator +"configuration"+File.separator +"configuration-properties.xml");
			
			logger.debug( "xml file : " + sb.toString() );
				
			builder = factory.newDocumentBuilder();
			document = builder.parse(new File(sb.toString()));
			
			logger.debug( "XML file name : " + sb.toString() );
			
			//Normalize the XML Structure; It's just too important !!
			document.getDocumentElement().normalize();
			//root = document.getDocumentElement();
			
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			throw new AtomException("XMLParserUtil Create IOException... " + e.getMessage() );
		}
	}
	
	public ConfigVO JDBCParse() {
		
		ConfigVO config = null;		
		
		try {
			NodeList nList = document.getElementsByTagName("entry");
			
			config 			= new ConfigVO(); 
			Node node 		= null;
			Element element = null;			
			
			for (int i = 0; i < nList.getLength(); i++) {
				
				node 	= nList.item(i);
				element = (Element) node;
				
				if( element.getAttribute("key").equals("jdbc.driverClass.master") )
					config.setDriverClass( element.getTextContent() );
				if( element.getAttribute("key").equals("jdbc.url.master") ) 
					config.setUrl( element.getTextContent() );
				if( element.getAttribute("key").equals("jdbc.username.master") ) 
					config.setUsername( element.getTextContent() );
				if( element.getAttribute("key").equals("jdbc.password.master") ) 
					config.setPassword( element.getTextContent() );				
			}
		} 
		catch (NullPointerException e) {
			throw new AtomException("XMLParserUtil JDBCParse NullPointerException.... " + e.getMessage() );
		}		
		
		return config;
	}
}
