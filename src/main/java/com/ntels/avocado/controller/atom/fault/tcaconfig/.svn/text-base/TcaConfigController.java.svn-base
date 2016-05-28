package com.ntels.avocado.controller.atom.fault.tcaconfig;

import java.net.URLDecoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.fault.alarmhistory.AlarmHistoryDomain;
import com.ntels.avocado.domain.atom.fault.tcaconfig.TcaConfigDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.fault.tcaconfig.TcaConfigService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.MessageUtil;

@Controller
@RequestMapping(value = "/atom/fault/tcaconfig")
public class TcaConfigController {
	private Logger logger = Logger.getLogger(this.getClass());
	
	private String thisUrl = "atom/fault/tcaconfig";
	
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private TcaConfigService tcaConfigService;
	
	@RequestMapping(value = "list")
	public String list(Model model, HttpServletRequest request , HttpSession session) {
		/*패키지 노드 셀렉트 박스*/ 
		model.addAttribute("System" ,commonCodeService.listSystemId());
		model.addAttribute("Package",commonCodeService.listPackageId());
		 //TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("2"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "listAction")	
	public String listAction(Model model
							,TcaConfigDomain condition
							, HttpSession session
							,HttpServletRequest request) throws ParseException  {
		//결과 요청
		Paging paging = tcaConfigService.listAction(condition);
		model.addAttribute("resultList", paging);
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value = "insert")	
	public String insert(Model model
							, HttpSession session
							,HttpServletRequest request) throws ParseException  {
		/*패키지 노드 셀렉트 박스*/ 
		model.addAttribute("System" ,commonCodeService.listSystemId());
		model.addAttribute("Package",commonCodeService.listPackageId());
		/*ActYn 셀렉트 박스*/
		model.addAttribute("actYn",commonCodeService.listAlphaYn());
		return thisUrl + "/insert";
	}
	
	
	@RequestMapping(value = "StatisticsTableCombo")
	public @ResponseBody Object StatisticsTableCombo(Model model 
						                  ,@RequestParam String node_no ){
		return tcaConfigService.StatisticsTable(node_no) ;
	}
	
	
	@RequestMapping(value = "StatisticsColumnCombo")
	public @ResponseBody Object StatisticsColumnCombo(Model model 
			                              ,@RequestParam String node_no
						                  ,@RequestParam String table_name ){
		return tcaConfigService.StatisticsColumn(node_no,table_name) ;
	}
	
	@RequestMapping(value = "valueRangeWrap")
	public String valueRangeWrap(@RequestParam int minValue
								,@RequestParam int maxValue
								,@RequestParam int unitValue
								,Model model
								, HttpServletRequest request
					            , HttpSession session                  
								) {
		model.addAttribute("minValue" , minValue);
		int middleValue = 0 ;
		middleValue = maxValue - ((maxValue - minValue )/2);
		model.addAttribute("middleValue" , middleValue);
		model.addAttribute("maxValue" , maxValue);
		model.addAttribute("unitValue", unitValue);
		return thisUrl + "/valueRangeWrap";
	}
	
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public void insertAction(@Valid TcaConfigDomain condition, BindingResult result
							, HttpServletRequest request
							, HttpSession session
							, Model model) {
		if(tcaConfigService.insert(condition)){
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
			model.addAttribute("returnMsg", "SUCCESS");
		}else { 
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
			model.addAttribute("returnMsg", "FAIL");
		}
		//TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("3"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
	}
	
	
	@RequestMapping(value = "detailView")	
	public String detailView(Model model
			                ,TcaConfigDomain condition
							,HttpSession session
							,HttpServletRequest request) throws ParseException  {
		model.addAttribute("TCA_INFO",tcaConfigService.getTcaInfo(condition));
		return thisUrl + "/detailView";
	}
	
	@RequestMapping(value = "update")	
	public String update(Model model
						,TcaConfigDomain condition
						,HttpSession session
						,HttpServletRequest request) throws ParseException  {
		/*ActYn 셀렉트 박스*/
		model.addAttribute("actYn",commonCodeService.listAlphaYn());
		model.addAttribute("TCA_INFO",tcaConfigService.getTcaInfo(condition));
		return thisUrl + "/update";
	}
	
	@RequestMapping(value = "valueRangeWrapMod")
	public String valueRangeWrapMod(Model model
								    ,@RequestParam String pkg_name
								    ,@RequestParam String table_name
								    ,@RequestParam String node_no
								    ,@RequestParam String column_name
								    , HttpServletRequest request
					                , HttpSession session ) {
        TcaConfigDomain condition = new TcaConfigDomain();
        condition.setPkg_name(pkg_name);
        condition.setTable_name(table_name);
        condition.setNode_no(node_no);
        condition.setColumn_name(column_name);
		model.addAttribute("TCA_INFO",tcaConfigService.getTcaInfo(condition));
		return thisUrl + "/valueRangeWrapMod";
	}
	
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public void updateAction(@Valid TcaConfigDomain condition, BindingResult result
							, HttpServletRequest request
							, HttpSession session
							, Model model) {
		if(tcaConfigService.update(condition)){
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
			model.addAttribute("returnMsg", "SUCCESS");
		}else { 
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
			model.addAttribute("returnMsg", "FAIL");
		}
		//TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("5"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
	}
	
	
	@RequestMapping(value = "deleteAction", method = RequestMethod.POST)
	public void deleteAction(@Valid TcaConfigDomain condition, BindingResult result
							, HttpServletRequest request
							, HttpSession session
							, Model model) {
		if(tcaConfigService.delete(condition)){
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
			model.addAttribute("returnMsg", "SUCCESS");
		}else { 
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
			model.addAttribute("returnMsg", "FAIL");
		}
		//TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("4"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
	}
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(Model model
								, HttpSession session
								, TcaConfigDomain condition ) throws ParseException  {
		List<LinkedHashMap<String, String>> list = tcaConfigService.listExcel(condition);
		model.addAttribute("list", list);
		List<String> title = new ArrayList<String>();
		if(list.size()>0){
			for(String mapKey : list.get(0).keySet()){
				title.add(mapKey);
			}
		}
		model.addAttribute("title", title);
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
		model.addAttribute("filename", condition.getTitleName());
		return "excelViewer";
	}
}
