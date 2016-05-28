/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.controller.ofcs.commandline.CommandLineController.java 
 * xxx 하기 위한 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  :
 * @버전  :
 * @작성일 : 2012. 2. 15
 *   
 * @작업 완료
 *    일자 : 내역을 적으세요
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.controller.atom.general.webcli;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.atom.general.webcli.WebCliDomain;
import com.ntels.avocado.domain.atom.management.trace.Condition;
import com.ntels.avocado.domain.atom.management.trace.TraceReq;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.general.webcli.WebCliService;
import com.ntels.avocado.service.atom.management.trace.TraceReqService;
import com.ntels.avocado.service.common.CommonCodeService;

// TODO: Auto-generated Javadoc
/**
 * The Class CommandLineController.
 */
@Controller
@RequestMapping(value = "/atom/general/commandline")
public class WebCliController {

	/** The logger. */
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	/** Commandlineinterface. */
	@Autowired
	private WebCliService commandLineService;	
	
	/** The trace req service. */
	@Autowired
	private TraceReqService traceReqService;
	
	/**
	 * Commandlineinterface.
	 *
	 * @param model the model
	 * @return the string
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "cli")
	public String commandlineinterface(Model model, HttpServletRequest request) throws Exception {
		
//		SessionUser session = (SessionUser) request.getSession().getAttribute(Consts.USER.SESSION_USER);
//		
//		if (session != null) {
//			// FIXME mirinae.maru 2016.04.01 일단 user_group_level을 userLevelId로 바꿨는데 추후 확인해야됨 
//			//String user_group_level = session.getUser_group_level();
//			String user_group_level = session.getUserLevelId();
//			
//			model.addAttribute("listCommands", listCommands(user_group_level)); //페이지 접속하면 command 리스트 받아오기
//			logger.debug("listCommands()==>"+listCommands(user_group_level));
//		}		
//		
//		//menuAuth 권한 가져오기
//		String[] array = request.getRequestURI().split("/");
//		String url = array[array.length-3] + "/" + array[array.length-2] + "/" + array[array.length-1];
//		model.addAttribute("menuAuth", commandLineService.getAuth(url, request));
//		//menuAuth 가져오기
				
		//model.addAttribute("isOn", false); //
		
		model.addAttribute("System" ,commonCodeService.listSystemId());		// TAT_NODE 조회
		model.addAttribute("Package",commonCodeService.listPackageId());	// TAT_PKG 조회
		
		return "atom/general/webcli/cli";
	}
	

	@RequestMapping(value = "tableSel")
	public @ResponseBody Object tableSel() {
		Object result = null;
		result = commandLineService.tableSel();
		return result;
	}
	
	@RequestMapping(value = "listCMD")
	public @ResponseBody Object listCMD(
			@RequestParam String node_name) {
		Object result = null;
		
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		
		result = commandLineService.listCMD( node_name );
		return result;
	}
	
	@RequestMapping(value = "listCMDArg")
	public @ResponseBody Object listCMDArg(
			@RequestParam String cmd_code) {
		Object result = null;

		logger.debug( "[mirinae.maru] cmd_code : " + cmd_code );
		logger.debug( "[mirinae.maru] cmd_code : " + cmd_code );
		logger.debug( "[mirinae.maru] cmd_code : " + cmd_code );
		logger.debug( "[mirinae.maru] cmd_code : " + cmd_code );
		logger.debug( "[mirinae.maru] cmd_code : " + cmd_code );
		
		result = commandLineService.listCMDArg( cmd_code );
		return result;
	}
	
	@RequestMapping(value = "listService")
	public @ResponseBody Object listService(
			@RequestParam String pkg_name) {
		return commandLineService.listService( pkg_name );
	}
	
	@RequestMapping(value = "getPkgName")
	public @ResponseBody String getPkgName(
			@RequestParam String node_name) {
		String result = null;
		
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		
		result = commandLineService.getPkgName( node_name );

		logger.debug( "[mirinae.maru] getPkgName result : " + result );
		logger.debug( "[mirinae.maru] getPkgName result : " + result );
		logger.debug( "[mirinae.maru] getPkgName result : " + result );
		logger.debug( "[mirinae.maru] getPkgName result : " + result );
		logger.debug( "[mirinae.maru] getPkgName result : " + result );
		
		return result;
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
	
	@RequestMapping(value = "getCmdEmsDestination")
	public @ResponseBody String getCmdEmsDestination(
			WebCliDomain wcd) {
		String result = null;
		
		logger.debug( "[mirinae.maru] cmd_code : " + wcd.getCmd_code() );
		logger.debug( "[mirinae.maru] cmd_code : " + wcd.getCmd_code() );
		logger.debug( "[mirinae.maru] cmd_code : " + wcd.getCmd_code() );
		logger.debug( "[mirinae.maru] cmd_code : " + wcd.getCmd_code() );
		logger.debug( "[mirinae.maru] cmd_code : " + wcd.getCmd_code() );
		
		logger.debug( "[mirinae.maru] pkg_name : " + wcd.getPkg_name() );
		
		result = commandLineService.getCmdEmsDestination( wcd.getCmd_code(), wcd.getPkg_name() );

		logger.debug( "[mirinae.maru] getCmdEmsDestination result : " + result );
		logger.debug( "[mirinae.maru] getCmdEmsDestination result : " + result );
		logger.debug( "[mirinae.maru] getCmdEmsDestination result : " + result );
		logger.debug( "[mirinae.maru] getCmdEmsDestination result : " + result );
		logger.debug( "[mirinae.maru] getCmdEmsDestination result : " + result );
		
		return result;
	}
	
	@RequestMapping(value = "listProcess")
	public @ResponseBody Object listProcess(
			@RequestParam String node_name,
			@RequestParam String svc_no) {
		Object result = null;

		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] node_name : " + node_name );
		logger.debug( "[mirinae.maru] svc_no : " + svc_no );
		logger.debug( "[mirinae.maru] svc_no : " + svc_no );
		logger.debug( "[mirinae.maru] svc_no : " + svc_no );
		logger.debug( "[mirinae.maru] svc_no : " + svc_no );
		logger.debug( "[mirinae.maru] svc_no : " + svc_no );
		
		result = commandLineService.listProcess( node_name, svc_no );
		return result;
	}
	
	@RequestMapping(value = "xmlTable")
	public @ResponseBody Object xmlTable() {
		Object result = null;
		result = commandLineService.xmlTable();
		return result;
	}
	
	@RequestMapping(value = "xmlComponent")
	public @ResponseBody Object xmlComponent(String tableSel) {
		Object result = null;
		result = commandLineService.xmlComponent(tableSel);
		return result;
	}
	
	@RequestMapping(value = "getServiceName")
	public @ResponseBody Object getServiceName() throws Exception {
		List<Map<String, String>> serviceName = commandLineService.getServiceName();
		
		logger.debug("=============>"+serviceName);
		
		return serviceName;
	}	
	
	@RequestMapping(value = "getProcessName")
	public @ResponseBody Object getProcessName() throws Exception {
		List<Map<String, String>> processName = commandLineService.getProcessName();
		
		logger.debug("=============>"+processName);
		
		return processName;
	}	
	
	
	@RequestMapping(value = "getComponentName")
	public @ResponseBody Object getComponentName() throws Exception {

//		logger.debug("process_id===>"+process_id);
		List<Map<String, String>> componentName = commandLineService.getComponentName();
		
		logger.debug("=============>"+componentName);
		
		return componentName;
	}		
	
	@RequestMapping(value = "getQueueName")
	public @ResponseBody Object getQueueName() throws Exception {

//		logger.debug("process_id===>"+process_id);
		List<Map<String, String>> queueName = commandLineService.getQueueName();
		
		logger.debug("=============>"+queueName);
		
		return queueName;
	}
	
	/**
	 * Gets the keywords.
	 *
	 * @param keywords the keywords
	 * @param command_type the command_type
	 * @return the keywords
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "getKeywords", method = RequestMethod.POST)
	public @ResponseBody Object getKeywords(
			@RequestParam String keywords
		  , @RequestParam String command_type
		  ) throws Exception {

//		logger.debug("keywords===>"+keywords);
//		logger.debug("command_type===>"+command_type);
		List<String> list = commandLineService.getKeywords(keywords, command_type);
		
		logger.debug("=============>"+list);
		
		return list;
	}
	
	/**
	 * Gets the commands.
	 *
	 * @return the commands
	 * @throws Exception the exception
	 */
	public List<Map<String, Object>> listCommands(String user_group_level) throws Exception {
		List<Map<String, Object>> list = commandLineService.listCommands(user_group_level);		
		return list;
	}
	
