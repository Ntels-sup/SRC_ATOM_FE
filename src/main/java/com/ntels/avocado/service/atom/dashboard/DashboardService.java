package com.ntels.avocado.service.atom.dashboard;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.dao.atom.dashboard.DashboardMapper;
import com.ntels.avocado.domain.atom.dashboard.AlarmChart;
import com.ntels.avocado.domain.atom.dashboard.AlarmTotal;
import com.ntels.avocado.domain.atom.dashboard.ReleaseLog;
import com.ntels.avocado.domain.common.SessionUser;

@Service
public class DashboardService {

	@Autowired
	private DashboardMapper dashboardMapper; 
	
	@Autowired(required=true)
	private HttpServletRequest request;
	
	
	public AlarmTotal getTotalAlarm() {
		return dashboardMapper.getTotalAlarm();
	}
	
	public List<AlarmChart> getAlarmChart() {
		return dashboardMapper.getAlarmChart();
	}
	
	public List<ReleaseLog> getReleaseLog(String language) {
		return dashboardMapper.getReleaseLog(language);
	}
	
	public List<ReleaseLog> getReleaseLog() {
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		String language = "en"; // 기본 en
		language = sessionUser.getLanguage();
		return this.getReleaseLog(language);
	}
}
