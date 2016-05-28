package com.ntels.avocado.service.atom.config.networkmanager;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ntels.avocado.common.Consts;
import com.ntels.avocado.dao.atom.config.networkmanager.NetworkManagerMapper;
import com.ntels.avocado.domain.atom.config.networkmanager.Line;
import com.ntels.avocado.domain.atom.config.networkmanager.Node;
import com.ntels.avocado.domain.atom.config.networkmanager.NodeGrp;
import com.ntels.avocado.domain.atom.config.networkmanager.Pkg;
import com.ntels.avocado.domain.atom.config.processmanager.NodeType;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.domain.common.definitions.CodeDefinitions;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.MessageUtil;
import com.ntels.ncf.utils.StringUtils;

@Service
public class NetworkManagerService {
	
	@Autowired
	private NetworkManagerMapper networkManagerMapper;
	
	@Autowired
	private HttpSession session;
	
	private String language = DateUtil.getDateRepresentation();
	
	public List<Pkg> listPkg() {
		List<Pkg> ret;
		try {
			ret = networkManagerMapper.listPkg();
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Pkg>();
		}
		return ret;
	}
	
	public List<Line> listLine() {
		List<Line> ret;
		try {
			ret = networkManagerMapper.listLine();
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Line>();
		}
		return ret;
	}
	
	public List<Line> listConnection() {
		List<Line> ret;
		try {
			ret = networkManagerMapper.listConnection();
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<Line>();
		}
		return ret;
	}
	
	public List<NodeGrp> listNodeGrp() {
		List<NodeGrp> ret;
		try {
			ret = networkManagerMapper.listNodeGrp();
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<NodeGrp>();
		}
		return ret;
	}
	
	public List<NodeType> listNodeType() {
		List<NodeType> ret;
		try {
			ret = networkManagerMapper.listNodeType();
		} catch (Exception ex) {
			ex.printStackTrace();
			ret = new ArrayList<NodeType>();
		}
		return ret;
	}
	
