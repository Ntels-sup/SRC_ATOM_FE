package com.ntels.avocado.service.atom.security.usermanage;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.security.usermanage.UserManageMapper;
import com.ntels.avocado.domain.atom.security.usermanage.UserManageDomain;

@Service
public class UserManageService {
	@Autowired
	private UserManageMapper userManageMapper;
	
	public List<Map<String, String>> listUserGroup(){
		return userManageMapper.listUserGroup();
	}
	
	public List<Map<String, String>> listUserLevel(String userLevelId){
		return userManageMapper.listUserLevel(userLevelId);
	}
	
	public String getPasswd(String user_id){
		return userManageMapper.getPasswd(user_id);
	}
	
	public int getPasswdLifeCycle(String userLevelId){
		return userManageMapper.getPasswdLifeCycle(userLevelId);
	}

	public int duplChkUserId(String userId){
		return userManageMapper.duplChkUserId(userId);
	}
	
	public int count(UserManageDomain userManageDomain){
		return userManageMapper.count(userManageDomain);
	}
		
	public List<UserManageDomain> list(UserManageDomain userManageDomain, int page, int perPage){
		int start = ((page - 1) * perPage);
		int end = perPage;
		
		return userManageMapper.list(userManageDomain, start, end);
	}
	
	public UserManageDomain detail(UserManageDomain userManageDomain){
		return userManageMapper.detail(userManageDomain);
	}
	
	public void addAction(UserManageDomain userManageDomain){
		userManageMapper.addAction(userManageDomain);
	}
	
	public void modifyAction(UserManageDomain userManageDomain){
		userManageMapper.modifyAction(userManageDomain);
	}
	
	public void removeAction(UserManageDomain userManageDomain){
		userManageMapper.removeAction(userManageDomain);
	}
	
    public List<LinkedHashMap<String, String>> listExcel(UserManageDomain userManageDomain) {
    	return userManageMapper.listExcel(userManageDomain);
    }
}
