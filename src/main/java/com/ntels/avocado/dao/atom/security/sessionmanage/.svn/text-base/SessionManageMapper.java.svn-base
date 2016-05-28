package com.ntels.avocado.dao.atom.security.sessionmanage;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.history.login.LoginHistoryExtended;
import com.ntels.avocado.domain.atom.security.sessionmanage.SessionManageDomain;

@Component
public interface SessionManageMapper {

	int count(@Param(value = "condition") SessionManageDomain sessionManageDomain);
	
	List<SessionManageDomain> list(@Param("condition") SessionManageDomain sessionManageDomain
	                             , @Param("start") int start
	                             , @Param("end") int end);
	
	Map<String, String> getSessionLoginDate(@Param("userId") String userId
										  , @Param("sessionId") String sessionId
										  , @Param("gatewayIp") String gatewayIp);
	
	int updateLogoutSessionStop(@Param("loginHistoryExtended") LoginHistoryExtended loginHistoryExtended);
	
	int updateSessionStop(@Param(value = "userId") String userId
						, @Param(value = "sessionId") String sessionId);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") SessionManageDomain sessionManageDomain);
}
