package com.ntels.ncf.utils.crypto;

import static org.junit.Assert.*;

import org.apache.log4j.Logger;
import org.junit.Test;

public class Sha256UtilTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Test
	public void testGetEncrypt() {
		
		String before = "aaa";
		String after = Sha256Util.getEncrypt(before);

		logger.debug( "[mirinae.maru] before : " + before );
		logger.debug( "[mirinae.maru] after : " + after );
		
		before = "1";
		after  = Sha256Util.getEncrypt(before);

		logger.debug( "[mirinae.maru] before : " + before );
		logger.debug( "[mirinae.maru] after : " + after );
		
		before = "2";
		after  = Sha256Util.getEncrypt(before);

		logger.debug( "[mirinae.maru] before : " + before );
		logger.debug( "[mirinae.maru] after : " + after );
		
		assertEquals( after, "d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35" );
	}

}
