package com.ntels.avocado.service.atom.monitor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.dao.atom.monitor.MonitorMapper;
import com.ntels.avocado.dao.common.CommonMapper;
import com.ntels.avocado.domain.atom.monitor.Monitor;
import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;
import com.ntels.avocado.domain.common.SessionUser;

@Service("MonitorService")
public class MonitorService {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private MonitorMapper monitorMapper;
    @Autowired
    private CommonMapper commonMapper;
    
    /**
     * 알람 발생 시킬 권한 조회
     * <PRE>
     * 1. MethodName: authorizationAlarm
     * 2. ClassName : MonitorService
     * 3. Comment   :
     * 4. 작성자    : hancheonsu
     * 5. 작성일    : 2016. 4. 14. 오전 10:26:23
     * </PRE>
     *   @return List<Map<String,Object>>
     *   @param userId
     *   @return
     */
    public List<Map<String, Object>> authorizationAlarm(String userId){
		return monitorMapper.authorizationAlarm(userId);
	}
    
    public List<Map<String, Object>> alarmAll(){
		return monitorMapper.alarmAll();
	}
    
    public int AlarmTotalCount(Monitor monitor){
		return monitorMapper.AlarmTotalCount(monitor);
	}
    
    public List<Map<String, Object>> listAlarm(Monitor monitor, int page, int perPage){
    	int start = ((page - 1) * perPage);
		int end = perPage;
		return monitorMapper.listAlarm(monitor, start, end);
	}
    
    public Map<String,Object> alarmDetail(Integer msgId){
		return monitorMapper.alarmDetail(msgId);
	}
    
    public List<LinkedHashMap<String, String>> listExcel(Monitor monitor){
		return monitorMapper.listExcel(monitor);
	}
    
    public List<Map<String, Object>> severityCount(Monitor monitor) {
		return monitorMapper.severityCount(monitor);
	}
    
    public Map<String,Object> lastSound(){
		return monitorMapper.lastSound();
	}
    
    /**
     * Audio 태그에 등록하기 위한 Severity Sound 조회
     * <PRE>
     * 1. MethodName: audioSeveritySound
     * 2. ClassName : MonitorService
     * 3. Comment   :
     * 4. 작성자    : hancheonsu
     * 5. 작성일    : 2016. 4. 14. 오전 11:14:01
     * </PRE>
     *   @return List<Map<String,Object>>
     *   @return
     */
    public List<Map<String,Object>> audioSeveritySound(){
		return monitorMapper.audioSeveritySound();
	}
    
    
    @Transactional
	public void checkAlarmConfirm(String[] alarm_check, boolean type, HttpSession session) {
    	
    	SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);    	
    	OperationHistDomain operationHist = new OperationHistDomain();
    	operationHist.setUser_id(sessionUser.getUserId());
		operationHist.setMenu_id(String.valueOf(session.getAttribute("menuId")));
		operationHist.setOper_ip(sessionUser.getUserIpAddress());
		operationHist.setOper_message("5"); //TAT_COMMON_CODE의 그룹코드(200003) 참고
		
		commonMapper.insertOperationHist(operationHist);
		//operationHist.getOper_id() //insertOperationHist에서 담겨서 넘어옴
		
		String temp = null;
		if (alarm_check != null) {
			for(int i = 0; i < alarm_check.length; i++) {
				temp = alarm_check[i];
				
				if (type)
					monitorMapper.checkAlarmAck(operationHist.getOper_id(), Integer.parseInt(temp));
				else
					monitorMapper.checkAlarmUnack(operationHist.getOper_id(), Integer.parseInt(temp));
			}		

			operationHist.setResult_yn("Y");
			if (type) operationHist.setOper_cmd("Ack"); else operationHist.setOper_cmd("Unack");
			operationHist.setCmd_arg(Integer.toString(alarm_check.length));
			
			commonMapper.updateOperationHist(operationHist);
		}
	}
    
    @Transactional
	public int clearAlarmConfirm(String[] alarm_check, HttpSession session) {
    	
    	SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);    	
    	OperationHistDomain operationHist = new OperationHistDomain();
    	operationHist.setUser_id(sessionUser.getUserId());
		operationHist.setMenu_id(String.valueOf(session.getAttribute("menuId")));
		operationHist.setOper_ip(sessionUser.getUserIpAddress());
		operationHist.setOper_message("5"); //TAT_COMMON_CODE의 그룹코드(200003) 참고
		
		commonMapper.insertOperationHist(operationHist);
		//operationHist.getOper_id() //insertOperationHist에서 담겨서 넘어옴

		if (alarm_check != null) {
			
			operationHist.setResult_yn("Y");
			operationHist.setOper_cmd("Clear");
			operationHist.setCmd_arg(Integer.toString(alarm_check.length));
			
			commonMapper.updateOperationHist(operationHist);
		}
		
		return operationHist.getOper_id();
	}
    
    public List<Map<String,Object>> listNodeStatus(){
		return monitorMapper.listNodeStatus();
	}
    
    
    public List<Map<String, Object>> listTreeDetail(String nodeId) {
		
    	List<Map<String, Object>> listTree = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listService = monitorMapper.listTreeService(nodeId);
		List<Map<String, Object>> listProcess = null;
		Map<String, Object> mapService = null;
		Integer serviceId;
		
		for (int i = 0; i < listService.size(); i++) {
			mapService = listService.get(i);
			serviceId = (Integer) mapService.get("id");
			listProcess = monitorMapper.listTreeProcess(serviceId);
			
			mapService.put("children", listProcess);
			listTree.add(mapService);
			
		}
		return listTree;
	}
    
    public List<Map<String,Object>> listTreeAllProcess(String nodeId){
		return monitorMapper.listTreeAllProcess(nodeId);
	}
    
    public Integer getProcessAlarm(){
		return monitorMapper.getProcessAlarm();
	}
    
    public Integer getProcNo(String nodeType, String procName){
		return monitorMapper.getProcNo(nodeType, procName);
	}
    
    public List<Map<String, Object>> listTopResource() {
    	List<Map<String, Object>> list = monitorMapper.listTopResourceGroup();
    	List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
    	List<Map<String, Object>> resource = null;
    	Map<String, Object> mapResource = null;
    	Map<String, Object> mapResource1 = null;
    	//Map<String, Object> aaa = null;
    	
    	if (list.size() > 0) {
    		Map<String, Object> temp = null;
    		for(int i=0; i < list.size(); i++) {
    			temp = list.get(i);
    			//System.err.println((String)temp.get("RSC_GRP_ID"));
    			//System.err.println((String)temp.get("RSC_GRP_NAME"));
    			List<Map<String, Object>> resourceList = monitorMapper.listTopResource((String)temp.get("RSC_GRP_ID"));
    			
    			resource = new ArrayList<Map<String, Object>>();
    			
    			for(int t=0; t < 5; t++) {
    				if (t < resourceList.size()) {
    					mapResource1 = resourceList.get(t);
    				} else {
    					mapResource1 = new HashMap<String, Object>();
    					mapResource1.put("RSC_ID", "");
    					mapResource1.put("RSC_ID_NAME", "");
    					mapResource1.put("PRC_DATE", "");
    					mapResource1.put("DATA", "0");
    				}
    				resource.add(mapResource1);
    				//System.err.println(i +"/"+t +"/"+resource.toString());
    			}
    			mapResource = new HashMap<String, Object>();
    			mapResource.put("resourceDataName", (String)temp.get("RSC_GRP_NAME"));
    			mapResource.put("resourceData", resource);
    			result.add(mapResource);
    		}
    	}
    		//System.err.println(result);
		return result;
	}
}
