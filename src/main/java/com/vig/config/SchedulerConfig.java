package com.vig.config;

import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

public class SchedulerConfig implements SchedulingConfigurer {

	private final int POOL_SIZE = 10;
	
	@Override
	public void configureTasks(ScheduledTaskRegistrar scheduledTaskRegistrar) {
		// 쓰레드 풀을 생성하고 생성된 쓰레드풀의 모든 작업을 수행한다.
		// 동작해야 하는 쓰레드가 1개 이상 같이 돌아가야 할떄 사용
		ThreadPoolTaskScheduler threadPoolTaskScheduler = new ThreadPoolTaskScheduler();
		
        threadPoolTaskScheduler.setPoolSize(POOL_SIZE);       
        threadPoolTaskScheduler.initialize();

        scheduledTaskRegistrar.setTaskScheduler(threadPoolTaskScheduler);

	}

}
