package com.ntels.avocado.dao.atom.management.trace;

import java.util.Map;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.management.trace.Condition;
import com.ntels.avocado.domain.atom.management.trace.TraceReq;

@Component
public interface TraceReqMapper {
	
	List<Map<String, String>> listTraceProcess();

	TraceReq getTraceReq(@Param(value="condition") Condition condition);
	List<TraceReq> list(
			@Param(value="condition") Condition condition, 
			@Param(value = "start") int start,
			@Param(value = "end") int end);
	int count(@Param(value="condition") Condition condition);
	
	void trace_procedure(@Param(value = "traceReq") TraceReq traceReq);
	
//	int insert(@Param(value = "traceReq") TraceReq traceReq);
//	int update(@Param(value = "traceReq") TraceReq traceReq);
//	int delete(@Param(value = "traceReq") TraceReq traceReq);
	
	int isExist(@Param(value = "traceReq") TraceReq traceReq);

	int updateEnd_datetime(@Param(value = "trace_req_id") Integer trace_req_id);

	List<Map<String, String>> listFilterGrpNm(
			@Param(value = "system_id") String system_id, 
			@Param(value = "package_id") String package_id, 
			@Param(value = "service_id") String service_id);
	
	List<Map<String, String>> listTraceType();

	List<Map<String, String>> listExcel(@Param(value="condition") Condition condition);
	
	String getEndDateTime();
	
}
