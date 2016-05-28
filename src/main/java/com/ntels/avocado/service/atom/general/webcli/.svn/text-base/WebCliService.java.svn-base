/*****************************************************************************************
 * Copyright (c) 2011 nTels, All rights reserved.
 *
 * xxx 하기 위한 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  :
 * @버전  :
 * @작성일 : 2011. 10. 7
 *   
 * @작업 완료
 *    일자 : 내역을 적으세요
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.service.atom.general.webcli;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.dao.atom.general.webcli.WebCliMapper;
import com.ntels.avocado.domain.atom.general.webcli.WebCliDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.exception.AtomException;

// TODO: Auto-generated Javadoc
/**
 * The Class DiameterTraceService.
 */
@Service
public class WebCliService {

	/** The diameter trace mapper. */
	@Autowired
	private WebCliMapper commandLineMapper;
	
	/**
	 * ********************************************************************************************.
	 *
	 * @return the list
	 * @throws AtomException the pfnm exception
	 */
	
	public List<Map<String, String>> tableSel() throws AtomException {
		return commandLineMapper.tableSel();
	}		
	
	/**
	 * Xml table.
	 *
	 * @return the list
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, String>> xmlTable() throws AtomException {
		return commandLineMapper.xmlTable();
	}	
	
	/**
	 * Xml component.
	 *
	 * @param tableSel the table sel
	 * @return the list
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, String>> xmlComponent(String tableSel) throws AtomException {
		return commandLineMapper.xmlComponent(tableSel);
	}	
	
	/**
	 * Gets the service name.
	 *
	 * @return the service name
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, String>> getServiceName() throws AtomException {
		return commandLineMapper.getServiceName();
	}		
	
	/**
	 * Gets the cmd list
	 *
	 * @return the cmd list
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, String>> listCMD(String node_name) throws AtomException {
		return commandLineMapper.listCMD(node_name);
	}			
	
	/**
	 * get pkg name
	 */
	public String getPkgName(String node_name) throws AtomException {
		return commandLineMapper.getPkgName(node_name);
	}				
	
	/**
	 * get node_no
	 */
	public String getNodeNo(String node_name) throws AtomException {
		return commandLineMapper.getNodeNo(node_name);
	}			
	
	/**
	 * get cmd_ems_destination
	 */
	public String getCmdEmsDestination(String cmd_code,String pkg_name) throws AtomException {
		return commandLineMapper.getCmdEmsDestination(cmd_code, pkg_name);
	}		
	
	/**
	 * Gets the service list
	 *
	 * @return the service list
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, String>> listService(String pkg_name) throws AtomException {
		return commandLineMapper.listService(pkg_name);
	}			
	
	/**
	 * Gets the process list
	 *
	 * @return the process list
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, String>> listProcess(String node_name, String svc_no) throws AtomException {
		return commandLineMapper.listProcess(node_name, svc_no);
	}	
	
	/**
	 * Gets the process name.
	 *
	 * @return the process name
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, String>> getProcessName() throws AtomException {
		return commandLineMapper.getProcessName();
	}	
	
	/**
	 * Gets the component name.
	 *
	 * @return the component name
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, String>> getComponentName() throws AtomException {
		return commandLineMapper.getComponentName();
	}		
	
	public List<Map<String, String>> getQueueName() throws AtomException {
		return commandLineMapper.getQueueName();
	}	
	
	/**
	 * ********************************************************************************************.
	 *
	 * @param keywords the keywords
	 * @param command_type the command_type
	 * @return the keywords
	 * @throws AtomException the pfnm exception
	 */
	
	/**
	 * Gets the keywords.
	 *
	 * @param keywords the keywords
	 * @param command_type the command_type
	 * @return the keywords
	 */
	public List<String> getKeywords(String keywords, String command_type) throws AtomException {
		return commandLineMapper.getKeywords(keywords, command_type);
	}	
	
