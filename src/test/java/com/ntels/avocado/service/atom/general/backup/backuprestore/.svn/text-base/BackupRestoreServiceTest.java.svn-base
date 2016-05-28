package com.ntels.avocado.service.atom.general.backup.backuprestore;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.ntels.avocado.domain.atom.general.backup.backuprestore.Condition;
import com.ntels.avocado.service.atom.general.backup.backuprestore.PackageService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/datasource-config.xml",
        "classpath:/junit_test/root-context.xml"
})
@WebAppConfiguration
public class BackupRestoreServiceTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private PackageService packageService;
	
	@Test
	public void testDummy() {
		assertTrue(true);
	}
	
	@Ignore
	public void testGetFileList() {

		String node_id = "123";
		String language = "en";

		Condition condition = new Condition();
		condition.setNode_id(node_id);
		condition.setLanguage(language);
		
		logger.debug( "node_id : " + node_id );
		logger.debug( "language : " + language );
		
		List<Map<String,Object>> list = packageService.getFileList(condition);
		
		logger.debug( "list.size() : " + list.size() );
		
		
		assertNotNull(list);
	}

}
