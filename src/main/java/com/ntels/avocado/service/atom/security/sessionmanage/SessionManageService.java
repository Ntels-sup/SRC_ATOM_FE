package com.ntels.avocado.service.atom.security.sessionmanage;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.dao.atom.security.sessionmanage.SessionManageMapper;
import com.ntels.avocado.dao.common.CommonCodeMapper;
import com.ntels.avocado.domain.atom.history.login.LoginHistoryExtended;
import com.ntels.avocado.domain.atom.security.sessionmanage.SessionManageDomain;

@Service
public class SessionManageService {

	@Autowired
	private SessionManageMapper sessionManageMapper;
	
	@Autowired
	private CommonCodeMapper commonCodeMapper; 	
	
	public int count(SessionManageDomain sessionManageDomain){
		return sessionManageMapper.count(sessionManageDomain);
	}
	
	public List<SessionManageDomain> list(SessionManageDomain sessionManageDomain, int page, int perPage){
		int start = ((page - 1) * perPage);
		int end = perPage;
		
		return sessionManageMapper.list(sessionManageDomain, start, end);
	}

	@Transactional
	public int updateSessionStop(String userIp, String sessionId, String gatewayIp) {					
		LoginHistoryExtended loginHistory = new LoginHistoryExtended();

        String logoutDate = commonCodeMapper.getSysDate("%Y%m%d");
        String logoutTime = commonCodeMapper.getSysDateTypeII("%H%i%s", 1, 6);

        Map<String, String> sessionLoginDate = sessionManageMapper.getSessionLoginDate(userIp, sessionId, gatewayIp);

        loginHistory.setUserId(userIp);
        loginHistory.setSessionId(sessionId);
        loginHistory.setLoginIp(gatewayIp);
        loginHistory.setLoginDate(sessionLoginDate.get("LOGIN_DATE"));
        loginHistory.setLogoutDate(logoutDate+logoutTime);
        loginHistory.setLogoutResult("F");
        loginHistory.setDescription("session stop");
        
    	//로그아웃 이력처리
        sessionManageMapper.updateLogoutSessionStop(loginHistory);    
    	
		return sessionManageMapper.updateSessionStop(userIp, sessionId);
	}
	
    public List<LinkedHashMap<String, String>> listExcel(SessionManageDomain sessionManageDomain) {
    	return sessionManageMapper.listExcel(sessionManageDomain);
    }
}
