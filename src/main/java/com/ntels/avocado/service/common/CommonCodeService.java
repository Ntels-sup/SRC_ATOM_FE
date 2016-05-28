package com.ntels.avocado.service.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.common.CommonCodeMapper;


@Service
public class CommonCodeService {
	
	@Autowired
	public CommonCodeMapper commonCodeMapper;
	
	public List<Map<String, String>> listAlphaYn(){
		return commonCodeMapper.listAlphaYn();
	}	
	
	public List<Map<String, String>> listSystemId(){
		return commonCodeMapper.listSystemId();
	}
	
	public List<Map<String, String>> listPackageId(){
		return commonCodeMapper.listPackageId();
	}

	public List<Map<String, String>> listNodeType(){
		return commonCodeMapper.listNodeType();
	}
	
	public int listPackageCnt(){
		return commonCodeMapper.listPackageCnt();
	}
	
	public List<Map<String, String>> listAlarmType(){
		return commonCodeMapper.listAlarmType();
	}
	
	public List<Map<String, String>> listAlarmGroup(){
		return commonCodeMapper.listAlarmGroup();
	}
	
	public List<Map<String, String>> listAlarmSeverity(){
		return commonCodeMapper.listAlarmSeverity();
	}
	
	public List<Map<String, String>> listAlmGroup(){
		return commonCodeMapper.listAlmGroup();
	}
	
	public List<Map<String, String>> listClearedFlag(){
		return commonCodeMapper.listClearedFlag();
	}
	
	public List<Map<String, String>> listSearchType(){
		return commonCodeMapper.listSearchType();
	}
	
	public List<Map<String, String>> listScheduleCycleType(){
		return commonCodeMapper.listScheduleCycleType();
	}
	
	public int getSystemCount(){
		return commonCodeMapper.getSystemCount();
	}
	
	public List<Map<String, String>> listPart(){
		return commonCodeMapper.listPart();
	}
	
