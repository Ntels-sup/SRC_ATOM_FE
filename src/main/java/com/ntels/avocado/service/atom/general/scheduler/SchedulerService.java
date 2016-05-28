package com.ntels.avocado.service.atom.general.scheduler;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ntels.avocado.dao.atom.general.scheduler.SchedulerMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.authorization.user.Package;
import com.ntels.avocado.domain.atom.config.networkmanager.Line;
import com.ntels.avocado.domain.atom.config.networkmanager.Node;
import com.ntels.avocado.domain.atom.config.processmanager.NodeType;
import com.ntels.avocado.domain.atom.config.processmanager.Proc;
import com.ntels.avocado.domain.atom.config.processmanager.Svc;
import com.ntels.avocado.domain.atom.general.scheduler.Application;
import com.ntels.avocado.domain.atom.general.scheduler.PluginProperties;
import com.ntels.avocado.domain.atom.general.scheduler.Scheduler;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerFlow;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerGroup;
import com.ntels.ncf.utils.MessageUtil;
import com.ntels.ncf.utils.ParamUtil;
import com.ntels.ncf.utils.StringUtils;

@Service
public class SchedulerService {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
//	@Autowired
//	private SchedulerDAO schedulerDAO;
	
	@Autowired
	private SchedulerMapper schedulerMapper;

	public List<SchedulerGroup> listPkg() {
		return schedulerMapper.listPkg();
	}
	
	public List<SchedulerGroup> listSchedulerGroupAjax(SchedulerGroup schedulerGroup) {

		return schedulerMapper.listSchedulerGroupAjax(schedulerGroup);
	}
	
	public List<LinkedHashMap<String, String>> listExcelSchedulerGroup(SchedulerGroup schedulerGroup){
		return schedulerMapper.listExcelSchedulerGroup(schedulerGroup);
	}
	
	public Paging listSchedulerGroup(SchedulerGroup schedulerGroup) {

		if(ParamUtil.nullToInteger(schedulerGroup.getPage()) == 0){
			schedulerGroup.setPage(1);
		}

		schedulerGroup.setStart(((schedulerGroup.getPage()-1)*schedulerGroup.getPerPage()));
		schedulerGroup.setEnd(schedulerGroup.getPerPage());
		
		List<SchedulerGroup> list = schedulerMapper.listSchedulerGroup(schedulerGroup);
		int count = schedulerMapper.countSchedulerGroup(schedulerGroup);
		
		//결과를 DTO에 저장
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(count);		
		paging.setPage(schedulerGroup.getPage());
		paging.setPerPage(schedulerGroup.getPerPage());
		
		return paging;
	}
	
	public List<Scheduler> listScheduler(Scheduler scheduler) {

		return schedulerMapper.listScheduler(scheduler);
	}
	
	public List<SchedulerFlow> listSchedulerFlow(SchedulerFlow schedulerFlow) {

		return schedulerMapper.listSchedulerFlow(schedulerFlow);
	}
	
	public List<Application> listApplication(Application application) {

		return schedulerMapper.listApplication(application);
	}
	
	public List<PluginProperties> listPluginProperties(Package package_, PluginProperties pluginProperties) {

		return schedulerMapper.listPluginProperties(package_, pluginProperties);
	}

	public SchedulerGroup getSchedulerGroup(SchedulerGroup schedulerGroup) {

		return schedulerMapper.getSchedulerGroup(schedulerGroup);
	}
	
	public Scheduler getScheduler(Scheduler scheduler) {

		return schedulerMapper.getScheduler(scheduler);
	}
	
	public SchedulerFlow getSchedulerFlow(SchedulerFlow schedulerFlow) {

		return schedulerMapper.getSchedulerFlow(schedulerFlow);
	}	
	
