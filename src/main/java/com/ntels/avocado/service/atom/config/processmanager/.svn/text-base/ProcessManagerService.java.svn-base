package com.ntels.avocado.service.atom.config.processmanager;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ntels.avocado.dao.atom.config.processmanager.ProcessManagerMapper;
import com.ntels.avocado.domain.atom.config.networkmanager.Line;
import com.ntels.avocado.domain.atom.config.networkmanager.Node;
import com.ntels.avocado.domain.atom.config.networkmanager.Pkg;
import com.ntels.avocado.domain.atom.config.processmanager.NodeType;
import com.ntels.avocado.domain.atom.config.processmanager.Proc;
import com.ntels.avocado.domain.atom.config.processmanager.Svc;
import com.ntels.ncf.utils.MessageUtil;
import com.ntels.ncf.utils.StringUtils;

@Service
public class ProcessManagerService {

	@Autowired
	private ProcessManagerMapper processManagerMapper;
	
	public List<Pkg> listPkg() {
		List<Pkg> ret;
		try {
			ret = processManagerMapper.listPkg();
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Pkg>();
		}
		return ret;
	}
	
	public List<Svc> listSvc() {
		List<Svc> ret;
		try {
			ret = processManagerMapper.listSvc();
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Svc>();
		}
		return ret;
	}
	
	public List<Svc> listNodeSvc(Node node) {
		List<Svc> ret;
		try {
			ret = processManagerMapper.listNodeSvc(node);
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Svc>();
		}
		return ret;
	}
	
	public List<Line> listLine(Svc svc) {
		List<Line> ret;
		try {
			ret = processManagerMapper.listLine(svc);
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Line>();
		}
		return ret;
	}
	
	public List<NodeType> listNodeType() {
		List<NodeType> ret;
		try {
			ret = processManagerMapper.listNodeType();
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<NodeType>();
		}
		return ret;
	}
	
	public List<Proc> listProcBase() {
		List<Proc> ret;
		try {
			ret = processManagerMapper.listProcBase();
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Proc>();
		}
		return ret;
	}
	
	public List<Proc> listProc(Svc svc) {
		List<Proc> ret;
		try {
			ret = processManagerMapper.listProc(svc);
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Proc>();
		}
		return ret;
	}
	
	public List<Proc> listMonitoringProc(Svc svc) {
		List<Proc> ret;
		try {
			ret = processManagerMapper.listMonitoringProc(svc);
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Proc>();
		}
		return ret;
	}
	
