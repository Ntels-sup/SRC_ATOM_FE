package com.ntels.avocado.dao.atom.general.scheduler;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.authorization.user.Package;
import com.ntels.avocado.domain.atom.config.networkmanager.Line;
import com.ntels.avocado.domain.atom.config.networkmanager.Node;
import com.ntels.avocado.domain.atom.config.networkmanager.Pkg;
import com.ntels.avocado.domain.atom.config.processmanager.NodeType;
import com.ntels.avocado.domain.atom.config.processmanager.Proc;
import com.ntels.avocado.domain.atom.general.scheduler.Application;
import com.ntels.avocado.domain.atom.general.scheduler.PluginProperties;
import com.ntels.avocado.domain.atom.general.scheduler.Scheduler;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerFlow;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerGroup;

@Component
public interface SchedulerMapper {
	
	List<SchedulerGroup> listPkg();
	
	List<SchedulerGroup> listSchedulerGroupAjax(SchedulerGroup schedulerGroup);
	
	List<SchedulerGroup> listSchedulerGroup(SchedulerGroup schedulerGroup);
	
	List<LinkedHashMap<String, String>> listExcelSchedulerGroup(SchedulerGroup schedulerGroup);
	
	int countSchedulerGroup(SchedulerGroup schedulerGroup);
	
	List<Scheduler> listScheduler(Scheduler scheduler);
	
	List<SchedulerFlow> listSchedulerFlow(SchedulerFlow schedulerFlow);
	
	List<Application> listApplication(Application application);
	
	List<PluginProperties> listPluginProperties(@Param("package") Package package_, @Param("pluginProperties") PluginProperties pluginProperties);
	
	SchedulerGroup getSchedulerGroup(SchedulerGroup schedulerGroup);
	
	Scheduler getScheduler(Scheduler scheduler);
	
	SchedulerFlow getSchedulerFlow(SchedulerFlow schedulerFlow);
	
	int insertSchedulerGroup(SchedulerGroup schedulerGroup);
	
	int insertScheduler(Scheduler scheduler);
	
	int insertSchedulerFlow(SchedulerFlow schedulerFlow);
	
	int updateSchedulerGroup(SchedulerGroup schedulerGroup);
	
	int updateScheduler(Scheduler scheduler);
	
	int updateSchedulerName(Scheduler scheduler);
	
	int updateSchedulerPosition(Scheduler scheduler);
	
	int updateSchedulerFlow(SchedulerFlow schedulerFlow);
	
	int deleteSchedulerGroup(SchedulerGroup schedulerGroup);
	
	int deleteScheduler(Scheduler scheduler);
	
	int deleteSchedulerFlow(SchedulerFlow schedulerFlow);
	
	SchedulerGroup nodeSocketInfo();
	
	SchedulerGroup processSocketInfo();
	
	public List<NodeType> listNodeType(SchedulerGroup schedulerGroup);
	List<SchedulerGroup> listBatchGroup();
	List<Node> listNode(SchedulerGroup schedulerGroup);
	List<Proc> listProc(SchedulerGroup schedulerGroup);
	List<Scheduler> listBatchJob(SchedulerGroup schedulerGroup);
	int deleteLine(SchedulerGroup schedulerGroup);
	int deleteBatchFlow(SchedulerGroup schedulerGroup);
	int resetBatchJobPosition(SchedulerGroup schedulerGroup);
	Scheduler getBatchJob(Scheduler scheduler);
	int updateImage(Scheduler scheduler);
	int updateBatchJob(Scheduler scheduler);
	int insertImage(Scheduler scheduler);
	int insertBatchJob(Scheduler scheduler);
	public String getImageNoByUUID(@Param(value="image_uuid")String image_uuid);
	int insertBatchFlow(Line line);
	int insertLine(Line line);
	List<Line> listLine(SchedulerGroup schedulerGroup);
}
