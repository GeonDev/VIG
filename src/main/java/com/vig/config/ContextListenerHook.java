package com.vig.config;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.vig.scheduler.Scheduler;


public class ContextListenerHook implements ServletContextListener {	
	
	private Scheduler scheduler = null;
	

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		try {

			if(scheduler == null) {				 
				scheduler = new Scheduler();		
				// 2분에 한번씩 실행
				scheduler.startScheduler(120000);
			}
			
        } catch (Exception e) {
            e.printStackTrace();
        }

	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		try
        {
			if(scheduler != null) {
				scheduler.stopScheduler();				
				Thread.sleep(1000);
			}
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
	}

}
