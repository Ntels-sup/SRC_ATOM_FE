package com.ntels.avocado.service.atom.security.usergroup;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.dao.atom.security.usergroup.UserGroupMapper;
import com.ntels.avocado.domain.atom.security.usergroup.UserGroupDomain;
import com.ntels.avocado.domain.atom.security.usermanage.UserManageDomain;

@Service
public class UserGroupService {
	@Autowired
	UserGroupMapper userGroupMapper;

	public List<Map<String, String>> listUserGroup(){
		return userGroupMapper.listUserGroup();
	}

	public int userGroupUseCnt(UserGroupDomain userGroupDomain){
		return userGroupMapper.userGroupUseCnt(userGroupDomain);
	}
	
	public int duplChkGrpName(String groupName, String groupNo){
		return userGroupMapper.duplChkGrpName(groupName, groupNo);
	}
	
	public int count(UserGroupDomain userGroupDomain){
		return userGroupMapper.count(userGroupDomain);
	}
		
	public List<UserGroupDomain> list(UserGroupDomain userGroupDomain, int page, int perPage){
		int start = ((page - 1) * perPage);
		int end = perPage;
		
		return userGroupMapper.list(userGroupDomain, start, end);
	}
	
	public UserGroupDomain detailUserGroup(UserGroupDomain userGroupDomain){
		return userGroupMapper.detailUserGroup(userGroupDomain);
	}
	
	public List<UserGroupDomain> detailUserGroupPkg(UserGroupDomain userGroupDomain){
		return userGroupMapper.detailUserGroupPkg(userGroupDomain);
	}

	@Transactional
	public void addAction(UserGroupDomain userGroupDomain){
		List<UserGroupDomain> userGroupPkgList = new ArrayList<UserGroupDomain>();

		//add 한 group_id 가져오기
		String group_id= userGroupMapper.getAddGroupId(userGroupDomain);
		userGroupDomain.setGroup_no(group_id);
		
		//userGroup insert
		userGroupMapper.addUserGroup(userGroupDomain);
		
		//userGroupPkg data parse
		if(userGroupDomain.getPkg_name() != null){
			String pkg_name[] = userGroupDomain.getPkg_name().split(",");
			
			//description null exception 처리 
			String userGroupPkgDesc[] = new String[pkg_name.length]; 
			String userGroupPkgDescTmp[] = userGroupDomain.getUserGroupPkgDesc().split(",");
			for(int j=0; j<userGroupPkgDescTmp.length; j++){
				userGroupPkgDesc[j] = userGroupPkgDescTmp[j];
			}
			
			for(int i=0; i<pkg_name.length; i++){
				UserGroupDomain addUserGroupPkg = new UserGroupDomain();
				addUserGroupPkg.setGroup_no(group_id);
				addUserGroupPkg.setPkg_name(pkg_name[i]);;
				addUserGroupPkg.setUserGroupPkgDesc(userGroupPkgDesc[i]);
				userGroupPkgList.add(addUserGroupPkg);
			}
		} 
		
		//userGroupPkg data insert
		if(userGroupPkgList.size() > 0){
			for(int j=0; j<userGroupPkgList.size(); j++){
				userGroupMapper.addUserGroupPkg(userGroupPkgList.get(j));
			}
		}
	}
	
	@Transactional
	public void modifyAction(UserGroupDomain userGroupDomain){
		List<UserGroupDomain> userGroupPkgList = new ArrayList<UserGroupDomain>();
		
		userGroupMapper.modifyUserGroup(userGroupDomain);
		userGroupMapper.removeUserGroupPkg(userGroupDomain);
		
		//userGroupPkg data parse
		if(userGroupDomain.getPkg_name() != null){
			String pkg_name[] = userGroupDomain.getPkg_name().split(",");
			
			//description null exception 처리 
			String userGroupPkgDesc[] = new String[pkg_name.length]; 
			String userGroupPkgDescTmp[] = userGroupDomain.getUserGroupPkgDesc().split(",");
			for(int j=0; j<userGroupPkgDescTmp.length; j++){
				userGroupPkgDesc[j] = userGroupPkgDescTmp[j];
			}
					
			for(int i=0; i<pkg_name.length; i++){
				UserGroupDomain addUserGroupPkg = new UserGroupDomain();
				addUserGroupPkg.setGroup_no(userGroupDomain.getGroup_no());
				addUserGroupPkg.setPkg_name(pkg_name[i]);
				addUserGroupPkg.setUserGroupPkgDesc(userGroupPkgDesc[i]);
				userGroupPkgList.add(addUserGroupPkg);
			}
		} 
		
		//userGroupPkg data insert
		if(userGroupPkgList.size() > 0){
			for(int j=0; j<userGroupPkgList.size(); j++){
				userGroupMapper.addUserGroupPkg(userGroupPkgList.get(j));
			}
		}
	}
	
	@Transactional
	public void removeAction(UserGroupDomain userGroupDomain){
		userGroupMapper.removeUserGroup(userGroupDomain);
		userGroupMapper.removeUserGroupPkg(userGroupDomain);
	}
	
    public List<LinkedHashMap<String, String>> listExcel(UserGroupDomain userGroupDomain) {
    	return userGroupMapper.listExcel(userGroupDomain);
    }
}
