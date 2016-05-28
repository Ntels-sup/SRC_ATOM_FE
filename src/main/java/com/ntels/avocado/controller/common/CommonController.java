package com.ntels.avocado.controller.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.login.LoginService;
import com.ntels.avocado.service.common.CommonService;

@Controller
@RequestMapping(value = "/common")
public class CommonController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private LoginService loginService;
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: removeRecent
	 * 2. ClassName : CommonController
	 * 3. Comment   : 최근 목록 삭제 기능
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 16. 오후 1:21:48
	 * </PRE>
	 *   @return List<Map<String,Object>>
	 *   @param menuId
	 *   @param request
	 *   @return
	 */
	@RequestMapping(value = "removeRecent", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> removeRecent(@RequestParam (required=false, defaultValue="") String menuId, HttpSession session) {
		System.err.println("menuId:"+menuId);
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("menuId", menuId);
		param.put("userId", sessionUser.getUserId());
		
		int result = commonService.removeRecent(param);
		if (result > 0) return commonService.findRecent(sessionUser.getUserId());
		return null;
	}
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: keepAlive
	 * 2. ClassName : CommonController
	 * 3. Comment   : 세션 유지 기능
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 16. 오후 2:54:08
	 * </PRE>
	 *   @return int
	 *   @param session
	 *   @param request
	 *   @return
	 */
	@RequestMapping(value = "keepAlive", method = RequestMethod.POST)
	public @ResponseBody int keepAlive(HttpSession session, HttpServletRequest request) {
		
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		if (sessionUser == null) {
			return Consts.VALID_USER.NULL;
		} 
		else {
			//접속 가능한자인지 체크한다. return 2;
			String isValidUser = loginService.isValidUser(sessionUser.getUserId(), session.getId());
			
			if( !isValidUser.equals(Consts.ACCOUNT_STATUS.YES) ) {
				session.invalidate();
				return Consts.VALID_USER.INVALID;
			}
		}
		
		return Consts.VALID_USER.VALID;
	}
	
	
	@RequestMapping(value = "listTree", method = RequestMethod.POST)
	public @ResponseBody Object listTree() {
		Gson gson = new Gson();
		return gson.toJson(commonService.listTree());
	}
	
	
	@RequestMapping(value = "insertOperationHist", method = RequestMethod.POST)
	public @ResponseBody int insertOperationHist(OperationHistDomain operationHist, HttpSession session, HttpServletRequest request) {
		
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		operationHist.setUser_id(sessionUser.getUserId());
		operationHist.setMenu_id(String.valueOf(session.getAttribute("menuId")));
		operationHist.setOper_ip(request.getRemoteAddr());
		operationHist.setOper_message("1"); //TAT_COMMON_CODE의 그룹코드(200003) 참고
		//operationHist.setOper_cmd("oper cmd");
		//operationHist.setCmd_arg("cmd arg");
		//operationHist.setResult_yn("Y");
		//operationHist.setFail_reason("응답 실패");
		
		return commonService.insertOperationHist(operationHist);
	}
}
