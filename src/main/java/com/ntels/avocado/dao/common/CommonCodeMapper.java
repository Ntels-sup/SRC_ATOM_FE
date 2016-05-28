package com.ntels.avocado.dao.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

@Component
public interface CommonCodeMapper {
	
	List<Map<String, String>> listAlphaYn();
	
	List<Map<String, String>> listSystemId();
	
	List<Map<String, String>> listPackageId();

	int listPackageCnt();
	
	List<Map<String, String>> listNodeType();
	
	List<Map<String, String>> listAlarmType();
		
	List<Map<String, String>> listAlarmGroup();

	List<Map<String, String>> listAlarmSeverity();
	
	List<Map<String, String>> listAlmGroup();
	
	List<Map<String, String>> listClearedFlag();
	
	List<Map<String, String>> listSearchType();
	
	List<Map<String, String>> listScheduleCycleType();
	
	int getSystemCount();
	
	String DbdatePattern(@Param(value="locale")String locale);
	
	String DbdatePatternMonth(@Param(value="locale")String locale);
	
	String getSysDate(@Param(value = "format") String format);
	
	String getSysDateTypeII(@Param(value = "format") String format, @Param(value = "startPos") int startPos, @Param(value = "length") int length);
	
	List<Map<String, String>> listRscName();
	
	List<Map<String, String>> rscGrpId(@Param(value="rscGrpId")String rscGrpId);
	
	int rscUseYn (@Param(value="rscGrpId")String rscGrpId);
	
	String getNowHour();
	
	String getNowMin();
	
	String getNowDate(@Param(value="language")String language);
	
	String getNowDateTime(@Param(value="language")String language); 
	
	List<HashMap<String, String>> listFilterGrpNm(@Param(value="system_id") String system_id, @Param(value="package_id") String package_id, @Param(value="service_id") String service_id);
	

	/*Statistics*/
	List<Map<String, String>> listStsTable();
	
	List<Map<String, String>> listStsComboGroup();
	
	List<Map<String, String>> listStsComboValue();
	/*Statistics*/
	
	String typeOfColumn(@Param(value="tableName") String tableName ,@Param(value="columnName") String columnName);
	
	List<Map<String, String>> listSystemName();
	
	String getViewColList(@Param(value="tableName") String tableName ,@Param(value="pri_key_yn") String pri_key_yn);
	
	String getDbName(@Param(value="tableName") String tableName);
	
	String getTopCountColumn(@Param(value="tableName") String tableName);

	String getChartColumn(@Param(value="tableName") String tableName);
	
	int getChartColumnCount(@Param(value="tableName") String tableName);
	
	int getHourlyCollectTime();
	
	int getDailyCollectTime();
	
	List<Map<String, String>> listDefaultAlarmLevel();
	
	/*History*/
	List<Map<String, String>> listRcdTable();
	
	List<Map<String, String>> listRcdComboGroup();
	
	List<Map<String, String>> listRcdComboValue();
	/*History*/
	
	List<Map<String, String>> listTraceKeyword();
	List<Map<String, String>> listTraceMode();
	
	List<Map<String, String>> listPart();
	
	List<Map<String, String>> dailyPolicyDefault();
	
	int getPerFomHourlyCollectTime(@Param(value="pkgName")String pkgName);
	
	int getPerFomDailyCollectTime(@Param(value="pkgName")String pkgName);
	
	String getNodeName(@Param(value="nodeNo")String nodeNo);
	
	List<Map<String, String>> listTableName(@Param(value="pkgNm") String pkgNm);
}

