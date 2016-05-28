package com.ntels.avocado.controller.atom.security.usermanage;

import java.net.URLDecoder;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.crypto.Cipher;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.security.usermanage.UserManageDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.security.usermanage.UserManageService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.crypto.Sha256Util;

@Controller
@RequestMapping(value="/atom/security/usermanage")
public class UserManageController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private UserManageService userManageService;
	private String thisUrl = "atom/security/usermanage";
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	//operationHist 처리를 위한 autowired
	@Autowired 
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 12. 오후 2:59:19
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(UserManageDomain userManageDomain, Model model) throws Exception{
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		model.addAttribute("searchVal", userManageDomain);
		model.addAttribute("listUserGroup", userManageService.listUserGroup());
		return thisUrl + "/list";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 12. 오후 2:59:28
	 * </PRE>
	 *   @return String
	 *   @param userManageDomain
	 *   @param page
	 *   @param perPage
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="listAction", method=RequestMethod.POST)
	public String list(UserManageDomain userManageDomain
		             , @RequestParam(required=false, defaultValue="1") int page
		             , @RequestParam(required=false, defaultValue="10") int perPage
		             , HttpSession session
		             , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userManageDomain.setUserLevelId(sessionUser.getUserLevelId());
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		userManageDomain.setLanguage(language);
		
		//paging
		Paging paging = new Paging();
		List<UserManageDomain> list = null;
		int count = 0;
		
		count = userManageService.count(userManageDomain);
		if(count > 0){list = userManageService.list(userManageDomain, page, perPage);}

		//paging을 위한 DTO를 생성
		paging.setLists(list); //결과를 DTO에 저장
		paging.setTotalCount(count); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(perPage); //페이징수
		
		model.addAttribute("userManageList", paging);
		return thisUrl + "/listAction";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: detail
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 12. 오후 6:14:36
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="detail")
	public String detail(UserManageDomain userManageDomain
			           , HttpSession session
			           , Model model) throws Exception{
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userManageDomain.setUserLevelId(sessionUser.getUserLevelId());
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		userManageDomain.setLanguage(language);
		
		UserManageDomain userManage = new UserManageDomain();
		userManage = userManageService.detail(userManageDomain);
		
		model.addAttribute("searchVal", userManageDomain);
		model.addAttribute("userLevelId", sessionUser.getUserLevelId());
		model.addAttribute("userManage", userManage);
		return thisUrl + "/detail";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: add
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 14. 오후 6:12:37
	 * </PRE>
	 *   @return String
	 *   @param userManageDomain
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="add")
	public String add(UserManageDomain userManageDomain
			        , HttpSession session
			        , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userManageDomain.setUserLevelId(sessionUser.getUserLevelId());
		// data format
		String dateformat = sessionUser.getPatternDate();
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		userManageDomain.setLanguage(language);

		//---------password 암호화 객체---------
		int KEY_SIZE = Consts.SECURITY.KEY_SIZE;	// 512
        
		KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
		generator.initialize(KEY_SIZE);

		KeyPair keyPair = generator.genKeyPair();
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");

		PublicKey publicKey = keyPair.getPublic();
		PrivateKey privateKey = keyPair.getPrivate();

		// 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
		session.setAttribute("rsaPrivateKey", privateKey);
		
		// 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
		RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);

		String publicKeyModulus = publicSpec.getModulus().toString(16);
		String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
		
		model.addAttribute("publicKeyModulus", publicKeyModulus);
		model.addAttribute("publicKeyExponent", publicKeyExponent);
		//---------password 암호화 객체---------
		
		model.addAttribute("searchVal", userManageDomain);
		model.addAttribute("language", language);
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("nowDate", commonCodeService.getNowDate(language));
		model.addAttribute("account_exfire", DateUtil.addDays(commonCodeService.getNowDate(language), 365, dateformat));
		model.addAttribute("userLevelId", sessionUser.getUserLevelId());
		model.addAttribute("listUserGroup", userManageService.listUserGroup());
		model.addAttribute("listUserLevel", userManageService.listUserLevel(sessionUser.getUserLevelId()));
		return  thisUrl + "/add";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: addAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 5. 3. 오후 1:45:39
	 * </PRE>
	 *   @return void
	 *   @param userManageDomain
	 *   @param session
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="addAction", method=RequestMethod.POST)
	public void addAction(UserManageDomain userManageDomain
			            , HttpSession session
			            , Model model) throws Exception{
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("3");
		
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userManageDomain.setUserLevelId(sessionUser.getUserLevelId());
		// data format
		String dateformat = sessionUser.getPatternDate();
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		userManageDomain.setLanguage(language);
		
		//---------password RSA복호화---------
    	PrivateKey privateKey = (PrivateKey) session.getAttribute("rsaPrivateKey");
        userManageDomain.setPasswd(decryptRsa(privateKey, userManageDomain.getPasswd()));
        //---------password RSA복호화---------
        
		//passwd 암호화
		userManageDomain.setPasswd(Sha256Util.getEncrypt(userManageDomain.getPasswd()));
		//default passwd yn -> Y
		userManageDomain.setDefault_passwd_yn("Y");
		//passwd life cycle
		int passwd_life_cycle = userManageService.getPasswdLifeCycle(userManageDomain.getUserLevelId());
		userManageDomain.setPasswd_life_cycle(passwd_life_cycle);
			
		//account exfire date Format 변환.
		userManageDomain.setAccount_exfire(DateUtil.dateFormatChangeToString(userManageDomain.getAccount_exfire() ,dateformat));			
		
		userManageService.addAction(userManageDomain);
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 12. 오후 8:14:07
	 * </PRE>
	 *   @return String
	 *   @param userManageDomain
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="modify")
	public String modify(UserManageDomain userManageDomain
	                   , HttpSession session
	                   , Model model) throws Exception{
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userManageDomain.setUserLevelId(sessionUser.getUserLevelId());
		// data format
		String dateformat = sessionUser.getPatternDate();
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		userManageDomain.setLanguage(language);


		UserManageDomain userManage = new UserManageDomain();
		userManage = userManageService.detail(userManageDomain);

		//---------password RSA암호화 객체---------
		int KEY_SIZE = Consts.SECURITY.KEY_SIZE;	// 512
        
		KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
		generator.initialize(KEY_SIZE);

		KeyPair keyPair = generator.genKeyPair();
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");

		PublicKey publicKey = keyPair.getPublic();
		PrivateKey privateKey = keyPair.getPrivate();

		// 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
		session.setAttribute("rsaPrivateKey", privateKey);
		
		// 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
		RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);

		String publicKeyModulus = publicSpec.getModulus().toString(16);
		String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
		
		model.addAttribute("publicKeyModulus", publicKeyModulus);
		model.addAttribute("publicKeyExponent", publicKeyExponent);
		//---------password RSA암호화 객체---------
		
		model.addAttribute("searchVal", userManageDomain);
		model.addAttribute("language", language);
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("userLevelId", sessionUser.getUserLevelId());
		model.addAttribute("listUserGroup", userManageService.listUserGroup());
		model.addAttribute("listUserLevel", userManageService.listUserLevel(sessionUser.getUserLevelId()));
		model.addAttribute("userManage", userManage);
		return thisUrl + "/modify";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modifyAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 14. 오후 6:12:46
	 * </PRE>
	 *   @return void
	 *   @param userManageDomain
	 *   @param session
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="modifyAction", method=RequestMethod.POST)
	public void modifyAction (UserManageDomain userManageDomain
						    , HttpSession session
			                , Model model) throws Exception{
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("5");
		
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userManageDomain.setUserLevelId(sessionUser.getUserLevelId());
		// data format
		String dateformat = sessionUser.getPatternDate();
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		userManageDomain.setLanguage(language);

		//---------password RSA복호화---------
    	PrivateKey privateKey = (PrivateKey) session.getAttribute("rsaPrivateKey");
        userManageDomain.setPasswd(decryptRsa(privateKey, userManageDomain.getPasswd()));
        //---------password RSA복호화---------
        
		//user level id = 1 (Security Administrator) 일때 처리  
		if(userManageDomain.getUserLevelId().equals("1")){
			//passwd 암호화
			userManageDomain.setPasswd(Sha256Util.getEncrypt(userManageDomain.getPasswd()));
			
			//passwd  change check
			String passwd = userManageService.getPasswd(userManageDomain.getUser_id());
			if(!passwd.equals(userManageDomain.getPasswd())){
				userManageDomain.setDefault_passwd_yn("Y");
				int passwd_life_cycle = userManageService.getPasswdLifeCycle(userManageDomain.getUserLevelId());
				userManageDomain.setPasswd_life_cycle(passwd_life_cycle);
			} else {
				userManageDomain.setDefault_passwd_yn("N");
				userManageDomain.setPasswd_exfire(DateUtil.dateFormatChangeToString(userManageDomain.getPasswd_exfire() ,dateformat));
			}
			
			//account exfire date Format 변환.
			userManageDomain.setAccount_exfire(DateUtil.dateFormatChangeToString(userManageDomain.getAccount_exfire() ,dateformat));			
		}
		
		userManageService.modifyAction(userManageDomain);
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: removeAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 12. 오후 8:08:21
	 * </PRE>
	 *   @return void
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="removeAction", method=RequestMethod.POST)
	public void removeAction(UserManageDomain userManageDomain, Model model) throws Exception{
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("4");
		
		userManageService.removeAction(userManageDomain);
	}
	

	/**
	 * <PRE>
	 * 1. MethodName: duplChkUserId
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 21. 오후 9:23:04
	 * </PRE>
	 *   @return void
	 *   @param userId
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="duplChkUserId", method=RequestMethod.POST)
	public void duplChkUserId(@RequestParam("userId") String userId, Model model) throws Exception{
		int duplCnt = userManageService.duplChkUserId(userId);
		
		model.addAttribute("duplCnt", duplCnt);
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: exportAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 14. 오후 6:25:56
	 * </PRE>
	 *   @return String
	 *   @param userManageDomain
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="exportAction", method=RequestMethod.POST)
	public String exportAction(UserManageDomain userManageDomain
			                 , HttpSession session
			                 , Model model) throws Exception{
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userManageDomain.setUserLevelId(sessionUser.getUserLevelId());
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		userManageDomain.setLanguage(language);
		
        //디코딩
		userManageDomain.setOrderBy(URLDecoder.decode(userManageDomain.getOrderBy()));
        String filename = URLDecoder.decode(userManageDomain.getTitleName());
        
		List<LinkedHashMap<String, String>> list = userManageService.listExcel(userManageDomain);
		
		List<String> title = new ArrayList<String>() ;
		/** (title) header setting */
		for(String mapKey : list.get(0).keySet()){
			title.add(mapKey);
		}
		
		/**  dataType : 모든항목 String 일경우 dataType 생략해도 됨 */
		/*List<String> dataType = Arrays.asList("S", "S", "S", "S", "S");  
		model.addAttribute("dataType", dataType);	*/	                 
		/** dataType */
		
		/** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 */
		model.addAttribute("list", list);
		model.addAttribute("title", title);
	 	model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
	 	model.addAttribute("filename", filename);
        return "excelViewer";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: decryptRsa
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 5. 3. 오후 2:08:41
	 * </PRE>
	 *   @return String
	 *   @param privateKey
	 *   @param securedValue
	 *   @return
	 *   @throws Exception
	 */
	private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }
	
	/**
	 * <PRE>
	 * 1. MethodName: hexToByteArray
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 5. 3. 오후 2:08:44
	 * </PRE>
	 *   @return byte[]
	 *   @param hex
	 *   @return
	 */
	public static byte[] hexToByteArray(String hex) {
	    if (hex == null || hex.length() % 2 != 0) {
	        return new byte[]{};
	    }
	
	    byte[] bytes = new byte[hex.length() / 2];
	    for (int i = 0; i < hex.length(); i += 2) {
	        byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
	        bytes[(int) Math.floor(i / 2)] = value;
	    }
	    return bytes;
	} 
}
