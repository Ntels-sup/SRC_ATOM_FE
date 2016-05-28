package com.ntels.avocado.service.atom.fault.alarmlevel;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ntels.avocado.dao.atom.fault.alarmlevel.AlarmLevelMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.fault.alarmhistory.AlarmHistory;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmCodeDef;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmLevel;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmMonitor;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmMonitorDef;
import com.ntels.ncf.utils.MessageUtil;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class AlarmLevelService {

	@Autowired
	private AlarmLevelMapper alarmLevelMapper;
	
	public Paging listAlmCodeDef(AlmCodeDef condition) {
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}

		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());

		String pkg_names = condition.getPkg_names();
		String[] pkg_name_arr = pkg_names.split(",");
		condition.setPkg_name_arr(pkg_name_arr);
		
		
		List<AlmCodeDef> list = alarmLevelMapper.listAlmCodeDef(condition, condition.getStart(), condition.getEnd());
		int count = alarmLevelMapper.countAlmCodeDef(condition);
		
		//결과를 DTO에 저장
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(count);		
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		
		return paging;
	}
	
	public List<LinkedHashMap<String, String>> listExcel(AlmCodeDef condition) {
		String pkg_names = condition.getPkg_names();
		String[] pkg_name_arr = pkg_names.split("%2C");
		condition.setPkg_name_arr(pkg_name_arr);
		return alarmLevelMapper.listExcel(condition);
	}
	
	public AlmCodeDef getAlmCodeDef(AlmCodeDef almCodeDef) {
		return alarmLevelMapper.getAlmCodeDef(almCodeDef);
	}
	
	public List<AlmMonitorDef> listAlmMonitorDef(AlmCodeDef almCodeDef) {
		List<AlmMonitorDef> ret = new ArrayList<AlmMonitorDef>();
		try {
			List<AlmMonitorDef> monitorDefList = alarmLevelMapper.listAlmMonitorDef(almCodeDef);
			for (AlmMonitorDef almMonitorDef: monitorDefList) {
				List<AlmMonitorDef> targetList = alarmLevelMapper.listAlmMonitorTarget(almMonitorDef);
				for (AlmMonitorDef target: targetList) {
					AlmMonitorDef inst = (AlmMonitorDef)almMonitorDef.clone();
					inst.setTarget(target.getTarget());
					inst.setAlmLevelList(alarmLevelMapper.listAlmLevel(inst));
					ret.add(inst);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return ret;
	}
	
	public String saveAlmCodeDef(AlmCodeDef almCodeDef) {
		if (alarmLevelMapper.saveAlmCodeDef(almCodeDef) <= 0) {
			return MessageUtil.getMessage("msg.fault.alarmlevel.save.almcodedef.fail");
		}
		return "succ";
	}
	
	public List<AlmLevel> listAlmLevel(AlmMonitorDef almMonitorDef) {
		return alarmLevelMapper.listAlmLevel(almMonitorDef);
	}
	
	@Transactional
	public String saveAlmLevel(String jsonStr) {
		try {
			Gson gson = new Gson();
			JsonParser parser = new JsonParser();
			JsonArray jsonArr = (JsonArray)parser.parse(jsonStr);
			for (int i=0;i<jsonArr.size();i++) {
				JsonObject jsonObj = (JsonObject)jsonArr.get(i);
				AlmMonitor almMonitor = gson.fromJson(jsonObj, AlmMonitor.class);
				AlmMonitor savedAlmMonitor = alarmLevelMapper.getAlmMonitor(almMonitor);
				if (savedAlmMonitor == null) {
					if (alarmLevelMapper.insertAlmMonitor(almMonitor) <= 0) {
						throw new Exception(MessageUtil.getMessage("msg.fault.alarmlevel.save.alarmmonitor.fail"));
					}
				} else {
					almMonitor.setMonitor_id(savedAlmMonitor.getMonitor_id());
				}
				
				alarmLevelMapper.deleteAlmLevel(almMonitor);
				
				String severity_ccds = almMonitor.getSeverity_ccds();
				String values = almMonitor.getValues();
				String[] severity_ccd_arr = severity_ccds.split(",");
				String[] value_arr = values.split(",");
				
				for (int j=0;j<severity_ccd_arr.length;j++) {
					String severity_ccd = severity_ccd_arr[j];
					String value = value_arr[j];
					AlmLevel almLevel = new AlmLevel();
					almLevel.setMonitor_id(almMonitor.getMonitor_id());
					almLevel.setSeverity_ccd(severity_ccd);
					almLevel.setValue(value);
					if (alarmLevelMapper.insertAlmLevel(almLevel) <= 0) {
						throw new Exception(MessageUtil.getMessage("msg.fault.alarmlevel.save.alarmlevel.fail"));
					}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ex.getMessage();
		}
		return "succ";
	}
}
