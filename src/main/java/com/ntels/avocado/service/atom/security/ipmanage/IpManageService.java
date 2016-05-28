package com.ntels.avocado.service.atom.security.ipmanage;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.security.ipmanage.IpManageMapper;
import com.ntels.avocado.domain.atom.security.ipmanage.IpManageDomain;

@Service
public class IpManageService {
	@Autowired
	private IpManageMapper ipManageMapper;

	public List<Map<String, String>> listAllowYn(){
		return ipManageMapper.listAllowYn();
	}
	
	public String duplChkIpBandWidth(String ipBandWidth){
		//중복시  noti ip
		String ip = "";
		
		//등록할  ip
		String addIpArr[]= ipBandWidth.split("\\.");
		
		List<IpManageDomain> ipManage = new ArrayList<IpManageDomain>();
		ipManage = ipManageMapper.duplChkIpBandWidth();
		
		//TAT_IP_MANAGER의 IP값과 등록  IP 대역 비교
		loop:
		for(int i=0; i<ipManage.size(); i++){
			String ipArr[] = ipManage.get(i).getIp().split("\\.");
			for(int j=0; j<ipArr.length; j++){
				 //System.err.println("=========ip===="+ipManage.get(i).getIp());
				//split 첫번째 값 ex) 127.1.2.3 -> 127
				if(addIpArr[j].equals(ipArr[j])){
					//System.err.println("==addIpArr[i]=="+addIpArr[j] + "  , " + "==ipArr[i]=="+ipArr[j]);
					//split 두번째 값 ex) 127.1.2.3 -> 1
					if(addIpArr[j+1].equals(ipArr[j+1])){
						//System.err.println("==addIpArr[i+1]=="+addIpArr[j+1] + "  , " + "==ipArr[i+1]=="+ipArr[j+1]);
						//split 세번째 값 ex) 127.1.2.3 -> 2
						if(addIpArr[j+2].equals(ipArr[j+2])){
							//System.err.println("==addIpArr[i+2]=="+addIpArr[j+2] + "  , " + "==ipArr[i+2]=="+ipArr[j+2]);
							//split 네번째 값 ex) 127.1.2.3 -> 3
							if(addIpArr[j+3].equals(ipArr[j+3])){
								//System.err.println("==addIpArr[i+3]=="+addIpArr[j+3] + "  , " + "==ipArr[i+3]=="+ipArr[j+3]);
								ip = ipManage.get(i).getIp();
								break loop;
							} else if(addIpArr[j+3].equals("*") || ipArr[j+3].equals("*")){
								ip = ipManage.get(i).getIp();
								break loop;
							} else {
								break;
							}
						} else if(addIpArr[j+2].equals("*") || ipArr[j+2].equals("*")){
							ip = ipManage.get(i).getIp();
							break loop;
						} else {
							break;
						}
					} else if(addIpArr[j+1].equals("*") || ipArr[j+1].equals("*")){
						ip = ipManage.get(i).getIp();
						break loop;
					} else {
						break;
					}
				} else {
					break;
				}
			}
		}
		
		return ip;
	}
	
	public int count(IpManageDomain ipManageDomain){
		return ipManageMapper.count(ipManageDomain);
	}
	
	public List<IpManageDomain> list(IpManageDomain ipManageDomain, int page, int perPage){
		int start = ((page - 1) * perPage);
		int end = perPage;
		
		return ipManageMapper.list(ipManageDomain, start, end);
	}
	
	public IpManageDomain detail(IpManageDomain ipManageDomain){
		return ipManageMapper.detail(ipManageDomain);
	}
	
	public void addAction(IpManageDomain ipManageDomain){
		ipManageDomain.setIp_manager_no(ipManageMapper.getMaxIpNo());
		ipManageMapper.addAction(ipManageDomain);
	}
	
	public void modifyAction(IpManageDomain ipManageDomain){
		ipManageMapper.modifyAction(ipManageDomain);
	}
	
	public void removeAction(IpManageDomain ipManageDomain){
		ipManageMapper.removeAction(ipManageDomain);
	}
	
    public List<LinkedHashMap<String, String>> listExcel(IpManageDomain ipManageDomain) {
    	return ipManageMapper.listExcel(ipManageDomain);
    }
}
