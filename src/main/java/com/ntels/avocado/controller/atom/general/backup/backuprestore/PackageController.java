/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.controller.atom.history.execute.CdrExecuteHistoryController.java 
 * Controll 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  : Kidae, Kim
 * @버전  :
 * @작성일 : 2012.08.30
 *   
 * @작업 완료
 *    XXX-XX-XX : Finish
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.controller.atom.general.backup.backuprestore;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.Condition;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.PackageDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.general.backup.backuprestore.PackageService;
import com.ntels.avocado.service.atom.general.webcli.WebCliService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;

// TODO: Auto-generated Javadoc

/**
 * The Class PackageController.
 */
@Controller
@RequestMapping(value = "/atom/general/backup/backuprestore")
public class PackageController{

	/** The logger. */
	private Logger logger = Logger.getLogger(this.getClass());
	
	/** The package service. */
	@Autowired
	private PackageService packageService;
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private CommonService commonService ;
	
	/** Commandlineinterface. */
	@Autowired
	private WebCliService commandLineService;	
	
	/** The this url. */
	private String thisUrl = "atom/general/backup/backuprestore";	
	
	/**
	 * List.
	 *
	 * @return the string
	 */
	@RequestMapping(value = "list")
	public String list(
			HttpServletRequest request,
			Model model) {
		
		model.addAttribute("listMntGroup", packageService.listMntGroup());
		model.addAttribute("System" ,commonCodeService.listSystemId());		// TAT_NODE 조회
		model.addAttribute("Package",commonCodeService.listPackageId());	// TAT_PKG 조회
		
		return thisUrl + "/list";
	}	
	
	/**
	 * List action.
	 *
	 * @param search_node_id the search_node_id
	 * @param model the model
	 * @return the string
	 */
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(
			@Valid Condition condition, 
			BindingResult result, 
			Model model, 
			HttpServletRequest request) {
		
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.USER.SESSION_USER);
		
		logger.debug( "[mirinae.maru] sessionUser.getLanguage : " + sessionUser.getLanguage() );
		logger.debug( "[mirinae.maru] system_id2 : " + condition.getSystem_id2() );
		
		//시스탬 멀티 -> Array
		if(condition.getSystem_id2() != null){
			String[] systemArray = condition.getSystem_id2().split(",");
			condition.setSystemArray(systemArray);	
		}
		condition.setLanguage(sessionUser.getLanguage());
		
		String[] x = condition.getSystemArray();
		for( int i=0; i<x.length; i++ ) {
			logger.debug( "[mirinae.maru] systemId["+i+"] : " + x[i] );
		}
		
		PackageDomain pkgDomain = new PackageDomain();
		pkgDomain.setSystem_id2(condition.getSystem_id2());
		pkgDomain.setLanguage(condition.getLanguage());
		pkgDomain.setSystemArray(condition.getSystemArray());	
		
		List<PackageDomain> list = packageService.listBackupHist(pkgDomain);

		logger.debug( "[mirinae.maru] list size : " + list.size() );
		
		model.addAttribute("condition", condition);
		model.addAttribute("list", list);
		model.addAttribute("cnt", list.size());
		
		commonService.insertOperationHist( Consts.OPERATION_HISTORY.SEARCH );
		
		return thisUrl + "/listAction";
	}	
	

	
	@RequestMapping(value = "getNodeNo")
	public @ResponseBody String getNodeNo(
			@RequestParam String node_name) {
		String result = null;
		
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		
		result = commandLineService.getNodeNo( node_name );

		logger.debug( "[mirinae.maru] getPkgName result : " + result );
		logger.debug( "[mirinae.maru] getPkgName result : " + result );
		logger.debug( "[mirinae.maru] getPkgName result : " + result );
		logger.debug( "[mirinae.maru] getPkgName result : " + result );
		logger.debug( "[mirinae.maru] getPkgName result : " + result );
		
		return result;
	}
	
	/**
	 * Download.
	 *
	 * @param text the text
	 * @param response the response
	 * @return the string
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "download", method = RequestMethod.POST)
	public String download(
			@RequestParam(required=false) @Param(value="status_text") String status_text
		  , HttpServletResponse response) throws Exception {
		
		commonService.insertOperationHist( Consts.OPERATION_HISTORY.SEARCH );
		
		status_text = status_text.replaceAll("-", "=");
		//System.err.println(status_text);
		StringBuilder fileName = new StringBuilder();
		fileName.append("Backup");
		fileName.append("_");
		fileName.append((new SimpleDateFormat("ddMMyyyy_HHmmss")).format(Calendar.getInstance( ).getTime())); //시간형
		fileName.append(".");
		fileName.append("txt");
		
		fileName.insert(0, "attachment; filename=\""); //attach 용으로 변경
		fileName.append("\""); //마무리
		
		response.setHeader("Content-Disposition",fileName.toString());
		
		FileCopyUtils.copy(status_text.getBytes(), response.getOutputStream());
		
		return null;
	}
}