	public int insertSchedulerGroup(SchedulerGroup schedulerGroup) {

		logger.debug( "[mirinae.maru] start_dt : " + schedulerGroup.getStart_dt() );
		logger.debug( "[mirinae.maru] start_tm : " + schedulerGroup.getStart_tm() );
		logger.debug( "[mirinae.maru] expire_dt : " + schedulerGroup.getExpire_dt() );
		logger.debug( "[mirinae.maru] expire_tm : " + schedulerGroup.getExpire_tm() );
		
		String start_date = schedulerGroup.getStart_dt() +" "+ schedulerGroup.getStart_tm()+":00";
		String expire_date = schedulerGroup.getExpire_dt() +" "+ schedulerGroup.getExpire_tm()+":59";
		
		schedulerGroup.setStart_date(start_date);
		schedulerGroup.setExpire_date(expire_date);
		
		if( schedulerGroup.getSchedule_cycle_type().equals("01") )
			schedulerGroup.setSchedule_cycle("0");
		
		int cnt = schedulerMapper.countSchedulerGroup(schedulerGroup);
		logger.debug( "[mirinae.maru] cnt : " + cnt );
		logger.debug( "[mirinae.maru] cnt : " + cnt );
		logger.debug( "[mirinae.maru] cnt : " + cnt );
		logger.debug( "[mirinae.maru] cnt : " + cnt );
		logger.debug( "[mirinae.maru] cnt : " + cnt );
		
		if( cnt > 0 )
			return -1;
		else 
			return schedulerMapper.insertSchedulerGroup(schedulerGroup);
	}	
	
	public boolean insertScheduler(Scheduler scheduler) {

		int insertResult = schedulerMapper.insertScheduler(scheduler);
		
		boolean result = false;
		
		if(insertResult>0){
			
			result = true;			
		}
		
		return result;
	}
	
	public boolean insertSchedulerFlow(SchedulerFlow schedulerFlow) {

		int insertResult = schedulerMapper.insertSchedulerFlow(schedulerFlow);
		
		boolean result = false;
		
		if(insertResult>0){
			
			result = true;
		}
		
		return result;
	}	
	
	public int updateSchedulerGroup(SchedulerGroup schedulerGroup) {

		String expire_date = schedulerGroup.getExpire_dt() +" "+ schedulerGroup.getExpire_tm()+":59";
		
		schedulerGroup.setExpire_date(expire_date);
		if( schedulerGroup.getSchedule_cycle_type().equals("01") )
			schedulerGroup.setSchedule_cycle("0");

		logger.debug( "[mirinae.maru] expire_date : " + schedulerGroup.getExpire_date() );
		logger.debug( "[mirinae.maru] expire_date : " + schedulerGroup.getExpire_date() );
		logger.debug( "[mirinae.maru] expire_date : " + schedulerGroup.getExpire_date() );
		logger.debug( "[mirinae.maru] expire_date : " + schedulerGroup.getExpire_date() );
		logger.debug( "[mirinae.maru] expire_date : " + schedulerGroup.getExpire_date() );
		
		return schedulerMapper.updateSchedulerGroup(schedulerGroup); 
	}	
	
	public boolean updateScheduler(Scheduler scheduler) {

		int updateResult = schedulerMapper.updateScheduler(scheduler);
		
		boolean result = false;
		
		if(updateResult>0){
			
			result = true;
		}
		
		return result;
	}
	
	public boolean updateSchedulerName(Scheduler scheduler) {

		int updateResult = schedulerMapper.updateSchedulerName(scheduler);
		
		boolean result = false;
		
		if(updateResult>0){
			
			result = true;
		}
		
		return result;
	}
	
	public boolean updateSchedulerPosition(Scheduler scheduler) {

		int updateResult = schedulerMapper.updateSchedulerPosition(scheduler);
		
		boolean result = false;
		
		if(updateResult>0){
			
			result = true;
		}
		
		return result;
	}
	
	public boolean updateSchedulerFlow(SchedulerFlow schedulerFlow) {

		int updateResult = schedulerMapper.updateSchedulerFlow(schedulerFlow);
		
		boolean result = false;
		
		if(updateResult>0){
			
			result = true;
		}
		
		return result;
	}		
	
