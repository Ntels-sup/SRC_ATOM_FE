package com.ntels.ncf.dynamicMybatis;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

@Aspect
public class MybatisAspect  {
	
	//Unnecessary @SuppressWarnings("unused")	MybatisAspect.java	/emsOCS/src/main/java/com/ntels/ncf/dynamicMybatis	line 10	Java Problem
	//@SuppressWarnings("unused")
	@Before("execution(* *.openSession(..))")
	private void getMapper(JoinPoint jp) throws Throwable{
		
		//System.err.println("openSession .... try");
		
	}

}
