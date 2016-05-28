package com.ntels.avocado.controller.atom.login;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.text.ParseException;
import java.util.Locale;

import javax.crypto.Cipher;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.atom.config.software.Condition;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.login.LoginService;
import com.ntels.avocado.service.common.CommonService;

@Controller
@RequestMapping(value = "/atom/login")
public class LoginController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
    private ServletContext servletContext;

    @Autowired
    private LoginService loginService;
    
    @Autowired
	private CookieLocaleResolver localeResolver;
	
	@Autowired
	private CommonService commonService;
    
//    @Autowired
//	private SoftwareService softwareService;
    
//    private String language = DateUtil.getDateRepresentation();
    
//	@Autowired
//	private CommonService commonService;
	
	/**
     * 로그인 화면
     * @param request
     * @return
     * @throws FileNotFoundException 
     */
    @RequestMapping(value = "login")
    public String login(
    		HttpServletRequest request,
    		HttpServletResponse response,
    		Model model) throws FileNotFoundException {
    	
    	logger.debug( "/login/login ip :" + request.getRemoteAddr());
    	
    	HttpSession session = request.getSession(false);

    	logger.debug( "[mirinae.maru] session : " + session );
    	logger.debug( "[mirinae.maru] session.getAttribute(Consts.USER.SESSION_USER) : " + session.getAttribute(Consts.USER.SESSION_USER) );

    	if( session!=null && session.getAttribute(Consts.USER.SESSION_USER)!=null) {
	    	SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
	    	
	    	logger.debug( "[mirinae.maru] userId : " + sessionUser.getUserId() );
			
	    	if( sessionUser!=null && sessionUser.getUserId()!=null ) {
				try {
					response.sendRedirect(Consts.URL_MAIN);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
    	}
        
    	// FIXME mirinae.maru packageTitleName관련 주석처리함... 해도 되는지?
    	// String packageTitleName = (String) servletContext.getAttribute("package.title.name");
    	// System.err.println("packageTitleName==>"+packageTitleName);
    	// session.setAttribute("packageTitleName", packageTitleName);
        
        logger.debug("▶▷▶▷session  : "+ session);
        
        Condition condition = new Condition();
        Locale locale = localeResolver.resolveLocale(request);
        condition.setLanguage(locale.getLanguage());

        logger.debug( "locale : " + locale );
        logger.debug( "locale language : " + locale.getLanguage() );
        
        // FIXME mirinae.maru packageTitleName관련 주석처리함... 해도 되는지?
        // model.addAttribute("versionInfo", softwareService.getLastVersion(condition));
        
//        if(request.getSession(false).getAttribute(Consts.USER.SESSION_USER) != null) {
//        	model.addAttribute("authenticationSuccess", true);
//        	model.addAttribute("authMenu", session.getAttribute("authMenu"));
//        }
        
        return "atom/login/login";
    }
	
	/**
     * 로그인 처리 프로세스
     * @param user_id
     * @param password
     * @param model
     * @param request
     * @return  -1 : 에러
     *           0 : 로그인 성공
	 *           1 : 로그인 실패 (패스워드 실패)
	 *           2 : 로그인 실패 (없는 계정) 
	 *           5 : config.properties 설정 파일 에러
	 *         100 : 필수파라메터(아아디 / 비번) null 에러
	 *         200 : 총 접속 유저수 제한
	 *         300 : 사용자 계정 잠김 여부
	 *         400 : 중복 접속 유저인지 여부
	 *         500 : 접속 IP 확인
	 *         600 : 계정 기한 만료
	 *         700 : 계정기한 만료하기전 알림(노티)
	 *         800 : 패스워드 기간 만료하기전 알림(노티)
	 *         900 : 모름
     * @throws FileNotFoundException 
     * @throws ParseException 
     * @throws  
     */
    @RequestMapping(value = "loginAction", method = RequestMethod.POST)
    public void loginAction(@RequestParam(required=false) String userId
                          , @RequestParam(required=false) String password
                          , HttpServletRequest request
                          , Model model) throws FileNotFoundException, ParseException {


    	if (logger.isDebugEnabled()) {
    		logger.debug( "[mirinae.maru] userId A: "+ userId );
    		logger.debug( "[mirinae.maru] password A : "+ password );
    	}
    	
    	HttpSession session = request.getSession();
    	
    	PrivateKey privateKey = (PrivateKey) session.getAttribute("rsaPrivateKey");
        if (privateKey == null) {
           model.addAttribute("SECURITY_MSG", "ERROR_NOT_EXIST_PRIVATE_KEY");
        }
        
        try {
        	userId = decryptRsa(privateKey, userId);
        	password = decryptRsa(privateKey, password);
        } catch (Exception ex) {
        	model.addAttribute("SECURITY_MSG", "ERROR_DECRYPT_FAIL");
        }
        
        logger.debug( "[mirinae.maru] userId B : "+ userId );
    	logger.debug( "[mirinae.maru] password B : "+ password );
    	
    	int result = loginService.loginAction(userId, password, request, servletContext);

    	logger.debug( "[mirinae.maru] login result : "+ result );
    	
    	model.addAttribute("result", result);
		
		int dueDay;
		
		//남은 날짜를 전달한다.
		if (result == Consts.LOGIN_RESULT.NOTI_ACCOUNT_EXPIRE) { //계정 만료 전 노티   		
			dueDay = loginService.searchAccountDueDate(userId);
			if (dueDay < 0) { 
				dueDay = 0;
			}
			model.addAttribute("dueDay", dueDay);
		} 
		else if (result == Consts.LOGIN_RESULT.NOTI_PASSWD_EXPIRE) { //패스워드 노티 전후 노티
			dueDay = loginService.searchPasswordDueDate(userId);
			if (dueDay < 0) { 
				dueDay = 0;
			}
			model.addAttribute("dueDay", dueDay);
		}
		else if (result == Consts.LOGIN_RESULT.FAIL_PASSWORD) { // 패스워드 오류 일경우...
			
			int failCount = loginService.searchLoginFailCount(userId);
			model.addAttribute("failCount", failCount);
			
			if( failCount!=-1 ) {
				model.addAttribute("limitCount", loginService.searchLoginFailLimit(userId));
			}
			
		} 
		
		//boolean authMenu = loginService.authMenu(userId, password);
		//HttpSession session = request.getSession(true);
		//session.setAttribute("authMenu", authMenu);
		//model.addAttribute("authMenu", authMenu);
    }  
	
	/**
     * changePasswordAction
     * 비밀번호 변경 프로세스
     * @throws FileNotFoundException 
     * @throws ParseException 
     * @throws  
     */
    @RequestMapping(value = "changePasswordAction", method = RequestMethod.POST)
    public void changePasswordAction(
    						@RequestParam(required=false) String current_password
                          , @RequestParam(required=false) String new_password
                          , HttpServletRequest request
                          , Model model) throws FileNotFoundException, ParseException {


    	HttpSession session = request.getSession(false);
    	SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
    	
    	logger.debug( "[mirinae.maru] userId : "+ sessionUser.getUserId() );
    	logger.debug( "[mirinae.maru] current_password A : "+ current_password );
    	logger.debug( "[mirinae.maru] new_password A : "+ new_password );
    	
    	PrivateKey privateKey = (PrivateKey) session.getAttribute("rsaPrivateKey");
        if (privateKey == null) {
           model.addAttribute("SECURITY_MSG", "ERROR_NOT_EXIST_PRIVATE_KEY");
        }
        
        try {
        	current_password 	= decryptRsa(privateKey, current_password);
        	new_password 		= decryptRsa(privateKey, new_password);
        } 
        catch (Exception ex) {
        	model.addAttribute("SECURITY_MSG", "ERROR_DECRYPT_FAIL");
        }
        
        logger.debug( "[mirinae.maru] current_password B : "+ current_password );
    	logger.debug( "[mirinae.maru] new_password B : "+ new_password );
    	
    	int result = loginService.changePasswordAction(sessionUser.getUserId(), current_password, new_password);

    	logger.debug( "[mirinae.maru] changePasswordAction result : "+ result );
    	
    	commonService.insertOperationHist( Consts.OPERATION_HISTORY.UPDATE );
    	
    	model.addAttribute("result", result);
    }   
	
	@RequestMapping(value = "logoutAction_dist", method = RequestMethod.POST)
	public String logoutAction_dist(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		if (sessionUser != null) session.invalidate();
		return "redirect:/";
	}
	
	/**
     * 로그아웃
     * @param request
     * @return
     */
    @RequestMapping(value = "logoutAction", method = RequestMethod.POST)
    public String logoutAction(HttpServletRequest request) { 
    	loginService.logoutAction(request);
    	return "redirect:/";
    }
	
	//사용자 로그인여부 체크
    @RequestMapping(value = "checkLoginAction", method = RequestMethod.POST)
    public void checkLoginAction(Model model, HttpServletRequest request) {
    	Object obj = request.getSession().getAttribute( Consts.USER.SESSION_USER );
		
		//세션 검사 후 없다면 redirectPage로 이동
		if (obj != null) {
			String userId = ((SessionUser) obj).getUserId();
			if(userId==null || userId.isEmpty()) {
				model.addAttribute("loginYN", "N");
			} else {
				model.addAttribute("loginYN", "Y");
			}
		}
		else{
			model.addAttribute("loginYN", "N");
		}
    }
	
	private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }
	
	/**
	 * 16진 문자열을 byte 배열로 변환한다.
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
	
	/**
	 * 로그인 처리를 위한 키 생성
	 * @param session
	 * @return
	 */
    @RequestMapping(value = "makeDummy", method = RequestMethod.POST)
	public void makeDummy(
			@RequestParam(required=false) String dummy,
    		HttpSession session,
    		Model model) {

    	logger.debug( "[mirinae.maru] makeDummy start..." );
    	logger.debug( "[mirinae.maru] makeDummy dummy : " + dummy );
   		
   		int KEY_SIZE 				= Consts.SECURITY.KEY_SIZE;	// 512
   		String publicKeyModulus 	= null;
   		String publicKeyExponent 	= null;
        try {
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

			publicKeyModulus 	= publicSpec.getModulus().toString(16);
			publicKeyExponent 	= publicSpec.getPublicExponent().toString(16);
		} 
        catch (Exception ex) {
			ex.printStackTrace();
		}
		
		model.addAttribute("publicKeyModulus", publicKeyModulus);
		model.addAttribute("publicKeyExponent", publicKeyExponent);
    }  
}