	public int deleteSchedulerGroup(SchedulerGroup schedulerGroup) {

		Scheduler scheduler 		= new Scheduler();
		SchedulerFlow schedulerFlow = new SchedulerFlow();
		
		scheduler.setGroup_name( schedulerGroup.getGroup_name() );
		scheduler.setPkg_name( schedulerGroup.getPkg_name() );
		
		schedulerFlow.setGroup_name( schedulerGroup.getGroup_name() );
		schedulerFlow.setPkg_name( schedulerGroup.getPkg_name() );
		
		int resultFlow = schedulerMapper.deleteSchedulerFlow(schedulerFlow);
		
		logger.debug( "[mirinae.maru] schedulerFlow delete result : " + resultFlow  );
		logger.debug( "[mirinae.maru] schedulerFlow delete result : " + resultFlow  );
		logger.debug( "[mirinae.maru] schedulerFlow delete result : " + resultFlow  );
		logger.debug( "[mirinae.maru] schedulerFlow delete result : " + resultFlow  );
		logger.debug( "[mirinae.maru] schedulerFlow delete result : " + resultFlow  );
		
		int resultJob = schedulerMapper.deleteScheduler(scheduler);
		
		logger.debug( "[mirinae.maru] scheduler delete result : " + resultJob  );
		logger.debug( "[mirinae.maru] scheduler delete result : " + resultJob  );
		logger.debug( "[mirinae.maru] scheduler delete result : " + resultJob  );
		logger.debug( "[mirinae.maru] scheduler delete result : " + resultJob  );
		logger.debug( "[mirinae.maru] scheduler delete result : " + resultJob  );
		
		int resultGroup = schedulerMapper.deleteSchedulerGroup(schedulerGroup);
		
		logger.debug( "[mirinae.maru] schedulerGroup delete result : " + resultGroup  );
		logger.debug( "[mirinae.maru] schedulerGroup delete result : " + resultGroup  );
		logger.debug( "[mirinae.maru] schedulerGroup delete result : " + resultGroup  );
		logger.debug( "[mirinae.maru] schedulerGroup delete result : " + resultGroup  );
		logger.debug( "[mirinae.maru] schedulerGroup delete result : " + resultGroup  );
		
		return resultGroup + resultJob + resultFlow;
	}	
	
	public boolean deleteScheduler(Scheduler scheduler) {

		int resultDelete = schedulerMapper.deleteScheduler(scheduler);

		boolean result = false;
		
		if(resultDelete>0){
			
			result = true;
		}
		
		return result;
	}

	public boolean deleteSchedulerFlow(SchedulerFlow schedulerFlow) {

		int resultDelete = schedulerMapper.deleteSchedulerFlow(schedulerFlow);

		boolean result = false;
		
		if(resultDelete>0){
			
			result = true;
		}
		
		return result;
	}
	
	
	
	public List<NodeType> listNodeType(SchedulerGroup schedulerGroup) {
		List<NodeType> ret;
		try {
			ret = schedulerMapper.listNodeType(schedulerGroup);
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<NodeType>();
		}
		return ret;
	}
	
	public List<Node> listNode(SchedulerGroup schedulerGroup) {
		List<Node> ret;
		try {
			ret = schedulerMapper.listNode(schedulerGroup);
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Node>();
		}
		return ret;
	}
	
	public List<SchedulerGroup> listBatchGroup() {
		return schedulerMapper.listBatchGroup();
	}
	
	public List<Proc> listProc(SchedulerGroup schedulerGroup) {
		return schedulerMapper.listProc(schedulerGroup);
	}
	
	public List<Scheduler> listBatchJob(SchedulerGroup schedulerGroup) {
		return schedulerMapper.listBatchJob(schedulerGroup);
	}
	
