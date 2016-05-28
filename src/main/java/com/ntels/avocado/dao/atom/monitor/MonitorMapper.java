package com.ntels.avocado.dao.atom.monitor;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.monitor.Monitor;

@Component
public interface MonitorMapper {
	
	List<Map<String, Object>> authorizationAlarm(String userId);
	
	List<Map<String, Object>> alarmAll();
	
	int AlarmTotalCount(@Param("monitor") Monitor monitor);
	
	List<Map<String, Object>> listAlarm(@Param("monitor") Monitor monitor
            , @Param("start") int start
            , @Param("end") int end);
	
	Map<String, Object> alarmDetail(Integer msgId);
	
	List<LinkedHashMap<String, String>> listExcel(@Param("monitor") Monitor monitor);
			
	Map<String, Object> lastSound();
	
	List<Map<String, Object>> severityCount(@Param("monitor") Monitor monitor);
	
	List<Map<String, Object>> audioSeveritySound();
	
	int checkAlarmAck(@Param("operNo") Integer operNo, @Param("msgId") Integer msgId);
	
	int checkAlarmUnack(@Param("operNo") Integer operNo, @Param("msgId") Integer msgId);
	
	String getCode(@Param("msgId") Integer msgId);
	
	List<Map<String, Object>> listNodeStatus();
	
	List<Map<String, Object>> listTreeService(String nodeId);
	
	List<Map<String, Object>> listTreeProcess(Integer serviceId);
	
	List<Map<String, Object>> listTreeAllProcess(String nodeId);
	
	Integer getProcessAlarm();
	
	/**
     */
    Integer getProcNo(
    		@Param("nodeType") String nodeType,
    		@Param("procName") String procName
    );
    
    List<Map<String, Object>> listTopResourceGroup();
    
    List<Map<String, Object>> listTopResource(@Param("rsc_grp_id") String rsc_grp_id);
}
