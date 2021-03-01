package com.vig.scheduler;

import java.util.Date;

import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;


public abstract class DynamicAbstractScheduler {
    
	private ThreadPoolTaskScheduler scheduler;
 
    public void stopScheduler() {
        scheduler.shutdown();
    }
    
    public void startScheduler(long delay) {
        scheduler = new ThreadPoolTaskScheduler();
        scheduler.initialize();
        scheduler.scheduleWithFixedDelay(getRunnable(), delay);
    }
    
    public void startScheduler(Date startTime, long delay) {
        scheduler = new ThreadPoolTaskScheduler();
        scheduler.initialize();
        scheduler.scheduleWithFixedDelay(getRunnable(), startTime, delay);
    }
 
    private Runnable getRunnable(){
        return new Runnable(){
            @Override
            public void run() {
                runner();
            }
        };
    }
 
    public abstract void runner();

}