	@Transactional
	public String saveFlowDesign(String jsonStr) {
		Gson gson = new Gson();
		JsonParser parser = new JsonParser();
		try {
			JsonObject json = (JsonObject)parser.parse(jsonStr);
			
			SchedulerGroup schedulerGroup = gson.fromJson(json, SchedulerGroup.class);
			
			schedulerMapper.deleteLine(schedulerGroup);
			schedulerMapper.deleteBatchFlow(schedulerGroup);
			schedulerMapper.resetBatchJobPosition(schedulerGroup);
			// schedulerMapper.deleteImages(schedulerGroup);
			// schedulerMapper.deleteSvcProc(schedulerGroup);
			
			JsonArray batchJobList = (JsonArray)json.get("batchJobList");
			for (int i=0;i<batchJobList.size();i++) {
				JsonObject jsonBatchJob = (JsonObject)batchJobList.get(i);
				Scheduler scheduler = gson.fromJson(jsonBatchJob, Scheduler.class);
				if (schedulerMapper.getBatchJob(scheduler) != null) {
					String sMessage = "";
					sMessage += MessageUtil.getMessage("msg.general.batch.batchjobmanager.batchjob.exist.front");
					sMessage += scheduler.getJob_name();
					sMessage += MessageUtil.getMessage("msg.general.batch.batchjobmanager.batchjob.exist.back");
					throw new Exception(sMessage);
				}
				if (StringUtils.isNotEmpty(scheduler.getJob_name_old())) {
					if (schedulerMapper.updateImage(scheduler) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.update.fail.front");
						sMessage += scheduler.getJob_name();
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.update.fail.back");
						throw new Exception(sMessage);
					}
					if (schedulerMapper.updateBatchJob(scheduler) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.general.batch.batchjobmanager.batchjob.update.fail.front");
						sMessage += scheduler.getJob_name();
						sMessage += MessageUtil.getMessage("msg.general.batch.batchjobmanager.batchjob.update.fail.back");
						throw new Exception(sMessage);
					}
				} else {
					if (schedulerMapper.insertImage(scheduler) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.insert.fail.front");
						sMessage += scheduler.getJob_name();
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.insert.fail.back");
						throw new Exception(sMessage);
					}
					if (schedulerMapper.insertBatchJob(scheduler) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.general.batch.batchjobmanager.batchjob.insert.fail.front");
						sMessage += scheduler.getJob_name();
						sMessage += MessageUtil.getMessage("msg.general.batch.batchjobmanager.batchjob.insert.fail.front");
						throw new Exception(sMessage);
					}
				}
			}
			
			JsonArray lineList = (JsonArray)json.get("lineList");
			for (int i=0;i<lineList.size();i++) {
				JsonObject jsonLine = (JsonObject)lineList.get(i);
				Line line = gson.fromJson(jsonLine, Line.class);
				line.setPkg_name(schedulerGroup.getPkg_name());
				line.setNode_type(schedulerGroup.getNode_type());
				String source_id = getBatchJobImageNo(line.getSource_id());
				String target_id = getBatchJobImageNo(line.getTarget_id());
				line.setSource_id(source_id);
				line.setTarget_id(target_id);
				line.setJob_name(line.getSource_name());
				line.setNext_job_name(line.getTarget_name());
				if (schedulerMapper.insertBatchFlow(line) <= 0) {
					throw new Exception(MessageUtil.getMessage("msg.general.batch.batchjobmanager.batchflow.insert.fail"));
				}
				if (schedulerMapper.insertLine(line) <= 0) {
					throw new Exception(MessageUtil.getMessage("msg.configuration.networkmanager.line.insert.fail"));
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ex.getMessage();
		}
		return "succ";
	}
	
	public String getBatchJobImageNo(String sParam) {
		String proc_no = sParam;
		if (sParam.length() == 36) {
			proc_no = schedulerMapper.getImageNoByUUID(sParam);
		}
		return proc_no;
	}
	
	public List<Line> listLine(SchedulerGroup schedulerGroup) {
		List<Line> ret;
		try {
			ret = schedulerMapper.listLine(schedulerGroup);
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Line>();
		}
		return ret;
	}

	public SchedulerGroup nodeSocketInfo() {
		return schedulerMapper.nodeSocketInfo();
	}

	public SchedulerGroup processSocketInfo() {
		return schedulerMapper.processSocketInfo();
	}
}
