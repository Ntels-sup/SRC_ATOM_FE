package com.ntels.avocado.dao.atom.config.trace;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

// TODO: Auto-generated Javadoc
/**
 * The Interface TraceMapper.
 */
@Component
public interface TraceMapper {
	
	/**
	 * List system.
	 *
	 * @return the list
	 */
	Map<String, Object> listSystem();
	
	/**
	 * 서비스 조회
	 * @param system_id
	 * @return
	 */
	List<Map<String, Object>> listService(String system_id);
	
	Map<String, Object> listTopService(String system_id);
	
	/**
	 * List send typ.
	 *
	 * @return the list
	 */
	List<Map<String, Object>> listSendType();
	
	/**
	 * List protocol.
	 *
	 * @return the list
	 */
	List<Map<String, Object>> listProtocol();
	
	/**
	 * List top process.
	 *
	 * @return the map
	 */
	Map<String, Object> listTopProcess(String service_id);
	
	/**
	 * List process.
	 *
	 * @return the list
	 */
	List<Map<String, Object>> listProcess(String service_id);
	
	//List<Map<String, Object>> listProcessNull(String system_id);
	
	/**
	 * List node id.
	 *
	 * @return the list
	 */
	List<Map<String, Object>> listDiameterNode();
	
	/**
	 * List gtp node.
	 *
	 * @return the list
	 */
	List<Map<String, Object>> listGtpNode();
	
	/**
	 * List all node.
	 *
	 * @return the list
	 */
	//List<Map<String, Object>> listAllNode();
	
	/**
	 * List calling type.
	 *
	 * @return the list
	 */
	List<Map<String, Object>> listDiameterType();
	
	/**
	 * List imsi type.
	 *
	 * @return the list
	 */
	List<Map<String, Object>> listGtpType();
	
	/**
	 * List all type.
	 *
	 * @return the list
	 */
	//List<Map<String, Object>> listAllType();
	
	/**
	 * List process gtp type.
	 *
	 * @param system_id the system_id
	 * @param service_id the service_id
	 * @param process_id the process_id
	 * @return the list
	 */
	List<Map<String, Object>> listProcessGtpNode(
			@Param("system_id") String system_id
		  , @Param("service_id") String service_id
		  , @Param("process_id") String process_id
			);
	
	/**
	 * List process dia type.
	 *
	 * @param system_id the system_id
	 * @param service_id the service_id
	 * @param process_id the process_id
	 * @return the list
	 */
	List<Map<String, Object>> listProcessDiaNode(
			@Param("system_id") String system_id
		  , @Param("service_id") String service_id
 		  , @Param("process_id") String process_id);
	
}
