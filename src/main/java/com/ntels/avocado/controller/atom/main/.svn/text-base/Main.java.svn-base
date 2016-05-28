package com.ntels.avocado.controller.atom.main;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.dashboard.DashboardService;
import com.ntels.avocado.service.atom.monitor.MonitorService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value = "/main")
public class Main {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	private String language = DateUtil.getDateRepresentation();
	
	private String thisUrl = "atom/dashboard";
	
	@Autowired
	private DashboardService dashboardService;
	
	@Autowired
	private MonitorService monitorService; 
	
	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value = "main")
	public String main(
    		HttpServletRequest request,
			@RequestParam(required=false) String loginResult,
			@RequestParam(required=false) String dueDay,
			HttpSession session,
			Model model
		) {
		
		logger.debug( "[mirinae.maru] loginResult : " + loginResult );
		commonService.insertOperationHist("1"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		// 날짜 표시 형식
		String dateformat = sessionUser.getPatternDate();
		model.addAttribute("dateformat", dateformat);
		
		TimeZone timeZone = Calendar.getInstance().getTimeZone();  
		model.addAttribute("TimeZome", timeZone.getID());
		
		model.addAttribute( "loginResult", loginResult );
		model.addAttribute( "dueDay", dueDay );	// 패스워드 만료가 몇일 남았는지 알려주기 위함.
		
		// 관리자가 등록한 패스워드 이거나 패스둬드 만료일이 몇일 남지 않았을 경우.
//		if( loginResult.equals(Consts.LOGIN_RESULT.NOTI_PASSWD_EXPIRE+"") || loginResult.equals(Consts.LOGIN_RESULT.NOTI_DEFAULT_PASSWD+"") ) {
//			
//			int KEY_SIZE = Consts.SECURITY.KEY_SIZE;	// 512
//			HttpSession session = request.getSession(false);
//			
//			try {
//				KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
//				generator.initialize(KEY_SIZE);
//
//				KeyPair keyPair = generator.genKeyPair();
//				KeyFactory keyFactory = KeyFactory.getInstance("RSA");
//
//				PublicKey publicKey = keyPair.getPublic();
//				PrivateKey privateKey = keyPair.getPrivate();
//
//				// 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
//				session.setAttribute("rsaPrivateKey", privateKey);
//				
//				// 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
//				RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
//
//				String publicKeyModulus = publicSpec.getModulus().toString(16);
//				String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
//				
//				model.addAttribute("publicKeyModulus", publicKeyModulus);
//				model.addAttribute("publicKeyExponent", publicKeyExponent);
//			} 
//	        catch (Exception ex) {
//				ex.printStackTrace();
//			}
//		}
		
		return "main/main";
	}
	
	@RequestMapping(value = "totalAlarm")	
	public String totalAlarm(Model model
							,HttpSession session
							,HttpServletRequest request) throws ParseException  {
		model.addAttribute("alarm", dashboardService.getTotalAlarm());
		Gson gson = new Gson();
		model.addAttribute("alarmChart", gson.toJson(dashboardService.getAlarmChart()));
		return thisUrl + "/totalAlarm";
	}
	
	@RequestMapping(value="listTopResource", method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> listTopResource() {
		return monitorService.listTopResource();
	}
	
	
	
	@RequestMapping(value = "releaseLog")	
	public String releaseLog(Model model
							,HttpSession session
							,HttpServletRequest request) throws ParseException  {
		model.addAttribute("releaseLog", dashboardService.getReleaseLog());
		return thisUrl + "/releaseLog";
	}
	
	
	
}
