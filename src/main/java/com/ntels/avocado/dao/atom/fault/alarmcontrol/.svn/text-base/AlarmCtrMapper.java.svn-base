package com.ntels.avocado.dao.atom.fault.alarmcontrol;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.fault.alarmcontrol.AlarmCtrDomain;

@Component
public interface AlarmCtrMapper {

	List<AlarmCtrDomain> listAlarmCtr();
	
	List<AlarmCtrDomain> listAlarmCtrLevel();
	
	List<AlarmCtrDomain> listAlarmCtrCode();
	
	List<Map<String, String>> listAlarmCodeDef();
	
	int controlDefChk(@Param(value = "control_id") String control_id);
	
	int modifyControlDef(@Param(value = "control_id") String control_id, @Param(value = "control_type") String control_type, @Param(value = "use_yn") String use_yn);
	
	int addControlDef(@Param(value = "control_id") String control_id, @Param(value = "control_type") String control_type, @Param(value = "use_yn") String use_yn);
	
	int removeAlarmCtrLevel(@Param(value = "control_id") String control_id);
	
	int removeAlarmCtrCode(@Param(value = "control_id") String control_id);
	
	int addAlarmCtrLevel(@Param(value = "condition") AlarmCtrDomain alarmCtrDomain);
	
	int addAlarmCtrCode(@Param(value = "condition") AlarmCtrDomain alarmCtrDomain);
}
