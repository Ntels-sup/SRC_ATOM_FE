package com.ntels.avocado.dao.atom.config.processmanager;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ntels.avocado.domain.atom.config.networkmanager.AtomImage;
import com.ntels.avocado.domain.atom.config.networkmanager.Line;
import com.ntels.avocado.domain.atom.config.networkmanager.Node;
import com.ntels.avocado.domain.atom.config.networkmanager.Pkg;
import com.ntels.avocado.domain.atom.config.processmanager.NodeType;
import com.ntels.avocado.domain.atom.config.processmanager.Proc;
import com.ntels.avocado.domain.atom.config.processmanager.Svc;

public interface ProcessManagerMapper {
	public List<Pkg> listPkg();
	public List<NodeType> listNodeType();
	public List<Svc> listSvc();
	public List<Svc> listNodeSvc(Node node);
	public List<Proc> listProcBase();
	public List<Proc> listProc(Svc svc);
	public List<Proc> listMonitoringProc(Svc svc);
	public int insertSvc(Svc svc);
	public Svc getSvc(Svc svc);
	public int updateSvc(Svc svc);
	public int deleteSvc(Svc svc);
	public List<Line> listLine(Svc svc);
	public int deleteImages(Svc svc);
	public int deleteSvcProc(Svc svc);
	public int insertImage(AtomImage atomImage);
	public int updateImage(AtomImage atomImage);
	public int deleteLine(Svc svc);
	public int deleteQueue(Svc svc);
	public int resetProcPosition(Svc svc);
	public int updatePkgPosition(Pkg pkg);
	public Proc getProc(Proc proc);
	public int insertLine(Line Line);
	public int insertQueue(Line Line);
	public int insertProc(Proc proc);
	public int updateProc(Proc proc);
	public String getProcIdByUUID(@Param(value="image_uuid")String image_uuid);
}
