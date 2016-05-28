package com.ntels.avocado.service.atom.config.resourceconfig;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import com.ntels.avocado.dao.atom.config.resourceconfig.ResourceConfigMapper;
import com.ntels.avocado.domain.atom.config.resourceconfig.ResourceConfigDomain;
import com.ntels.avocado.domain.atom.security.userlevel.AuthMenuDomain;

@Service
public class ResourceConfigService {

	@Autowired
	private ResourceConfigMapper resourceConfigMapper;
	
	public List<Map<String, String>> listNodeType(String pkgName){
		return resourceConfigMapper.listNodeType(pkgName);
	}
	public List<Map<String, String>> listResourceGrp(){
		return resourceConfigMapper.listResourceGrp();
	}
	
	public List<Map<String, String>> listStatPeriod(){
		return resourceConfigMapper.listStatPeriod();
	}
	
	public ResourceConfigDomain rscGrpConfig(ResourceConfigDomain resourceConfigDomain){
		return resourceConfigMapper.rscGrpConfig(resourceConfigDomain);
	}
	
	public List<ResourceConfigDomain> rscConifg(ResourceConfigDomain resourceConfigDomain){
		return resourceConfigMapper.rscConifg(resourceConfigDomain);
	}
	
	@Transactional
	public void modifyAction(ResourceConfigDomain resourceConfigDomain){
		//json -> List<UserAuthDomain> 파싱
		Gson gson = new Gson();
		JsonParser parser = new JsonParser();
		JsonArray jsonArray = (JsonArray)parser.parse(resourceConfigDomain.getRscConfigArr());
		List<ResourceConfigDomain> rscConfigList = gson.fromJson(jsonArray, new TypeToken<List<ResourceConfigDomain>>(){}.getType());

		//resource grp modify
		resourceConfigMapper.modifyRscGrpConifg(resourceConfigDomain);
		
		//resource config list update
		if(rscConfigList != null){
			for(int i=0; i< rscConfigList.size(); i++){
				resourceConfigMapper.modifyRscConifg(rscConfigList.get(i));
			}
		}
	}
}
