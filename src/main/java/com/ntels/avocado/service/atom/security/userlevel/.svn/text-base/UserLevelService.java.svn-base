package com.ntels.avocado.service.atom.security.userlevel;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import com.ntels.avocado.dao.atom.security.userlevel.UserLevelMapper;
import com.ntels.avocado.domain.atom.security.menu.Menu;
import com.ntels.avocado.domain.atom.security.userlevel.AuthMenuDomain;
import com.ntels.avocado.domain.atom.security.userlevel.UserLevelDomain;

@Service
public class UserLevelService {
	@Autowired
	private UserLevelMapper userLevelMapper;
	
	public List<Map<String, String>> listUserLevel(String userLevelId){
		return userLevelMapper.listUserLevel(userLevelId);
	}
	
	public List<Menu> getMenu(String pkgName) {
		return userLevelMapper.getMenu(pkgName);
	}

	public List<Menu> getAuthMenu(String pkgName, String levelId) {
		return userLevelMapper.getAuthMenu(pkgName, levelId);
	}
	
	public int count(UserLevelDomain userLevelDomain){
		return userLevelMapper.count(userLevelDomain);
	}
		
	public List<UserLevelDomain> list(UserLevelDomain userLevelDomain, int page, int perPage){
		int start = ((page - 1) * perPage);
		int end = perPage;
		
		return userLevelMapper.list(userLevelDomain, start, end);
	}

	public UserLevelDomain detail(UserLevelDomain userLevelDomain){
		return userLevelMapper.detail(userLevelDomain);
	}
	
	@Transactional
	public void modifyAction(UserLevelDomain userLevelDomain){
		
		//json -> List<UserAuthDomain> 파싱
		Gson gson = new Gson();
		JsonParser parser = new JsonParser();
		JsonArray jsonArray = (JsonArray)parser.parse(userLevelDomain.getAuthMenuArr());
		List<AuthMenuDomain> authMenuList = gson.fromJson(jsonArray, new TypeToken<List<AuthMenuDomain>>(){}.getType());
		
		//userLevel 수정
		userLevelMapper.modifyAction(userLevelDomain);
		
		//해당 레벨의 authMenu remove  
		userLevelMapper.removeAuthMenu(userLevelDomain);
		
		//해당 레벨의 authMenu insert
		if(authMenuList != null){
			for(int i=0; i< authMenuList.size(); i++){
				userLevelMapper.addAuthMenu(authMenuList.get(i));
			}
		}
	}
	
    public List<LinkedHashMap<String, String>> listExcel(UserLevelDomain userLevelDomain) {
    	return userLevelMapper.listExcel(userLevelDomain);
    }
}
