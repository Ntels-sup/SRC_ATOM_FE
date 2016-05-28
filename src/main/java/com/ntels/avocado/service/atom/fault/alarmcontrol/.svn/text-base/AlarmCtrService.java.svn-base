package com.ntels.avocado.service.atom.fault.alarmcontrol;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import com.ntels.avocado.dao.atom.fault.alarmcontrol.AlarmCtrMapper;
import com.ntels.avocado.domain.atom.fault.alarmcontrol.AlarmCtrDomain;

@Service
public class AlarmCtrService {

	@Autowired
	private AlarmCtrMapper alarmCtrMapper;
	
	public List<AlarmCtrDomain> listAlarmCtr(){
		return alarmCtrMapper.listAlarmCtr();
	}
	
	public List<AlarmCtrDomain> listAlarmCtrLevel(){
		return alarmCtrMapper.listAlarmCtrLevel();
	}
	
	public List<AlarmCtrDomain> listAlarmCtrCode(){
		return alarmCtrMapper.listAlarmCtrCode();
	}
	
	public List<Map<String, String>> listAlarmCodeDef(){
		return alarmCtrMapper.listAlarmCodeDef();
	}
	
	@Transactional
	public void modifyAction(AlarmCtrDomain alarmCtrDomain){
		//json -> List<AlarmCtrDomain> 파싱
		Gson gson = new Gson();
		JsonParser parser = new JsonParser();
		JsonArray jsonArray = (JsonArray)parser.parse(alarmCtrDomain.getAlarmCtrList());
		List<AlarmCtrDomain> alarmCtrList = gson.fromJson(jsonArray, new TypeToken<List<AlarmCtrDomain>>(){}.getType());
		
		// use_yn(y,n) 값 파싱, control_type(level, code) 값 파싱 
		String alarmConfigList[] = alarmCtrDomain.getAlarmCtrConfigList().split(",");
		
		//alarm control_type(레레별 : 0, 코드별 : 1), use_yn(y,n) update
		for(int j=0; j<alarmConfigList.length; j++){
			String control_id = alarmConfigList[j].split(":")[0];
			String control_type = alarmConfigList[j].split(":")[1];
			String use_yn = alarmConfigList[j].split(":")[2];
			
			//control_def 데이터가 잇는지 확인
			if(alarmCtrMapper.controlDefChk(control_id) > 0){
				alarmCtrMapper.modifyControlDef(control_id, control_type ,use_yn);				
			} else {
				alarmCtrMapper.addControlDef(control_id, control_type ,use_yn);
			}
			
			//alarm 코드 , 레벨 테이블 delete level:0, code:1
			if(control_type.equals("0")){
				alarmCtrMapper.removeAlarmCtrLevel(control_id);
			} else if(control_type.equals("1")){
				alarmCtrMapper.removeAlarmCtrCode(control_id);
			}
		}
		
		//alarm 레벨별 성정, 코드별 설정 데이터 insert
		if(alarmCtrList != null){
			for(int i=0; i< alarmCtrList.size(); i++){
				//level - 레벨ㄹ별 성정 insert
				if(alarmCtrList.get(i).getControl_type().equals(alarmCtrList.get(i).getLevelConfig())){
					alarmCtrMapper.addAlarmCtrLevel(alarmCtrList.get(i));
				//code - 코드별 설정 insert
				} else if(alarmCtrList.get(i).getControl_type().equals(alarmCtrList.get(i).getCodeConfig())){
					alarmCtrMapper.addAlarmCtrCode(alarmCtrList.get(i));
				}
			}
		}
	}
}