	@Transactional
	public String insertSvc(Svc svc) {
		try {
			if (processManagerMapper.getSvc(svc) != null) {
				String sMessage = "";
				sMessage += MessageUtil.getMessage("msg.configuration.processmanager.serviceid.duplicate.front");
				sMessage += svc.getSvc_no();
				sMessage += MessageUtil.getMessage("msg.configuration.processmanager.serviceid.duplicate.back");
				throw new Exception(sMessage);
			} else {
				if (processManagerMapper.insertSvc(svc) <= 0) {
					String sMessage = "";
					sMessage += MessageUtil.getMessage("msg.configuration.processmanager.service.insert.fail.front");
					sMessage += svc.getSvc_name();
					sMessage += MessageUtil.getMessage("msg.configuration.processmanager.service.insert.fail.back");
					throw new Exception(sMessage);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ex.getMessage();
		}
		return "succ";
	}
	
	public String updateSvc(Svc svc) {
		if (processManagerMapper.updateSvc(svc) <= 0) {
			String sMessage = "";
			sMessage += MessageUtil.getMessage("msg.configuration.processmanager.service.update.fail.front");
			sMessage += svc.getSvc_name();
			sMessage += MessageUtil.getMessage("msg.configuration.processmanager.service.update.fail.back");
			return sMessage;
		}
		return "succ";
	}
	
	@Transactional
	public String deleteSvc(Svc svc) {
		try {
			processManagerMapper.deleteLine(svc);
			processManagerMapper.deleteSvcProc(svc);
			processManagerMapper.deleteSvc(svc);
		} catch (Exception ex) {
			ex.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ex.getMessage();
		}
		return "succ";
	}
	
	@Transactional
	public String saveFlowDesign(String jsonStr) {
		Gson gson = new Gson();
		JsonParser parser = new JsonParser();
		try {
			JsonObject json = (JsonObject)parser.parse(jsonStr);
			
			Svc svc = gson.fromJson(json, Svc.class);
			
			processManagerMapper.deleteLine(svc);
			processManagerMapper.deleteQueue(svc);
			processManagerMapper.resetProcPosition(svc);
			// processManagerMapper.deleteImages(svc);
			// processManagerMapper.deleteSvcProc(svc);
			
			JsonArray procList = (JsonArray)json.get("procList");
			for (int i=0;i<procList.size();i++) {
				JsonObject jsonProc = (JsonObject)procList.get(i);
				Proc proc = gson.fromJson(jsonProc, Proc.class);
				proc.setPkg_name(svc.getPkg_name());
				proc.setNode_type(svc.getNode_type());
				proc.setSvc_no(svc.getSvc_no());
				if (processManagerMapper.getProc(proc) != null) {
					String sMessage = "";
					sMessage += MessageUtil.getMessage("msg.configuration.processmanager.procname.exist.front");
					sMessage += proc.getProc_name();
					sMessage += MessageUtil.getMessage("msg.configuration.processmanager.procname.exist.back");
					throw new Exception(sMessage);
				}
				if (StringUtils.isNotEmpty(proc.getProc_no())) {
					if (processManagerMapper.updateImage(proc) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.update.fail.front");
						sMessage += proc.getProc_name();
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.update.fail.back");
						throw new Exception(sMessage);
					}
					if (processManagerMapper.updateProc(proc) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.processmanager.process.update.fail.front");
						sMessage += proc.getProc_name();
						sMessage += MessageUtil.getMessage("msg.configuration.processmanager.process.update.fail.back");
						throw new Exception(sMessage);
					}
				} else {
					if (processManagerMapper.getProc(proc) != null) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.processmanager.procname.exist.front");
						sMessage += proc.getProc_name();
						sMessage += MessageUtil.getMessage("msg.configuration.processmanager.procname.exist.back");
						throw new Exception(sMessage);
					}
					if (processManagerMapper.insertImage(proc) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.insert.fail.front");
						sMessage += proc.getProc_name();
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.insert.fail.back");
						throw new Exception(sMessage);
					}
					if (processManagerMapper.insertProc(proc) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.processmanager.process.insert.fail.front");
						sMessage += proc.getProc_name();
						sMessage += MessageUtil.getMessage("msg.configuration.processmanager.process.insert.fail.back");
						throw new Exception(sMessage);
					}
				}
			}
			
			JsonArray lineList = (JsonArray)json.get("lineList");
			for (int i=0;i<lineList.size();i++) {
				JsonObject jsonLine = (JsonObject)lineList.get(i);
				Line line = gson.fromJson(jsonLine, Line.class);
				line.setPkg_name(svc.getPkg_name());
				line.setNode_type(svc.getNode_type());
				String source_id = getProcId(line.getSource_id());
				String target_id = getProcId(line.getTarget_id());
				line.setSource_id(source_id);
				line.setTarget_id(target_id);
				line.setRead_proc(line.getSource_name());
				line.setWrite_proc(line.getTarget_name());
				if (processManagerMapper.insertQueue(line) <= 0) {
					throw new Exception(MessageUtil.getMessage("msg.configuration.processmanager.queue.insert.fail"));
				}
				if (processManagerMapper.insertLine(line) <= 0) {
					throw new Exception(MessageUtil.getMessage("msg.configuration.networkmanager.line.insert.fail"));
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ex.getMessage();
		}
		return "succ";
	}
	
	public String getProcId(String sParam) {
		String proc_no = sParam;
		if (sParam.length() == 36) {
			proc_no = processManagerMapper.getProcIdByUUID(sParam);
		}
		return proc_no;
	}
}
