package com.ntels.avocado.dao.ofcs.test;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;


@Component
public interface TestMapper {

	List<HashMap<String,String>> getTest();
}