	/**
	 * Gets the commands.
	 *
	 * @param user_group the user_group
	 * @return the commands
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, Object>> listCommands(String user_group_level) throws AtomException {
		return commandLineMapper.listCommands(user_group_level);
	}	
		
	/**
	 * Gets the input format.
	 *
	 * @return the input format list
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, Object>> listInputFormat() throws AtomException {
		return commandLineMapper.listInputFormat();
	}	
	
	/**
	 * List commands.
	 *
	 * @param command the command
	 * @return the list
	 * 
	 * 설명 :
	 * @throws AtomException the pfnm exception
	 */
	public Map<String, Object> getCommand(String command) throws AtomException {
		return commandLineMapper.getCommand(command);
	}
	
	/**
	 * System count.
	 *
	 * @param argument the argument
	 * @return the int
	 * 
	 * 설명 :
	 * @throws AtomException the pfnm exception
	 */
	public int systemCount(String argument) throws AtomException {
		return commandLineMapper.systemCount(argument);
	}
	
	/**
	 * List.
	 *
	 * @param user_id the user_id
	 * @return the list
	 * 
	 * 설명 :
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, Object>> listHistory(String user_id) throws AtomException {
		return commandLineMapper.listHistory(user_id);
	}
	
	/**
	 * List trace.
	 *
	 * @param system_id the system_id
	 * @param package_id the package_id
	 * @return the list
	 * 
	 * 설명 :
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, Object>> listTrace(String system_id, String package_id) throws AtomException {
		return commandLineMapper.listTrace(system_id, package_id);
	}
	
	/**
	 * Dist xml.
	 *
	 * @param system_id the system_id
	 * @param package_id the package_id
	 * @return the int
	 * 
	 * 설명 :
	 * @throws AtomException the pfnm exception
	 */
	public int distXml(String system_id, String package_id) throws AtomException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("system_id", system_id);
		map.put("package_id", package_id);
		
		commandLineMapper.distXml(map);
		//System.err.println("==>"+map.toString());
		if(map != null) {
			int result = (Integer) map.get("result");
			if(result == 0) return 0;
		} 
		return -1;
	}
	
	/**
	 * Insert.
	 * 
	 * 설명 :
	 *
	 * @param map the map
	 * @return the int
	 * 
	 * 설명 :
	 * @throws AtomException the pfnm exception
	 */
	@Transactional
	public int insert(WebCliDomain commandLine) throws AtomException {
		return commandLineMapper.insert(commandLine);
	}
	
	/**
	 * Update.
	 * 
	 * 설명 :
	 *
	 * @param map the map
	 * @return the int
	 * 
	 * 설명 :
	 * @throws AtomException the pfnm exception
	 */
	@Transactional
	public int update(Map<String, Object> map) throws AtomException {
		return commandLineMapper.update(map);
	}
	
	/**
	 * Search system id.
	 *
	 * @param argument the argument
	 * @return the string
	 * 
	 * 설명 :
	 * @throws AtomException the pfnm exception
	 */
	public String searchSystemID(String argument) throws AtomException {
		return commandLineMapper.searchSystemID(argument);
	}
	
	/**
	 * Dist sys group.
	 *
	 * @param system_id the system_id
	 * @return the int
	 * 
	 * 설명 :
	 * @throws AtomException the pfnm exception
	 */
	public List<Map<String, Object>> distSysGroup(String system_id) throws AtomException {
		return commandLineMapper.distSysGroup(system_id);
	}
			
	public String getAuth(String url, HttpServletRequest request) throws AtomException {
		SessionUser session = (SessionUser) request.getSession(false).getAttribute("session_user");
		if (session != null) return commandLineMapper.getAuth(url, session.getUserGroupNo());
		return null;
	}
	
	public List<Map<String, String>> listCMDArg(String cmd_code) throws AtomException {
		return commandLineMapper.listCMDArg(cmd_code);
	}
}