package com.ntels.ncf.utils;

public class PasingUtil {
	
	public static int getPage(Integer page, Integer perPage, Integer totalCount) {
		int overridePage = (int) Math.ceil((float)totalCount / (float)perPage);
		if (page > overridePage) return overridePage;
		return page;
	}
}
