package com.ntels.avocado.service.atom.management.trace;

import java.util.Map;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.dao.atom.management.trace.TraceReqMapper;
import com.ntels.avocado.domain.atom.management.trace.Condition;
import com.ntels.avocado.domain.atom.management.trace.TraceReq;

@Service
public class TraceReqService {
	
	@Autowired
	private TraceReqMapper traceMapper;

	
	public List<Map<String, String>> listTraceProcess(){
		return traceMapper.listTraceProcess();
	}

	public TraceReq getTraceReq(Condition condition) {
		return traceMapper.getTraceReq(condition);
	}
	
	public List<TraceReq> list(Condition condition){
		condition.setStart( ((condition.getPage() - 1) * condition.getPerPage()) );
		condition.setEnd(condition.getPerPage());
		
		condition.setStart_date_c(condition.getStart_date_c().replace("-", ""));
		condition.setEnd_date_c(condition.getEnd_date_c().replace("-", ""));
		
		return traceMapper.list(condition, condition.getStart(), condition.getEnd());
	}
	
	public int count(Condition condition){
		return traceMapper.count(condition);
	}
	
	@Transactional
	public boolean insert(TraceReq traceReq) {
		traceReq.setTable_cmd("I");
		traceReq.setTrace_req_id(0);

		traceMapper.trace_procedure(traceReq);
		
		return (traceReq.getResult() == 0);
	}

	@Transactional
	public boolean update(TraceReq traceReq) {
		traceReq.setTable_cmd("U");
		
		traceMapper.trace_procedure(traceReq);
		
		return (traceReq.getResult() == 0);
	}

	@Transactional
	public boolean updateEnd_datetime(TraceReq traceReq) {
		traceReq.setTable_cmd("E");
		
		traceMapper.trace_procedure(traceReq);
		
		return (traceReq.getResult() == 0);
	}

	@Transactional
	public boolean delete(TraceReq traceReq) {
		traceReq.setTable_cmd("D");
		
		traceMapper.trace_procedure(traceReq);
		
		return (traceReq.getResult() == 0);
	}

	public boolean isExist(TraceReq traceReq) {
		return (traceMapper.isExist(traceReq) > 0);
	}

	public List<Map<String, String>> listTraceType() {
		return traceMapper.listTraceType();
	}
	
	public List<Map<String, String>> listExcel(Condition condition){
		condition.setStart_date_c(condition.getStart_date_c().replace("-", ""));
		condition.setEnd_date_c(condition.getEnd_date_c().replace("-", ""));
		
		return traceMapper.listExcel(condition);
	}
	
	public String getEndDateTime() {
		return traceMapper.getEndDateTime();
	}
}