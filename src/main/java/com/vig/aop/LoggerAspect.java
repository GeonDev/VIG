package com.vig.aop;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.vig.domain.Feed;
import com.vig.domain.History;
import com.vig.domain.User;
import com.vig.service.FeedService;
import com.vig.service.HistoryService;
import com.vig.util.CommonUtil;

@Component
@Aspect
public class LoggerAspect {

	@Autowired
	private HistoryService historyService;
	
	@Autowired
	private FeedService feedService;

	
	public static final Logger logger = LoggerFactory.getLogger(LoggerAspect.class); 

	//@Around("execution(* com.board..controller.*Controller.*(..)) or execution(* com.board..service.*Impl.*(..)) or execution(* com.board..mapper.*Mapper.*(..))")
	@Around("execution(* com.vig.controller.*Controller.get*(..))")
	public Object printLog(ProceedingJoinPoint joinPoint) throws Throwable {
		
		
		//가지고온 joinPoint의 타입이름을 갖고온다 -> 여기서는 컨트롤러 이름
		String name = joinPoint.getSignature().getDeclaringTypeName();
				
		//전달되는 메소드의 파라미터를 담는다.
		Object[] parms = joinPoint.getArgs();		
		
		long startTime = System.currentTimeMillis();
		
		//Around로 가져온 프로세스가 실행된다.
		Object ret = joinPoint.proceed();
		
		// 메소드가 실행될때 까지 걸리는 실행시간 측정
		long time = System.currentTimeMillis() - startTime;
		
		for(Object t : parms) {
			if(t != null) {
				logger.info("ParameterType :" + t.getClass().getSimpleName() +"| Value :" + t.toString());
			}
		}
		
		logger.info(name + "." + joinPoint.getSignature().getName() + "() " + "WorkTime : "+ (time/1000.0f));
		
		
		
		return ret;
	}

	
	
	
	@Before("execution(* com.vig.controller.FeedController.getFeed(..))")
	public void  addHistory(JoinPoint joinPoint) throws Exception  {
		
		int feedId = (int)joinPoint.getArgs()[0];
		HttpSession session = (HttpSession)joinPoint.getArgs()[1];
		HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[2];
				
		//ip로 조회수 counting 하는 부분
		String ipAddress = CommonUtil.getUserIp(request);

		Feed feed = feedService.getFeed(feedId);
		User user = (User)session.getAttribute("user");

		
		// 로그인한 유저정보가 있는지 체크 - 히스토리를 남기는 부분입니다.
		History history = new History();		
		history.setWatchUser(user);
		// 유저가 열람한 피드 기록은 0으로 처리
		history.setHistoryType(0);
		history.setShowFeed(feed);
		history.setIpAddress(ipAddress);
		
			
		//같은 기록의 히스토리가 있는지 체크
		if(historyService.getViewHistory(history) == 0 ) {				
			
			historyService.addHistory(history);
			feedService.updateViewCount(feedId);
			
			logger.info("FeedId : "+ feedId+" FeedViewCount History update" );
			
			if(user != null ) {
				logger.info("UserCode : "+ user.getUserCode()+" FeedView History update" );
			}			
			
		}else {
			//유저가 로그인한 경우 히스토리 열람 날짜를 최신으로 변경
			if(user != null) {
				historyService.updateHistoryViewDate(history);
			}	
		}	
	}
	
}