	public List<Map<String, String>> dailyPolicyDefault(){
		return commonCodeMapper.dailyPolicyDefault();
	}
	/**
	  * <PRE>
	 * 1. MethodName: DbdatePattern
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 데이타베이스 날짜 포멧(년,월,일) 조회.
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 22. 오후 7:17:34
	 * </PRE>
	 *   @return String
	 *   @param locale
	 */
	public String DbdatePattern(String locale){
		return commonCodeMapper.DbdatePattern(locale);
	}
	
	
	public String getSysDate(String format){
		return commonCodeMapper.getSysDate(format);
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: DbdatePatternMonth
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 데이타베이스 날짜 포멧(년,월) 조회
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 23. 오후 1:01:31
	 * </PRE>
	 *   @return String
	 *   @param locale
	 */
	public String DbdatePatternMonth(String locale){
		return commonCodeMapper.DbdatePatternMonth(locale);
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: listRscName
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : Resource Name 콤보
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 24. 오전 10:43:29
	 * </PRE>
	 *   @return List<Map<String,String>>
	 */
	public List<Map<String, String>> listRscName(){
		return commonCodeMapper.listRscName();
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: listRscId
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : Resource ID 콤보
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 24. 오전 11:45:54
	 * </PRE>
	 *   @return List<Map<String,String>>
	 *   @param rscGrpId
	 */
	public List<Map<String, String>> listRscId(String rscGrpId){
		return commonCodeMapper.rscGrpId(rscGrpId);
	}
	
	public boolean rscUseYn(String rscGrpId){
		return (commonCodeMapper.rscUseYn(rscGrpId)  > 1 );
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: getNowHour
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 데이타베이스 기준 현재 (시간) 두자리 조회
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 29. 오후 4:58:09
	 * </PRE>
	 *   @return String
	 */
	public String getNowHour(){
		return commonCodeMapper.getNowHour();
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: getNowMin
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 데이타베이스 기준 현재 (분) 두자리 조회
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 29. 오후 4:58:12
	 * </PRE>
	 *   @return String
	 */
	public String getNowMin(){
		return commonCodeMapper.getNowMin();
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: getNowDate
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 데이타베이스 기준 현재 (날짜)언어별 (년월일) 조회
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 30. 오전 10:07:55
	 * </PRE>
	 *   @return String
	 *   @param language
	 */
	public String getNowDate(String language){
		return commonCodeMapper.getNowDate(language);
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: getNowDateTime
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 데이타베이스 기준 현재 (날짜)언어별 (년월일시분초) 조회(엑셀파일 다운용)
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 30. 오전 10:07:58
	 * </PRE>
	 *   @return String
	 *   @param language
	 */
	public String getNowDateTime(String language){
		return commonCodeMapper.getNowDateTime(language);
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: listStsTable
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : Performance Statistics 테이블 콤보 리스트
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 1. 오전 11:23:04
	 * </PRE>
	 *   @return List<Map<String,String>>
	 */
	public List<Map<String, String>> listStsTable(){
		return commonCodeMapper.listStsTable();
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: listStsComboGroup
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 테이블당 콤보 그룹 조회
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 1. 오후 1:22:54
	 * </PRE>
	 *   @return List<Map<String,String>>
	 */
	public List<Map<String, String>> listStsComboGroup(){
		return commonCodeMapper.listStsComboGroup();
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: listStsComboValue
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 콤보 옵션 값 조회
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 1. 오후 3:10:46
	 * </PRE>
	 *   @return List<Map<String,String>>
	 */
	public List<Map<String, String>> listStsComboValue(){
		return commonCodeMapper.listStsComboValue();
	}

	
	
	/**
	  * <PRE>
	 * 1. MethodName: typeOfColumn
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 조회 컬럼의 속성 조회 (INT,BIGINT , String , VARCHAR .....)
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 4. 오전 11:22:01
	 * </PRE>
	 *   @return String
	 *   @param table
	 *   @param column
	 *   @return 
	 */
	public String typeOfColumn(String tableName , String columnName){
		return commonCodeMapper.typeOfColumn(tableName,columnName);
	}

	public List<HashMap<String, String>> listFilterGrpNm(
			String system_id, 
			String package_id, 
			String service_id) {
		
		return commonCodeMapper.listFilterGrpNm(system_id, package_id, service_id);
	}

	
	/**
	  * <PRE>
	 * 1. MethodName: listSystemName
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : Performance Statistics용 (이름기준)
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 4. 오후 4:35:09
	 * </PRE>
	 *   @return List<Map<String,String>>
	 *   @return
	 */
	public List<Map<String, String>> listSystemName(){
		return commonCodeMapper.listSystemName();
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: getViewColList
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 테이블 display (조회조건 및 result view)  컬럼 조회
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 4. 오후 5:06:56
	 * </PRE>
	 *   @return String
	 *   @param tableName
	 *   @param pri_key_yn
	 *   @return
	 */
	public String getViewColList(String tableName , String pri_key_yn){
	    String Columns = "";
	    if(commonCodeMapper.getViewColList(tableName,pri_key_yn) != null){
	    	Columns = commonCodeMapper.getViewColList(tableName,pri_key_yn);
	    }
		return Columns;
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: getDbName
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : tableName으로 테이블스페이스 조회. DB_NAME
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 5. 오후 3:33:18
	 * </PRE>
	 *   @return String
	 *   @return
	 */
	public String getDbName(String tableName){
		return commonCodeMapper.getDbName(tableName);
	}
	
	
	/**
	  * <PRE>
	 * 1. MethodName: getTopCountColumn
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : top 10 대상 sum컬럼명 조회.
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 5. 오후 8:40:08
	 * </PRE>
	 *   @return String
	 *   @param tableName
	 *   @return
	 */
	public String getTopCountColumn(String tableName){
		return commonCodeMapper.getTopCountColumn(tableName);
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: getChartColumn
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : 차트에 보여줄 컬럼항목 조회.
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 5. 오후 9:17:03
	 * </PRE>
	 *   @return String
	 *   @param tableName
	 *   @return
	 */
	public String getChartColumn(String tableName){
		return commonCodeMapper.getChartColumn(tableName);
	}
	
	
	/**
	  * <PRE>
	 * 1. MethodName: listRcdTable
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : Performance History Table list
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 11. 오후 12:58:45
	 * </PRE>
	 *   @return List<Map<String,String>>
	 *   @return
	 */
	public List<Map<String, String>> listRcdTable(){
		return commonCodeMapper.listRcdTable();
	}
	

	/**
	  * <PRE>
	 * 1. MethodName: listRcdComboGroup
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : History 테이블 당 콤보 옵션 조회
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 11. 오후 1:01:56
	 * </PRE>
	 *   @return List<Map<String,String>>
	 *   @return
	 */
	public List<Map<String, String>> listRcdComboGroup(){
		return commonCodeMapper.listStsComboGroup();
	}
	

	/**
	  * <PRE>
	 * 1. MethodName: listRcdComboValue
	 * 2. ClassName : CommonCodeService
	 * 3. Comment   : History 콤보 value 값 조회
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 11. 오후 1:01:59
	 * </PRE>
	 *   @return List<Map<String,String>>
	 *   @return
	 */
	public List<Map<String, String>> listRcdComboValue(){
		return commonCodeMapper.listStsComboValue();
	}

	public List<Map<String, String>> listTraceKeyword(){
		return commonCodeMapper.listTraceKeyword();
	}
	
	public List<Map<String, String>> listTraceMode(){
		return commonCodeMapper.listTraceMode();
	}
	
	public int getChartColumnCount(String tableName){
		return commonCodeMapper.getChartColumnCount(tableName);
	}
	
	public int getHourlyCollectTime(){
		return commonCodeMapper.getHourlyCollectTime();
	}
	
	public int getDailyCollectTime(){
		return commonCodeMapper.getDailyCollectTime();
	}
	
	public List<Map<String, String>> listDefaultAlarmLevel() {
		return commonCodeMapper.listDefaultAlarmLevel();
	}
	
	public int getPerFomHourlyCollectTime(String pkgName){
		return commonCodeMapper.getPerFomHourlyCollectTime(pkgName);
	}
	
	public int getPerFomDailyCollectTime(String pkgName){
		return commonCodeMapper.getPerFomDailyCollectTime(pkgName);
	}
	
	public String getNodeName(String nodeNo){
		return commonCodeMapper.getNodeName(nodeNo);
	}
	
	public List<Map<String, String>> listTableName(String pkgNm){
		return commonCodeMapper.listTableName(pkgNm);
	}
}
