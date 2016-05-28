package com.ntels.avocado.dao.atom.general.backup.dailypolicy;

import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

/**
 * The Interface DailyMapper.
 */
@Component
public interface DailyMapper {
	
	Map<String,Object> backupInfomation(
			@Param(value = "node_id") String node_id
	);
	
	Map<String,Object> deleteInfomation(String node_id);
		
	int updateBackup(
			  @Param("store_data") String store_data
			, @Param("node_id") String node_id
			, @Param("user_id") String user_id			
			, @Param("group_code") String group_code);
	
	int updateDelete(
			  @Param("store_data") String store_data
			, @Param("node_id") String node_id
			, @Param("user_id") String user_id			
			, @Param("group_code") String group_code);
}