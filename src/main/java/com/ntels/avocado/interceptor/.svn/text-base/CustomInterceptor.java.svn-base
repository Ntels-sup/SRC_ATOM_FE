package com.ntels.avocado.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.security.menu.MenuService;
import com.ntels.avocado.service.common.CommonService;

public class CustomInterceptor extends HandlerInterceptorAdapter {
	private Logger logger = Logger.getLogger(this.getClass());
	private String redirectPage;
	private List<String>  noSession;
	@Autowired
	private CommonService commonService;
	@Autowired
	private MenuService menuService;
	
	@Override
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler) throws Exception  {

		logger.debug( "requestURI : " + request.getRequestURI() );
		
		//listNoSession를 호출하면 무조건 통과
		for(int i = 0; i < noSession.size(); i++) {
			
				
			String temp = noSession.get(i).trim();
//			logger.debug( "noSessionURI : " + temp );
			
			if (temp.equals(request.getRequestURI())) {
				return super.preHandle(request, response, handler);
			}
		}
		
		HttpSession session = request.getSession(true);
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		
		if (sessionUser == null) {
			response.sendRedirect(redirectPage);
			return false;
		}
		
		Map<String, Object> map = commonService.findMenuName(request.getRequestURI(), sessionUser.getUserId());		
		if (map != null) {
			
			session.setAttribute("menuId", map.get("MENU_ID"));	
			session.setAttribute("titleName", map.get("MENU_NAME"));			
			session.setAttribute("authType", map.get("AUTH_TYPE"));	
			
			logger.info("▶▷▶▷▶preHandle sessionUser ->" +sessionUser.toString());
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("menuId", (Integer) map.get("MENU_ID"));
			param.put("userId", sessionUser.getUserId());
			
			commonService.removeRecent(param);
			commonService.addRecent(param); //메뉴 등록
		}
		
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler, 
			ModelAndView mv) throws Exception {
		
		//listNoSession를 호출하면 무조건 통과
		for(int i = 0; i < noSession.size(); i++) {
			String temp = noSession.get(i).trim();
			//logger.info( "▶▷▶▷▶postHandle noSession ->" + temp );
			//logger.info( "▶▷▶▷▶postHandle aa ->" + request.getRequestURI() );
			if (temp.equals(request.getRequestURI())) {
				return;
			}
		}
		super.postHandle(request, response, handler, mv);
		if (mv != null) {
			HttpSession session = request.getSession(true);
			SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
			if  (sessionUser != null) {
				logger.info("▶▷▶▷▶postHandle sessionUser ->" +sessionUser.toString());
				mv.addObject("listAuthorizationMenu", menuService.listAuthorizationMenu(sessionUser.getUserLevelId())); //권한별 ATOM 메뉴 조회
				List<Map<String, Object>> list = menuService.listPackageMenu(sessionUser.getUserId(), sessionUser.getUserLevelId()); //권한별 패키지 메뉴 조회
				Map<String, Object> map = null;
				StringBuilder one = new StringBuilder();
				StringBuilder two = new StringBuilder();
				StringBuilder three = new StringBuilder();
				
				int childCount = 0;
				int childSubCount = 0;
				int t = 0;
				int k = 0;
				int p = 0;
				int j = 0;
				
				for(int i=0; i < list.size();i++) {
					map = list.get(i);
					
					if (one.length() == 0) one.append("<ul data-menu='main' class='menu__level'><div class='high'>");					
					
					Long long_depth = (Long) map.get("DEPTH");
					int int_depth = long_depth.intValue();
					
					if (int_depth == 0) {
						if ("N".equals((String)map.get("IS_FOLDER"))) {
							one.append("<li class='menu__item'><a class='menu__link' href='"+(String)map.get("MENU_PATH")+"'>"+(String)map.get("MENU_NAME")+"</a></li>");
						} else if ("Y".equals((String)map.get("IS_FOLDER"))) {
							Long l = (Long) map.get("CHILD_CNT");
							childCount = l.intValue();
							t += 1;
							one.append("<li class='menu__item'><a class='menu__link' data-submenu='submenu-"+t+"' href='#'>"+(String)map.get("MENU_NAME")+"</a></li>");
						}
					}
					
					if (int_depth == 1) {
						j += 1;
						if (j == 1) two.append("<ul data-menu='submenu-"+t+"' class='menu__level'>");
						if ("N".equals((String)map.get("IS_FOLDER"))) {
							two.append("<li class='menu__item'><a class='menu__link' href='"+(String)map.get("MENU_PATH")+"'>"+(String)map.get("MENU_NAME")+"</a></li>");
						} else if ("Y".equals((String)map.get("IS_FOLDER"))) {
							Long l = (Long) map.get("CHILD_CNT");
							childSubCount = l.intValue();
							k += 1;
							two.append("<li class='menu__item'><a class='menu__link' data-submenu='submenu-"+t+"-"+k+"' href='#'>"+(String)map.get("MENU_NAME")+"</a></li>");
						}
						
						if (childCount == j) {
							two.append("</ul>");
							j = 0;
						}
					}
					
					if (int_depth == 2) {	
						p += 1;
						if (p == 1) three.append("<ul data-menu='submenu-"+t+"-"+k+"' class='menu__level'>");
						if (childSubCount >= p) {							
							three.append("<li class='menu__item'><a class='menu__link' href='"+(String)map.get("MENU_PATH")+"'>"+(String)map.get("MENU_NAME")+"</a></li>");
														
						}
						if (childSubCount == p) {
							three.append("</ul>");
							p = 0;
						}
						
					}
					
					if (list.size() == (i+1)) {
						one.append("</div></ul>");						
					}
				}
				//System.err.println(one.toString() + two.toString() + three.toString());
				mv.addObject("listPackageMenu", one.toString() + two.toString() + three.toString()); //권한별 패키지 메뉴 조회
				mv.addObject("listRecent", commonService.findRecent(sessionUser.getUserId())); //최근 메뉴 목록
			}
		}
	}
	
	@Override
	 public void afterCompletion(
			 HttpServletRequest request, 
			 HttpServletResponse response, 
			 Object handler, 
			 Exception ex) throws Exception {
		
		super.afterCompletion(request, response, handler, ex);
	}
	
	public String getRedirectPage() {
		return redirectPage;
	}
	public void setRedirectPage(String redirectPage) {
		this.redirectPage = redirectPage;
	}

	public List<String> getNoSession() {
		return noSession;
	}
	public void setNoSession(List<String> noSession) {
		this.noSession = noSession;
	}
	
	
}

