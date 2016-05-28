package com.ntels.avocado.controller.atom.config.trace;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ntels.avocado.domain.atom.management.trace.Condition;
import com.ntels.avocado.service.atom.config.trace.TraceService;


// TODO: Auto-generated Javadoc
/**
 * The Class TraceController.
 */
@Controller
@RequestMapping(value = "/atom/config/trace")
public class TraceController {
	
	/** The trace service. */
	@Autowired
	private TraceService traceService;
	
	/** The this url. */
	private String thisUrl = "atom/config/trace";
	
	/** The logger. */
	private Logger logger = Logger.getLogger(this.getClass());
	
	// go list page
	/**
	 * Trace view.
	 *
	 * @param condition the condition
	 * @param model the model
	 * @return the string
	 */
	@RequestMapping(value = "traceView", method = RequestMethod.POST)
	public String traceView(
			Condition condition,
			Model model) {
		
		model.addAttribute("system", traceService.listSystem());
		model.addAttribute("service", traceService.listTopService());
		
		return thisUrl + "/traceView";
	}
	
	/**
	 * List system.
	 *
	 * @return the object
	 */
	@RequestMapping(value = "listSystem", method = RequestMethod.POST)
	public @ResponseBody Object listSystem(){
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list.add(traceService.listSystem());
		return list;
	}
	
	/**
	 * 서비스 조회
	 * @return
	 */
	@RequestMapping(value = "listService", method = RequestMethod.POST)
	public @ResponseBody Object listService(){
		return traceService.listService();
	}
	/**
	 * List send type.
	 *
	 * @return the object
	 */
	@RequestMapping(value = "listSendType", method = RequestMethod.POST)
	public @ResponseBody Object listSendType() {
		return traceService.listSendType();
	}
	
	/**
	 * List protocol.
	 *
	 * @return the object
	 */
	@RequestMapping(value = "listProtocol", method = RequestMethod.POST)
	public @ResponseBody Object listProtocol() {
		return traceService.listProtocol();
	}
	
	/**
	 * List process.
	 *
	 * @return the object
	 */
	@RequestMapping(value = "listProcess", method = RequestMethod.POST)
	public @ResponseBody Object listProcess(String service) {
		logger.debug("▶▷▶▷service : " + service);
		return traceService.listProcess(service);
	}
	
	/**
	 * List node.
	 *
	 * @return the object
	 */
	@RequestMapping(value = "listDiameterNode", method = RequestMethod.POST)
	public @ResponseBody Object listDiameterNode() {
		return traceService.listDiameterNode();
	}
	
	/**
	 * List node.
	 *
	 * @return the object
	 */
	@RequestMapping(value = "listGtpNode", method = RequestMethod.POST)
	public @ResponseBody Object listGtpNode() {
		return traceService.listGtpNode();
	}
	
	/**
	 * List all node.
	 *
	 * @return the object
	 */
	/*@RequestMapping(value = "listAllNode", method = RequestMethod.POST)
	public @ResponseBody Object listAllNode() {
		return traceService.listAllNode();
	}*/
	
	/**
	 * List calling type.
	 *
	 * @return the object
	 */
	@RequestMapping(value = "listDiameterType", method = RequestMethod.POST)
	public @ResponseBody Object listDiameterType() {
		return traceService.listDiameterType();
	}
	
	/**
	 * List imsi type.
	 *
	 * @return the object
	 */
	@RequestMapping(value = "listGtpType", method = RequestMethod.POST)
	public @ResponseBody Object listGtpType() {
		return traceService.listGtpType();
	}
	
	/**
	 * List all type.
	 *
	 * @return the object
	 */
	/*@RequestMapping(value = "listAllType", method = RequestMethod.POST)
	public @ResponseBody Object listAllType() {
		return traceService.listAllType();
	}*/
	
	/**
	 * List process gtp type.
	 *
	 * @param system the system
	 * @param protocol the protocol
	 * @return the object
	 */
	@RequestMapping(value = "listProcessGtpNode", method = RequestMethod.POST)
	public @ResponseBody Object listProcessGtpNode(
			@RequestParam(required=false) String system
		  , @RequestParam(required=false) String service	
		  , @RequestParam(required=false) String protocol
			) {
		logger.debug("▶▷▶▷GTP");
		logger.debug("▶▷▶▷system : " + system);
		logger.debug("▶▷▶▷service : " + service);
		logger.debug("▶▷▶▷protocol : " + protocol);
//		System.err.println("system==>"+system);
//		System.err.println("protocol==>"+protocol);
		/*String service_id = null;
		String process_id = null;
		
		if (protocol = null) {
			String[] array = protocol.split("\\|");
			service_id = array[0];
			process_id = array[1];
		} else {
			Map<String, Object> map = traceService.listTopProcess();
			service_id = (String) map.get("SERVICE_ID");
			process_id = (String) map.get("PROCESS_ID");
		}*/
//		System.err.println("system==>"+system);
//		System.err.println("service_id==>"+service_id);
//		System.err.println("process_id==>"+process_id);
		
		if (protocol == null) {
			Map<String, Object> map = traceService.listTopProcess(service);
			if (map != null) protocol = (String) map.get("PROCESS_ID");
		}
		
		return traceService.listProcessGtpNode(system, service, protocol);
	}
	
	/**
	 * List process gtp type.
	 *
	 * @param protocol the protocol
	 * @return the object
	 */
	@RequestMapping(value = "listProcessDiaNode", method = RequestMethod.POST)
	public @ResponseBody Object listProcessDiaNode(
			@RequestParam(required=false) String system
		  , @RequestParam(required=false) String service
		  , @RequestParam(required=false) String protocol
			  ) {
		logger.debug("▶▷▶▷Diameter");
		logger.debug("▶▷▶▷system : " + system);
		logger.debug("▶▷▶▷service : " + service);
		logger.debug("▶▷▶▷protocol : " + protocol);
		
//		System.err.println("protocol==>"+protocol);
		/*String service_id = null;
		String process_id = null;
		if (protocol != null) {
			String[] array = protocol.split("\\|");
			service_id = array[0];
			process_id = array[1];
		}*/
//		System.err.println("service_id==>"+service_id);
//		System.err.println("process_id==>"+process_id);
		return traceService.listProcessDiaNode(system, service, protocol);
	}
	
	@RequestMapping(value = "download", method = RequestMethod.POST)
	public String download(
			@RequestParam(required=false) String txt
		  , HttpServletResponse response) throws Exception {
		//System.err.println(txt);
		StringBuilder fileName = new StringBuilder();
		fileName.append("Trace");
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
