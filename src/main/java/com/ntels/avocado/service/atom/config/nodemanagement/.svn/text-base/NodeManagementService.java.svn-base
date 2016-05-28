package com.ntels.avocado.service.atom.config.nodemanagement;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.config.nodemanagement.NodeManagementMapper;
import com.ntels.avocado.domain.atom.config.nodemanagement.NodeManagementDomain;

@Service
public class NodeManagementService {

	@Autowired
	private NodeManagementMapper nodeManagementMapper;
	
	public List<Map<String, String>> listNodeGrp(){
		return nodeManagementMapper.listNodeGrp();
	}
	
	public List<Map<String, String>> listNodeType(String pkg_name){
		return nodeManagementMapper.listNodeType(pkg_name);
	}
	
	public int duplChkNodeName(String nodeName, String nodeNo){
		return nodeManagementMapper.duplChkNodeName(nodeName, nodeNo);
	}
	
	public int count(NodeManagementDomain nodeManagementDomain){
		return nodeManagementMapper.count(nodeManagementDomain);
	}
	
	public List<NodeManagementDomain> list(NodeManagementDomain nodeManagementDomain, int page, int perPage){
		int start = ((page - 1) * perPage);
		int end = perPage;
		
		return nodeManagementMapper.list(nodeManagementDomain, start, end);
	}
	
	public NodeManagementDomain detail(NodeManagementDomain nodeManagementDomain){
		return nodeManagementMapper.detail(nodeManagementDomain);
	}
	
	public void addAction(NodeManagementDomain nodeManagementDomain){
		nodeManagementMapper.addAction(nodeManagementDomain);
	}
	
	public void modifyAction(NodeManagementDomain nodeManagementDomain){
		nodeManagementMapper.modifyAction(nodeManagementDomain);
	}
	
	public void removeAction(NodeManagementDomain nodeManagementDomain){
		nodeManagementMapper.removeAction(nodeManagementDomain);
	}

    public List<LinkedHashMap<String, String>> listExcel(NodeManagementDomain nodeManagementDomain) {
    	return nodeManagementMapper.listExcel(nodeManagementDomain);
    }
}

