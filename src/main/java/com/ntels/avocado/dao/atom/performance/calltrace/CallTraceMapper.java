package com.ntels.avocado.dao.atom.performance.calltrace;

import org.apache.ibatis.annotations.Param;

import com.ntels.avocado.domain.atom.performance.calltrace.TrcHist;

public interface CallTraceMapper {
	
	public int insertTraceHist(TrcHist trcHist);
	public int updateTraceHist(TrcHist trcHist);
	public String getDateText(@Param(value="date")String date, @Param(value="language")String language);
	public TrcHist getTraceHist(TrcHist trcHist);

}
