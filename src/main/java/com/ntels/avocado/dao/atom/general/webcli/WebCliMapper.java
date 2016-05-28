/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.dao.ofcs.commandline.CommandLineMapper.java 
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
 * @작성일 : 2012. 2. 21
 *   
 * @작업 완료
 *    일자 : 내역을 적으세요
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.dao.atom.general.webcli;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.general.webcli.WebCliDomain;

// TODO: Auto-generated Javadoc
/**
 * The Interface CommandLineMapper.
 */
@Component
public interface WebCliMapper {
	
	/***********************************************************************************************/
	
	List<Map<String, String>> tableSel();
	
	List<Map<String, String>> xmlTable();
	
	List<Map<String, String>> xmlComponent(@Param("tableSel") String tableSel);
	
	List<Map<String, String>> getServiceName();
	
	List<Map<String, String>> getProcessName();
	
	List<Map<String, String>> getComponentName();
	
	List<Map<String, String>> getQueueName();
	/***********************************************************************************************/	

	List<Map<String, String>> listCMD(@Param("node_name") String node_name);
	
	/**
	 * Gets the keywords.
	 *
	 * @param keywords the keywords
	 * @param command_type the command_type
	 * @return the keywords
	 */
	List<String> getKeywords(
			@Param("keywords") String keywords
		  , @Param("command_type") String command_type
		  );
	
	/**
	 * Gets the commands.
	 *
	 * @return the commands
	 */
	List<Map<String, Object>> listCommands(@Param("user_group_level") String user_group_level);
	
	/**
	 * Gets the input format.
	 *
	 * @return the input format list
	 */
	List<Map<String, Object>> listInputFormat();	
	
	/**
	 * Checks if is check value.
	 *
	 * @param command the command
	 * @return the map
	 * 
	 * 설명 :
	 */
	Map<String, Object> getCommand(String command);
	
	/**
	 * System count.
	 *
	 * @param argument the argument
	 * @return the int
	 * 
	 * 설명 :
	 */
	int systemCount(String argument);
	
	/**
	 * listHistory.
	 *
	 * @return the list
	 * 
	 * 설명 :
	 */
	List<Map<String, Object>> listHistory(
			@Param("user_id") String user_id
//		  , @Param("package_id") String package_id
//		  , @Param("service_id") String service_id
//		  , @Param("process_id") String process_id
		  );
	
	/**
	 * List trace.
	 *
	 * @param system_id the system_id
	 * @param package_id the package_id
	 * @return the list
	 * 
	 * 설명 :
	 */
	List<Map<String, Object>> listTrace(
			@Param("system_id") String system_id
		  , @Param("package_id") String package_id
		  );
	
	/**
	 * Dist xml.
	 *
	 * @param map the map
	 * @return the int
	 * 
	 * 설명 :
	 */
	void distXml(Map<String, Object> map);
	
	/**
	 * Insert.
	 * 
	 * 설명 :
	 *
	 * @param map the map
	 * @return the int
	 * 
	 * 설명 :
	 */
	int insert(WebCliDomain commandLine);
	
	/**
	 * Update.
	 * 
	 * 설명 :
	 *
	 * @param map the map
	 * @return the int
	 * 
	 * 설명 :
	 */
	int update(Map<String, Object> map);	
	
	/**
	 * Search system id.
	 *
	 * @param argument the argument
	 * @return the string
	 * 
	 * 설명 :
	 */
	String searchSystemID(String argument);
	
	/**
	 * Dist sys group.
	 *
	 * @param system_id the system_id
	 * @return the map
	 * 
	 * 설명 :
	 */
	List<Map<String, Object>> distSysGroup(String system_id);
	
	String getAuth(
			@Param("url") String url			
		  , @Param("user_group_id") String user_group_id);
	
	/**
	 * Gets the commands.
	 *
	 * @return the commands
	 */
	List<Map<String, String>> listService(@Param("pkg_name") String pkg_name);
	
	/**
	 * Gets the process lsit
	 *
	 * @return the process list
	 */
	List<Map<String, String>> listProcess(
			@Param("node_name") String node_name,
			@Param("svc_no") String svc_no);
	
	/**
	 * cmd arg list
	 * @param node_name
	 * @return
	 */
	List<Map<String, String>> listCMDArg(@Param("cmd_code") String cmd_code);
	
	/**
	 * pkg name
	 * @param node_name
	 * @return
	 */
	String getPkgName(@Param("node_name") String node_name);
	
	/**
	 * nodeNo
	 * @param node_name
	 * @return
	 */
	String getNodeNo(@Param("node_name") String node_name);
	
	/**
	 * cmd_ems_destination
	 * @param node_name
	 * @return
	 */
	String getCmdEmsDestination(@Param("cmd_code") String cmd_code, @Param("pkg_name") String pkg_name);
}