	/**
	 * Gets the input Format.
	 *
	 * @return the input format
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "listInputFormat", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> listInputFormat() throws Exception {
//	public List<Map<String, Object>> listInputFormat( Model model) throws Exception {
		List<Map<String, Object>> list = commandLineService.listInputFormat();	
		
		
/*		String aaa = "001:002:004:006:008";
		StringTokenizer strToken = new StringTokenizer(aaa,":");
		List<String> inputFormat = new ArrayList<String>();
		while(strToken.hasMoreElements()){
			System.out.println("strToken.nextToken() = "+strToken.nextToken());
			inputFormat.add(strToken.nextToken());
		}
		
		model.addAttribute("inputFormat", inputFormat);*/
		
		return list;
	}	
	
	/**
	 * Execute.
	 *
	 * @param command the command
	 * @param argument the argument
	 * @param system_id the system_id
	 * @param package_id the package_id
	 * @param service_id the service_id
	 * @param component_type the component_type
	 * @param process_id the process_id
	 * @param input_level the input_level
	 * @return the string
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "execute", method = RequestMethod.POST)
	public @ResponseBody Object execute(
			String command
          , String argument
          , String system_id
          , String package_id
          , String service_id
          , String component_type
          , String process_id
          , String input_level) {
//		System.err.println("argument==>"+argument);
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> map = commandLineService.getCommand(command);
		if(map != null) {
			String packet_type = (String) map.get("PACKET_TYPE");
			String command_type = (String) map.get("COMMAND_TYPE");
			String command_id = (String) map.get("COMMAND_ID");
			String argument_flag = (String) map.get("ARGUMENT_FLAG");
			String db_input_level = (String) map.get("INPUT_LEVEL");
			String packet_format = (String) map.get("PACKET_FORMAT");
			String description = (String) map.get("DESCRIPTION");
			String input_format = (String) map.get("INPUT_FORMAT");
			String pfm_component_id = (String) map.get("PFM_COMPONENT_ID");
//			String command_level = (String) map.get("COMMAND_LEVEL");
			if(("".equals(argument)) && ("Y".equals(argument_flag))) { //parameter argument 널 되면 안됨
				params.put("isOn", false); //
				params.put("Error", 1); // 
			} else if(Integer.parseInt(input_level) < Integer.parseInt(db_input_level)) { //넘어온 파라메터랑 디비 레벨이 맞지 않음(작으면)
				params.put("isOn", false); //
				params.put("Error", 2); // 		
			} else {
				if(("RECONFIG".equals(command)) && (StringUtils.isNotEmpty(argument))) {
					if(!"ALL".equals(argument.trim())) {
						int count = commandLineService.systemCount(argument.trim());
						//System.err.println("count==>"+count);
						if(count == 0) { //실패
							params.put("isOn", false); //
							params.put("Error", 4); //
							params.put("description", description); //
						} else {
							params.put("isOn", true); //
							params.put("packet_format", packet_format); //
							params.put("packet_type", packet_type); //
							params.put("command_type", command_type); //
							params.put("command_id", command_id); //
							params.put("description", description); //
							params.put("getSystemID", commandLineService.searchSystemID(argument.trim()));
							params.put("input_format", input_format); //
							params.put("pfm_component_id", pfm_component_id); //
						}
					} else {
						params.put("isOn", true); //
						params.put("packet_format", packet_format); //
						params.put("packet_type", packet_type); //
						params.put("command_type", command_type); //
						params.put("command_id", command_id); //
						params.put("description", description); //			
						params.put("input_format", input_format); //			
						params.put("pfm_component_id", pfm_component_id); //
					}
					
				} else {
					params.put("isOn", true); //
					params.put("packet_format", packet_format); //
					params.put("packet_type", packet_type); //
					params.put("command_type", command_type); //
					params.put("command_id", command_id); //
					params.put("description", description); //
					params.put("input_format", input_format); //
					params.put("pfm_component_id", pfm_component_id); //
				}
				
			}
		} else { //map null 발생 예외 처리
			params.put("isOn", false); //
			params.put("Error", "3"); //실패
		}
		
		return params;
	}
	
	/**
	 * List.
	 *
	 * @param model the model
	 * @return the object
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "listHistory", method = RequestMethod.POST)
	public String listHistory(
			@RequestParam String user_id
//		  , @RequestParam String package_id
//		  , @RequestParam String service_id
//		  , @RequestParam String process_id
	      , Model model
		  ) throws Exception {

//		System.err.println("system_id===>"+system_id);
//		System.err.println("package_id===>"+package_id);
//		System.err.println("service_id===>"+service_id);
//		System.err.println("process_id===>"+process_id);
		List<Map<String, Object>> listHistory = commandLineService.listHistory(user_id);
//		System.err.println("listHistory==>"+listHistory.toString());
		model.addAttribute("listHistory", listHistory);
		return "ofcs/commandline/listHistory";
	}
	
	/**
	 * List trace.
	 *
	 * @param system_id the system_id
	 * @param package_id the package_id
	 * @return the string
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "listTrace", method = RequestMethod.POST)
	public @ResponseBody Object listTrace(
			@RequestParam String system_id
		  , @RequestParam String package_id
		  ) throws Exception {

//		System.err.println("system_id===>"+system_id);
//		System.err.println("package_id===>"+package_id);
		List<Map<String, Object>> listTrace = null;
		if(StringUtils.isNotEmpty(system_id)) 
			listTrace = commandLineService.listTrace(system_id, package_id);
		return listTrace;
	}	
	
	/**
	 * Delele trace.
	 * 
	 * 설명 :
	 *
	 * @param trace_req_id the trace_req_id
	 * @return the object
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "deleteTrace", method = RequestMethod.POST)
	public @ResponseBody Object deleteTrace(
			String trace_req_id
		  //, Model model
		  ) throws Exception {
		
		boolean isNumber = Pattern.compile("[\\d]+").matcher(trace_req_id).matches(); //숫자 여부
		
		if(isNumber) {
			Condition condition = new Condition();
			condition.setTrace_req_id(trace_req_id);
			
			TraceReq traceReq = traceReqService.getTraceReq(condition);
			if(traceReq == null) {
				return "02";
				
			} else {
				traceReq.setEnd_datetime(""); // UP_TRACE_REQ 프로시저 오류로 의해 빈 값 넣어서 처리함.(의미없는 데이터임)
				
				if(traceReqService.delete(traceReq)){
	//				model.addAttribute("returnMsg", "true");
	//				model.addAttribute("resultMsg", "trace_stop");
					return "01"; //성공
				} else { 
	//				model.addAttribute("returnMsg", "false");
	//				model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
					return "02"; //실패
				}
			}
		} else {
			return "03"; //숫자가 아님
		}
	}
	
	/**
	 * Start trace.
	 *
	 * @param system_id the system_id
	 * @param package_id the package_id
	 * @param service_id the service_id
	 * @param argument the argument
	 * @param user_id the user_id
	 * @return the object
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "startTrace", method = RequestMethod.POST)
	public @ResponseBody Object startTrace(
			String system_id
          , String package_id
          , String service_id
//        , String component_type
//        , String process_id
//        , String input_level
//        , String command
          , String argument
          , String user_id
		  ) throws Exception {
		String trace_type ="";
		String condition_value = "";
		if(argument.indexOf(":") == -1) { //에러 - 잘못 입력된 값 
			return "03";
		} else {
			String[] temp_array = argument.split(":");
			trace_type = temp_array[0];
			if(("IP".equals(trace_type.toUpperCase())) || ("MIN".equals(trace_type.toUpperCase()))) {
				if("IP".equals(trace_type.toUpperCase())){
					trace_type = "I";
				} else { 
					trace_type = "M";
				}
			} else {
				return "03";
			}
			condition_value = temp_array[1];
		}
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DATE);
		int hour = cal.get(Calendar.HOUR_OF_DAY)+1;
		int minute = cal.get(Calendar.MINUTE);
		int second = cal.get(Calendar.SECOND);
		
		/*System.err.println("year==>"+year);
		System.err.println("month==>"+month);
		System.err.println("day==>"+day);
		System.err.println("hour==>"+hour);
		System.err.println("minute==>"+minute);
		System.err.println("second==>"+second);*/
		
		StringBuffer sb = new StringBuffer();
		sb.append(year);
		if(month < 10) sb.append("0");
		sb.append(month);
		if(day < 10) sb.append("0");
		sb.append(day);
		if(hour < 10) sb.append("0");
		sb.append(hour);
		if(minute < 10)sb.append("0");
		sb.append(minute);
		if(second < 10) sb.append("0");
		sb.append(second);
		
		//cal.add(Calendar.HOUR_OF_DAY, 1);
		//SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		
		TraceReq traceReq = new TraceReq();
		traceReq.setSystem_id(system_id);
		traceReq.setPackage_id(package_id);
		traceReq.setService_id(service_id);
		traceReq.setFilter_grp_nm("WG_CR_META");
		traceReq.setEnd_datetime(sb.toString());
		traceReq.setTrace_type(trace_type);
		traceReq.setCondition_value(condition_value);
		traceReq.setUser_id(user_id);
		traceReq.setDescription("");
