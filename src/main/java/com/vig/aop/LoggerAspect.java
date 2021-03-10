package com.vig.aop;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LoggerAspect {

	public static final Logger logger = LogManager.getLogger(LoggerAspect.class); 

	//@Around("execution(* com.board..controller.*Controller.*(..)) or execution(* com.board..service.*Impl.*(..)) or execution(* com.board..mapper.*Mapper.*(..))")
	@Around("execution(* com.vig.controller.*Controller.get*(..))")
	public Object printLog(ProceedingJoinPoint joinPoint) throws Throwable {

		String type = "";
		
		
		String name = joinPoint.getSignature().getDeclaringTypeName();
		
		//전달되는 메소드의 파라미터를 담는다.
		Object[] parms = joinPoint.getArgs();

		
		
		
		if (name.contains("Controller") == true) {
			type = "Controller ===> ";

		} else if (name.contains("Service") == true) {
			type = "ServiceImpl ===> ";

		} else if (name.contains("Mapper") == true) {
			type = "Mapper ===> ";
		}

		logger.info(type + name + "." + joinPoint.getSignature().getName() + "()");
	
		if(parms != null ) {
			for(Object t : parms) {
				logger.info(type + "." + joinPoint.getSignature().getName() + "() :" + t.toString());
			}
		}
		
		return joinPoint.proceed();
	}

}
