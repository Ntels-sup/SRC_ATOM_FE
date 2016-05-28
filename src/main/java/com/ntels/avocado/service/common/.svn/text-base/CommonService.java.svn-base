package com.ntels.avocado.service.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.dao.common.CommonMapper;
import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;
import com.ntels.avocado.domain.common.SessionUser;

/**
 * 
 * <PRE>
 * 1. ClassName: CommonService
 * 2. FileName : CommonService.java
 * 3. Package  : com.ntels.avocado.service.common
 * 4. Comment  :
 * 5. 작성자   : hancheonsu
 * 6. 작성일   : 2016. 3. 4. 오후 6:49:37
 * 7. 변경이력
 *		이름	:	일자	: 변경내용
 *     ——————————————————————————————————————————————————————
 *		hancheonsu :	2016. 3. 4.	: 신규개발.
 * </PRE>
 */
@Service
public class CommonService {
	@Autowired
	private CommonMapper commonMapper;
	
	@Autowired(required=true)
	private HttpServletRequest request;
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: findLocalePattern
	 * 2. ClassName : CommonService
	 * 3. Comment   :
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 4. 오후 6:50:34
	 * </PRE>
	 *   @return String
	 *   @param locale
	 *   @return
	 */
	public Map<String, Object> findLocalePattern(String language) {
		return commonMapper.findLocalePattern(language);
	}
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: findMenuName
	 * 2. ClassName : CommonService
	 * 3. Comment   :
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 14. 오후 8:39:03
	 * </PRE>
	 *   @return String
	 *   @param url
	 *   @return
	 */
	public Map<String, Object> findMenuName(String url, String userId) {
		return commonMapper.findMenuName(url, userId);
	}
	
	@Transactional
	public int addRecent(Map<String, Object> map) {
		return commonMapper.addRecent(map);
	}
	
	@Transactional
	public int removeRecent(Map<String, Object> map) {
		return commonMapper.removeRecent(map);
	}
	
	public List<Map<String, Object>> findRecent(String userId) {
		return commonMapper.findRecent(userId);
	}
	
	/**
	 * 트리 만들기
	 * <PRE>
	 * 1. MethodName: listTree
	 * 2. ClassName : CommonService
	 * 3. Comment   :
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 4. 18. 오후 6:32:14
	 * </PRE>
	 *   @return List<Map<String,Object>>
	 *   @return
	 */
	public List<Map<String, Object>> listTree() {
		
		List<Map<String, Object>> listTree = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listPackage = commonMapper.listTreePackage();
		List<Map<String, Object>> listNode = null;
		Map<String, Object> mapPackage = null;
		String packageName;
		
		for (int i = 0; i < listPackage.size(); i++) {
			mapPackage = listPackage.get(i);
			packageName = (String) mapPackage.get("id");
			listNode = commonMapper.listTreeNode(packageName);
			
			mapPackage.put("children", listNode);
			listTree.add(mapPackage);
			
		}
		return listTree;
	}
	
	/**
	 * 운영 이력 입력
	 * <PRE>
	 * 1. MethodName: insertOperationHist
	 * 2. ClassName : CommonService
	 * 3. Comment   :
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 4. 18. 오후 6:32:43
	 * </PRE>
	 *   @return int
	 *   @param operationHist
	 *   @return
	 */
	@Transactional
	public int insertOperationHist(OperationHistDomain operationHist) {
		return commonMapper.insertOperationHist(operationHist);
	}
	
	@Transactional
	public int updateOperationHist(OperationHistDomain operationHist) {
		return commonMapper.updateOperationHist(operationHist);
	}
	
	public int insertOperationHist(String oper_message) {
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		
		OperationHistDomain operationHist = new OperationHistDomain();
		operationHist.setUser_id(sessionUser.getUserId());
		operationHist.setMenu_id(String.valueOf(session.getAttribute("menuId")));
		operationHist.setOper_ip(request.getRemoteAddr());
		 //TAT_COMMON_CODE의 그룹코드(200003) 참고
		operationHist.setOper_message(oper_message); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		return this.insertOperationHist(operationHist);
	}
	
	public OperationHistDomain getNewOperationHist(String oper_message) {
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		
		OperationHistDomain operationHist = new OperationHistDomain();
		operationHist.setUser_id(sessionUser.getUserId());
		operationHist.setMenu_id(String.valueOf(session.getAttribute("menuId")));
		operationHist.setOper_ip(request.getRemoteAddr());
		 //TAT_COMMON_CODE의 그룹코드(200003) 참고
		operationHist.setOper_message(oper_message); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		int nRet = this.insertOperationHist(operationHist);
		if (nRet > 0) {
			return operationHist;
		} else {
			return null;
		}
	}
}
