package com.ntels.avocado.dao.atom.fault.tcaconfig;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmCodeDef;
import com.ntels.avocado.domain.atom.fault.tcaconfig.TcaConfig;
import com.ntels.avocado.domain.atom.fault.tcaconfig.TcaConfigDomain;



@Component
public interface TcaConfigMapper {
	List<TcaConfig> list(@Param(value = "condition") TcaConfigDomain condition, @Param(value = "start") int start, @Param(value = "end") int end);
	
	Map<String, Object> count(@Param(value = "condition") TcaConfigDomain condition);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") TcaConfigDomain condition);
	
	List<Map<String, String>> StatisticsTable(@Param(value = "node_no") String node_no);
	
	List<Map<String, String>> StatisticsColumn(@Param(value = "node_no") String node_no,@Param(value = "table_name") String table_name);
	
	int insertTca(@Param(value = "condition") TcaConfigDomain condition);
	
	int insertTcaRule(@Param(value = "condition") TcaConfigDomain condition);
	
	int updateTca(@Param(value = "condition") TcaConfigDomain condition);
	
	int updateTcaRule(@Param(value = "condition") TcaConfigDomain condition);
	
	int deleteTca(@Param(value = "condition") TcaConfigDomain condition);
	
	int deleteTcaRule(@Param(value = "condition") TcaConfigDomain condition);
	
	String getNodeName(@Param(value = "node_no") String node_no);
	
	TcaConfig getTcaInfo(@Param(value = "condition") TcaConfigDomain condition);
}
