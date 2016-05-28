package com.ntels.avocado.dao.atom.management.trace;

import java.util.Map;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.management.trace.Condition;


@Component
public interface TraceDetailMapper {
	
	List<Map<String, String>> listUDR(
			@Param(value = "condition") Condition condition,
			@Param(value = "start") int start,
			@Param(value = "end") int end,
			@Param(value="res_type") String res_type);
	List<Map<String, String>> listCDR(
			@Param(value = "condition") Condition condition,
			@Param(value = "start") int start,
			@Param(value = "end") int end,
			@Param(value="res_type") String res_type);

	int countUDR(@Param(value = "condition") Condition condition, @Param(value="res_type") String res_type);
	int countCDR(@Param(value = "condition") Condition condition, @Param(value="res_type") String res_type);
	
	List<Map<Integer, String>> listDataFormat(
			@Param(value = "condition") Condition condition,
			@Param(value="result_type") String result_type,
			@Param(value="res_type") String res_type);
	
	List<Map<String, String>> listUDRExcel(@Param(value="condition") Condition condition, @Param(value="res_type") String res_type);
	List<Map<String, String>> listCDRExcel(@Param(value="condition") Condition condition, @Param(value="res_type") String res_type);
	
}
