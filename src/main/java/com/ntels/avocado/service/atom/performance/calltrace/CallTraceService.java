package com.ntels.avocado.service.atom.performance.calltrace;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.dao.atom.performance.calltrace.CallTraceMapper;
import com.ntels.avocado.domain.atom.performance.calltrace.TrcHist;
import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.MessageUtil;
import com.ntels.ncf.utils.StringUtils;

@Service
public class CallTraceService {
	
	@Autowired
	private CallTraceMapper callTraceMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private HttpSession session;
	
	private String language = DateUtil.getDateRepresentation();
	
	@Transactional
	public String insertHist(TrcHist trcHist) {
		try {
			OperationHistDomain op = commonService.getNewOperationHist("2");
			if (op == null) {
				throw new Exception(MessageUtil.getMessage("msg.performance.calltrace.insert.operation.hist.fail"));
			}
			trcHist.setOper_no(""+op.getOper_id());
			
			if (callTraceMapper.insertTraceHist(trcHist) <= 0) {
				throw new Exception(MessageUtil.getMessage("msg.performance.calltrace.insert.trace.hist.fail"));
			}
			
			SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
			if (StringUtils.isNotEmpty(sessionUser.getLanguage())) {
				language = sessionUser.getLanguage();
			}
			trcHist.setStart_date_text(callTraceMapper.getDateText(trcHist.getStart_date(), language));
			
		} catch (Exception ex) {
			ex.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ex.getMessage();
		}
		return "succ";
	}
	
	@Transactional
	public String updateHist(TrcHist trcHist) {
		try {
			if (callTraceMapper.updateTraceHist(trcHist) <= 0) {
				throw new Exception(MessageUtil.getMessage("msg.performance.calltrace.update.trace.hist.fail"));
			}
			
			SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
			if (StringUtils.isNotEmpty(sessionUser.getLanguage())) {
				language = sessionUser.getLanguage();
			}
			trcHist.setEnd_date_text(callTraceMapper.getDateText(trcHist.getEnd_date(), language));
			
		} catch (Exception ex) {
			ex.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ex.getMessage();
		}
		return "succ";
	}
	
	public TrcHist getTraceHist() {
		TrcHist trcHist = new TrcHist();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		trcHist.setUser_id(sessionUser.getUserId());
		return callTraceMapper.getTraceHist(trcHist);
	}

}