//		System.err.println(traceReq.toString());
		
		if(traceReqService.insert(traceReq)){ //성공
			return "01";
		} else { //실패			
			return "02";
		}
	}
	
	/**
	 * Gets the trace process list.
	 *
	 * @return the trace process list
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "getTraceProcessList", method = RequestMethod.POST)
	public @ResponseBody Object getTraceProcessList() throws Exception {
		return traceReqService.listTraceProcess();
	}
	
	/**
	 * Stop trace action.
	 * 
	 * 설명 :
	 *
	 * @param trace_req_id the trace_req_id
	 * @return the object
	 * 
	 * 설명 :
	 */
	@RequestMapping(value = "stopTrace", method = RequestMethod.POST)
	public @ResponseBody Object stopTrace(
			String trace_req_id
//		  , Model model
		  ) {
		
		boolean isNumber = Pattern.compile("[\\d]+").matcher(trace_req_id).matches(); //숫자 여부
		
		if(isNumber) {
			Condition condition = new Condition();
			condition.setTrace_req_id(trace_req_id);
			
			TraceReq traceReq = traceReqService.getTraceReq(condition);
			if(traceReq == null) {
				return "02"; //실패
			} else {
				traceReq.setEnd_datetime(""); // UP_TRACE_REQ 프로시저 오류로 의해 빈 값 넣어서 처리함.(의미없는 데이터임)
		
				if(traceReqService.updateEnd_datetime(traceReq)){
					return "01"; //성공
				}else{ 
					return "02"; //실패
				}
			}
		} else {
			return "03"; //숫자가 아님
		}
	}
	
	/**
	 * Dist xml.
	 *
	 * @param system_id the system_id
	 * @param package_id the package_id
	 * @return the object
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "distXml", method = RequestMethod.POST)
	public @ResponseBody Object distXml(
			String system_id
		  , String package_id
		  ) throws Exception {
		int result = commandLineService.distXml(system_id, package_id);
		if(result == 0) //성공
			return "01";
		else 
			return "02";
	}
			
	/**
	 * Insert.
	 *
	 * @param system_id the system_id
	 * @param package_id the package_id
	 * @param service_id the service_id
	 * @param process_id the process_id
	 * @param request_id the request_id
	 * @param command the command
	 * @param argument the argument
	 * @param user_id the user_id
	 * @return the object
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public @ResponseBody Object insert(
			String system_id
	      , String package_id
	      , String service_id
	      , String command
	      , String argument
	      , String user_id
	      , HttpServletRequest request
		  ) throws Exception {
						
		WebCliDomain commandLine = new WebCliDomain();
		commandLine.setPackage_id(package_id);
		commandLine.setSystem_id(system_id);
		commandLine.setUser_id(user_id);
		commandLine.setCommand(command);
		commandLine.setArgument(argument);
		commandLine.setGateway_ip(request.getRemoteAddr());
		
		if(commandLineService.insert(commandLine) > 0) { //성공
			return commandLine.getSeq();			
		} else { //실패
			return 0;
		}
		
	}
				
	/**
	 * Update.
	 *
	 * @param seq_no the seq_no
	 * @param res_result the res_result
	 * @param res_message the res_message
	 * @return the object
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public @ResponseBody Object update(
			String sequence
		  , String result
		  , String message) {
		
		if (logger.isDebugEnabled()) logger.debug("sequence : " + sequence);
		if (logger.isDebugEnabled()) logger.debug("result : " + result);
		if (logger.isDebugEnabled()) logger.debug("message : " + message);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sequence", sequence);
		map.put("result", result);
		map.put("message", message);
		
		if (StringUtils.isNotEmpty(sequence)) {
			return commandLineService.update(map);
		} else {
			return 0;
		}
	}	
	
	/**
	 * Search system id.
	 *
	 * @param argument the argument
	 * @return the object
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "getSystemID", method = RequestMethod.POST)
	public String getSystemID(
			String argument
			, Model model
		  ) throws Exception {
		
		model.addAttribute("getSystemID", commandLineService.searchSystemID(argument.trim()));	
		return "ofcs/commandline/getSystemID" ;
	}
	
	/**
	 * Dist sys group.
	 *
	 * @param system_id the system_id
	 * @return the object
	 * 
	 * 설명 :
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "distSysGroup", method = RequestMethod.POST)
	public @ResponseBody Object distSysGroup(
			String system_id
		  ) throws Exception {
		
		return commandLineService.distSysGroup(system_id);
	}
	
	/**
	 * 
	 * @param text
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "download", method = RequestMethod.POST)
	public String download(
			@RequestParam(required=false) String txt
		  , HttpServletResponse response) throws Exception {
		
		StringBuilder fileName = new StringBuilder();
		fileName.append("CLI");
		fileName.append("_");
		fileName.append((new SimpleDateFormat("ddMMyyyy_HHmmss")).format(Calendar.getInstance( ).getTime())); //시간형식
		fileName.append(".");
		fileName.append("txt");
		
		fileName.insert(0, "attachment; filename=\""); //attach 용으로 변경
		fileName.append("\""); //마무리
		
		response.setHeader("Content-Disposition",fileName.toString());

		if ((txt != null) && (!"".equals(txt))) {
			txt = URLDecoder.decode(txt, "UTF-8");
			//txt = txt.replaceAll("\\$", "=");
			//System.out.println(txt);
			FileCopyUtils.copy(txt.getBytes(), response.getOutputStream());
		} else {
			FileCopyUtils.copy("".getBytes(), response.getOutputStream());
		}
		
		return null;
	}
}
