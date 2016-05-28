package com.ntels.avocado.dao.atom.config.networkmanager;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.config.networkmanager.AtomImage;
import com.ntels.avocado.domain.atom.config.networkmanager.Line;
import com.ntels.avocado.domain.atom.config.networkmanager.Node;
import com.ntels.avocado.domain.atom.config.networkmanager.NodeGrp;
import com.ntels.avocado.domain.atom.config.networkmanager.Pkg;
import com.ntels.avocado.domain.atom.config.processmanager.NodeType;

@Component
public interface NetworkManagerMapper {
	public List<Pkg> listPkg();
	public List<NodeGrp> listNodeGrp();
	public List<NodeType> listNodeType();
	public List<Node> listNode(@Param(value="language")String language);
	public List<Node> listMonitoringNodeGUI(@Param(value="language")String language);
	public List<Node> listMonitoringNode(@Param(value="language")String language);
	public int insertNodeGrp(NodeGrp nodeGrp);
	public NodeGrp getNodeGrp(NodeGrp nodeGrp);
	public int updateNodeGrp(NodeGrp nodeGrp);
	public int deleteNodeGrp(NodeGrp nodeGrp);
	public List<Line> listLine();
	public List<Line> listConnection();
	public int resetPkgPosition();
	public int resetNodePosition();
	public int deleteLine();
	public int deleteImages();
	public int insertImage(AtomImage atomImage);
	public int updateImage(AtomImage atomImage);
	public int updatePkgPosition(Pkg pkg);
	public Node getNodeGUI(Node node);
	public Node getNodeGUIByName(Node node);
	public Node getNodeByName(Node node);
	public Node getNode(Node node);
	public int updateNodePosition(Node node);
	public int insertLine(Line Line);
	public int insertNodeGUI(Node node);
	public int insertNode(Node node);
	public int updateNodeGUIByName(Node node);
	public int updateNodeGUI(Node node);
	public int updateNodeByName(Node node);
	public int updateNode(Node node);
}
