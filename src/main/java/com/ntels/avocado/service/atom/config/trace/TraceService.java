package com.ntels.avocado.service.atom.config.trace;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.config.trace.TraceMapper;


// TODO: Auto-generated Javadoc
/**
 * The Class TraceService.
 */
@Service
public class TraceService {

	/** The trace mapper. */
	@Autowired
	private TraceMapper traceMapper;
	
	/**
	 * List system id.
	 *
	 * @return the list
	 */
	public Map<String, Object> listSystem() {
		return traceMapper.listSystem();
	}
	
	public List<Map<String, Object>> listService() {
		Map<String, Object> map = traceMapper.listSystem();		
		return traceMapper.listService((String)map.get("ID"));
	}
	
	public Map<String, Object> listTopService() {
		Map<String, Object> map = traceMapper.listSystem();		
		return traceMapper.listTopService((String)map.get("ID"));
	}
	
	/**
	 * List send type.
	 *
	 * @return the list
	 */
	public List<Map<String, Object>> listSendType() {
		return traceMapper.listSendType();
	}
	
	/**
	 * List protocol.
	 *
	 * @return the list
	 */
	public List<Map<String, Object>> listProtocol() {
		return traceMapper.listProtocol();
	}
	
	/**
	 * List top process.
	 *
	 * @return the map
	 */
	public Map<String, Object> listTopProcess(String service_id) {
		return traceMapper.listTopProcess(service_id);
	}
	
	/**
	 * List process.
	 *
	 * @return the list
	 */
	public List<Map<String, Object>> listProcess(String service_id) {
		return traceMapper.listProcess(service_id);
	}

	/**
	 * List node.
	 *
	 * @return the list
	 */
	public List<Map<String, Object>> listDiameterNode() {
		return traceMapper.listDiameterNode();
	}
	
	/**
	 * List gtp node.
	 *
	 * @return the list
	 */
	public List<Map<String, Object>> listGtpNode() {
		return traceMapper.listGtpNode();
	}
	
	/**
	 * List all node.
	 *
	 * @return the list
	 */
	/*public List<Map<String, Object>> listAllNode() {
		return traceMapper.listAllNode();
	}*/
	
	/**
	 * List calling type.
	 *
	 * @return the list
	 */
	public List<Map<String, Object>> listDiameterType() {
		return traceMapper.listDiameterType();
	}
	
	/**
	 * List imsi type.
	 *
	 * @return the list
	 */
	public List<Map<String, Object>> listGtpType() {
		return traceMapper.listGtpType();
	}
	
	/**
	 * List all type.
	 *
	 * @return the list
	 */
	/*public List<Map<String, Object>> listAllType() {
		return traceMapper.listAllType();
	}*/
	
	/**
	 * List process gtp type.
	 *
	 * @param system_id the system_id
	 * @param service_id the service_id
	 * @param process_id the process_id
	 * @return the list
	 */
	public List<Map<String, Object>> listProcessGtpNode(String system_id, String service_id, String process_id) {
		return traceMapper.listProcessGtpNode(system_id, service_id, process_id);
	}
	
	/**
	 * List process dia type.
	 *
	 * @param system_id the system_id
	 * @param service_id the service_id
	 * @param process_id the process_id
	 * @return the list
	 */
	public List<Map<String, Object>> listProcessDiaNode(String system_id, String service_id, String process_id) {
		return traceMapper.listProcessDiaNode(system_id, service_id, process_id);
	}
}
