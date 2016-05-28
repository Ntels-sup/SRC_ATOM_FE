package com.ntels.avocado.service.atom.general.backup.dailypolicy;

import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.dao.atom.general.backup.dailypolicy.DailyMapper;
import com.ntels.avocado.domain.atom.general.backup.dailypolicy.Daily;
import com.ntels.avocado.exception.AtomException;

/**
 * The Class DailyService.
 */
@Service
public class DailyService {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	/** The daily mapper. */
	@Autowired
	private DailyMapper dailyMapper;
	
	/**
	 * Back infomation.
	 */
	public Map<String, Object> backupInfomation(String node_id) throws AtomException {
		return dailyMapper.backupInfomation(node_id);
	}
	
	/**
	 * Delete infomation.
	 */
	public Map<String, Object> deleteInfomation(String node_id) throws AtomException {
		return dailyMapper.deleteInfomation(node_id);
	}
	
	/**
	 * Save action.
	 */
	@Transactional
	public int saveAction(Daily daily, String user_id) throws AtomException {

		int result = 0;
		
		result += dailyMapper.updateBackup(daily.getBackup_input_data(),  daily.getNode_id(), user_id, "110000");
		result += dailyMapper.updateBackup(daily.getBackup_output_data(), daily.getNode_id(), user_id, "110001");
		result += dailyMapper.updateBackup(daily.getBackup_hist_data(), daily.getNode_id(), user_id, "110002");
		result += dailyMapper.updateBackup(daily.getBackup_stat_data(), daily.getNode_id(), user_id, "110003");
		result += dailyMapper.updateBackup(daily.getBackup_log_data(), daily.getNode_id(), user_id, "110004");
		result += dailyMapper.updateBackup(daily.getBackup_pm_data(), daily.getNode_id(), user_id, "110005");
		result += dailyMapper.updateBackup(null,  daily.getNode_id(), user_id, "110013");
		result += dailyMapper.updateBackup(null,  daily.getNode_id(), user_id, "110014");
		
		result += dailyMapper.updateDelete(daily.getDelete_input_data(), daily.getNode_id(), user_id, "110000");
		result += dailyMapper.updateDelete(daily.getDelete_output_data(), daily.getNode_id(), user_id, "110001");
		result += dailyMapper.updateDelete(daily.getDelete_hist_data(),  daily.getNode_id(), user_id, "110002");
		result += dailyMapper.updateDelete(daily.getDelete_stat_data(),  daily.getNode_id(), user_id, "110003");
		result += dailyMapper.updateDelete(daily.getDelete_log_data(), daily.getNode_id(), user_id, "110004");
		result += dailyMapper.updateDelete(daily.getDelete_pm_data(), daily.getNode_id(), user_id, "110005");
		result += dailyMapper.updateDelete(daily.getComp_input_data(), daily.getNode_id(), user_id, "110006");
		result += dailyMapper.updateDelete(daily.getComp_output_data(), daily.getNode_id(), user_id, "110007");
		result += dailyMapper.updateDelete(daily.getComp_hist_data(), daily.getNode_id(), user_id, "110008");
		result += dailyMapper.updateDelete(daily.getComp_stat_data(), daily.getNode_id(), user_id, "110009");
		result += dailyMapper.updateDelete(daily.getComp_log_data(),  daily.getNode_id(), user_id, "110010");
		result += dailyMapper.updateDelete(daily.getComp_pm_data(), daily.getNode_id(), user_id, "110011");
		result += dailyMapper.updateDelete( null, daily.getNode_id(), user_id, "110013");
		result += dailyMapper.updateDelete( null, daily.getNode_id(), user_id, "110014");
		result += dailyMapper.updateDelete( null, daily.getNode_id(), user_id, "110015");
		result += dailyMapper.updateDelete( null, daily.getNode_id(), user_id, "110016");
		
		return result;
	}
}