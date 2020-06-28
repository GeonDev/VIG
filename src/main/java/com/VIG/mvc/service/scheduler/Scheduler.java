package com.VIG.mvc.service.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


@Component
public class Scheduler {

	@Scheduled(cron="0/3 * * * * *")
	public void TestScheduler() {
		System.out.println("[SERVER] : Scheduler START......");		
	}
	
}