	@Transactional
	public String insertNodeGrp(NodeGrp nodeGrp) {
		try {
			if (networkManagerMapper.getNodeGrp(nodeGrp) != null) {
				String sMessage = "";
				sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.nodegroupid.duplicate.front");
				sMessage += nodeGrp.getNode_grp_id();
				sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.nodegroupid.duplicate.back");
				throw new Exception(sMessage);
			} else {
				if (networkManagerMapper.insertNodeGrp(nodeGrp) <= 0) {
					String sMessage = "";
					sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.nodegroup.insert.fail.front");
					sMessage += nodeGrp.getNode_grp_name();
					sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.nodegroup.insert.fail.back");
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
	
	public String updateNodeGrp(NodeGrp nodeGrp) {
		if (networkManagerMapper.updateNodeGrp(nodeGrp) <= 0) {
			String sMessage = "";
			sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.nodegroup.update.fail.front");
			sMessage += nodeGrp.getNode_grp_name();
			sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.nodegroup.update.fail.back");
			return sMessage;
		}
		return "succ";
	}
	
	public String deleteNodeGrp(NodeGrp nodeGrp) {
		if (networkManagerMapper.deleteNodeGrp(nodeGrp) <= 0) {
			String sMessage = "";
			sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.nodegroup.delete.fail.front");
			sMessage += nodeGrp.getNode_grp_name();
			sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.nodegroup.delete.fail.back");
			return sMessage;
		}
		return "succ";
	}
	
	public List<Node> listNode() {
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		if (StringUtils.isNotEmpty(sessionUser.getLanguage())) {
			language = sessionUser.getLanguage();
		}
		return networkManagerMapper.listNode(language);
	}
	
	public List<Node> listAllNode() {
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		if (StringUtils.isNotEmpty(sessionUser.getLanguage())) {
			language = sessionUser.getLanguage();
		}
		return networkManagerMapper.listMonitoringNode(language);
	}
	
	public List<Node> listMonitoringNode() {
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		if (StringUtils.isNotEmpty(sessionUser.getLanguage())) {
			language = sessionUser.getLanguage();
		}
		List<Node> listNodeGUI = networkManagerMapper.listMonitoringNodeGUI(language);
		List<Node> listNode = networkManagerMapper.listMonitoringNode(language);
		for (Node nodeGUI: listNodeGUI) {
			String internal_yn = nodeGUI.getInternal_yn();
			String scale_yn = nodeGUI.getScale_yn();
			if (StringUtils.isNotEmpty(internal_yn) && internal_yn.equals("Y") && StringUtils.isNotEmpty(scale_yn) && scale_yn.equals("Y")) {
				nodeGUI.setImage_bgcolor(this.getImageBgColor(nodeGUI, listNode));
			} else {
				nodeGUI.setImage_bgcolor(this.getImageBgColor(nodeGUI));
			}
		}
		return listNodeGUI;
	}
	
	public int getNodeStatusIndex(Node node) {
		String node_status_ccd = node.getNode_status_ccd();
		if (StringUtils.isNotEmpty(node_status_ccd)) {
			if (node_status_ccd.equals(CodeDefinitions.NODE_STATUS_SCALEIN) || node_status_ccd.equals(CodeDefinitions.NODE_STATUS_SCALEOUT)) {
				return 6;
			} else if (node_status_ccd.equals(CodeDefinitions.NODE_STATUS_UNKNOWN)) {
				return 5;
			} else if (node_status_ccd.equals(CodeDefinitions.NODE_STATUS_ACTIVE)) {
				String proc_status_ccd = node.getProc_status_ccd();
				if (StringUtils.isNotEmpty(proc_status_ccd)) {
					if (proc_status_ccd.equals(CodeDefinitions.NODE_STATUS_ABNORMAL)) {
						return 4;
					} else if (proc_status_ccd.equals(CodeDefinitions.NODE_STATUS_STOPPED)) {
						return 3;
					} else if (proc_status_ccd.equals(CodeDefinitions.NODE_STATUS_SUSPEND)) {
						return 2;
					} else if (proc_status_ccd.equals(CodeDefinitions.NODE_STATUS_UNKNOWN)) {
						return 1;
					} else if (proc_status_ccd.equals(CodeDefinitions.NODE_STATUS_RUNNING)) {
						return 0;
					}
				}
			}
		}
		return 5;
	}
	
	public String getImageBgColor(Node nodeGUI, List<Node> nodeList) {
		int nodeStatusIndex = 0;
		String pkg_name = nodeGUI.getPkg_name();
		String node_type = nodeGUI.getNode_type();
		for (Node node: nodeList) {
			if (node.getPkg_name().equals(pkg_name) && node.getNode_type().equals(node_type)) {
				int idx = this.getNodeStatusIndex(node);
				if (idx > nodeStatusIndex) {
					nodeStatusIndex = idx;
				}
			}
		}
		return this.getImageBgColor(nodeStatusIndex);
	}
	
	public String getImageBgColor(int nodeStatusIndex) {
		String image_bgcolor = "";
		switch (nodeStatusIndex) {
		case 6:
			// Scale
			image_bgcolor = "#b0c781";
			break;
		case 5:
			// Node Status Unknown
			image_bgcolor = "#adb0b6";
			break;
		case 4:
			// Abnormal
			image_bgcolor = "#f04343";
			break;
		case 3:
			// Stopped
			image_bgcolor = "#f2b230";
			break;
		case 2:
			// Suspended
			image_bgcolor = "#a275ff";
			break;
		case 1:
			// Process Status Unknown
			image_bgcolor = "#adb0b6";
			break;
		case 0:
			// Running
			image_bgcolor = "#00a8eb";
			break;
			
		}
		return image_bgcolor;
	}

	public String getImageBgColor(Node node) {
		int nodeStatusIndex = this.getNodeStatusIndex(node);
		return this.getImageBgColor(nodeStatusIndex);
	}
	
	@Transactional
	public String saveFlowDesign(String jsonStr) {
		Gson gson = new Gson();
		JsonParser parser = new JsonParser();
		try {
			JsonObject json = (JsonObject)parser.parse(jsonStr);
			
			// networkManagerMapper.deleteImages();
			networkManagerMapper.resetPkgPosition();
			networkManagerMapper.resetNodePosition();
			networkManagerMapper.deleteLine();
			
			JsonArray pkgList = (JsonArray)json.get("pkgList");
			for (int i=0;i<pkgList.size();i++) {
				JsonObject jsonPkg = (JsonObject)pkgList.get(i);
				Pkg pkg = gson.fromJson(jsonPkg, Pkg.class);
				if (pkg.getImage_no() == null || pkg.getImage_no().equals("") || pkg.getImage_no().equals("0")) {
					if (networkManagerMapper.insertImage(pkg) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.insert.fail.front");
						sMessage += pkg.getPkg_name();
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.insert.fail.back");
						throw new Exception(sMessage);
					}
				} else {
					if (networkManagerMapper.updateImage(pkg) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.update.fail.front");
						sMessage += pkg.getPkg_name();
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.update.fail.back");
						throw new Exception(sMessage);
					}
				}
				if (networkManagerMapper.updatePkgPosition(pkg) <= 0) {
					String sMessage = "";
					sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.package.update.fail.front");
					sMessage += pkg.getPkg_name();
					sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.package.update.fail.back");
					throw new Exception(sMessage);
				}
			}
			
			JsonArray nodeList = (JsonArray)json.get("nodeList");
			for (int i=0;i<nodeList.size();i++) {
				JsonObject jsonNode = (JsonObject)nodeList.get(i);
				Node node = gson.fromJson(jsonNode, Node.class);
				if (node.getImage_no() == null || node.getImage_no().equals("") || node.getImage_no().equals("0")) {
					if (networkManagerMapper.insertImage(node) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.insert.fail.front");
						sMessage += node.getNode_name();
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.insert.fail.back");
						throw new Exception(sMessage);
					}
				} else {
					if (networkManagerMapper.updateImage(node) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.update.fail.front");
						sMessage += node.getNode_name();
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.image.update.fail.back");
						throw new Exception(sMessage);
					}
				}
				if (!node.getInternal_yn().equals("Y")) {
					// internal node(internal_yn = 'Y') 의 경우 TAT_NODE_GUI 만 insert, update 한다.
					// external node(internal_yn != 'Y') 의 경우 TAT_NODE_GUI, TAT_NODE 모두 insert, update 한다.
					if (networkManagerMapper.getNode(node) == null) {
						if (networkManagerMapper.getNodeByName(node) == null) {
							if (networkManagerMapper.insertNode(node) <= 0) {
								String sMessage = "";
								sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.insert.fail.front");
								sMessage += node.getNode_name();
								sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.insert.fail.back");
								throw new Exception(sMessage);
							}
						} else {
							if (networkManagerMapper.updateNodeByName(node) <= 0) {
								String sMessage = "";
								sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.update.fail.front");
								sMessage += node.getNode_name();
								sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.update.fail.back");
								throw new Exception(sMessage);
							}
						}
					} else {
						if (networkManagerMapper.updateNode(node) <= 0) {
							String sMessage = "";
							sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.update.fail.front");
							sMessage += node.getNode_name();
							sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.update.fail.back");
							throw new Exception(sMessage);
						}
					}
				}
				if (networkManagerMapper.getNodeGUI(node) == null) {
					if (networkManagerMapper.getNodeGUIByName(node) == null) {
						if (networkManagerMapper.insertNodeGUI(node) <= 0) {
							String sMessage = "";
							sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.insert.fail.front");
							sMessage += node.getNode_name();
							sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.insert.fail.back");
							throw new Exception(sMessage);
						}
					} else {
						if (networkManagerMapper.updateNodeGUIByName(node) <= 0) {
							String sMessage = "";
							sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.update.fail.front");
							sMessage += node.getNode_name();
							sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.update.fail.back");
							throw new Exception(sMessage);
						}
					}
				} else {
					if (networkManagerMapper.updateNodeGUI(node) <= 0) {
						String sMessage = "";
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.update.fail.front");
						sMessage += node.getNode_name();
						sMessage += MessageUtil.getMessage("msg.configuration.networkmanager.node.update.fail.back");
						throw new Exception(sMessage);
					}
				}
			}
			
			JsonArray lineList = (JsonArray)json.get("lineList");
			for (int i=0;i<lineList.size();i++) {
				JsonObject jsonLine = (JsonObject)lineList.get(i);
				Line line = gson.fromJson(jsonLine, Line.class);
				if (networkManagerMapper.insertLine(line) <= 0) {
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
}
