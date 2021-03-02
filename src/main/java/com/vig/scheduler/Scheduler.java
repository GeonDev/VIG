package com.vig.scheduler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.vig.domain.ImageInfo;
import com.vig.util.VisionInfo;

@Component
public class Scheduler extends DynamicAbstractScheduler{

	
	@Value("${limitVisionImageCount}")
	int limitCount;
	
	List<ImageInfo> imagelist = new ArrayList<ImageInfo>();
	
	
	@Override
	public void runner() {
		int currentSize = WaitingList.images.size();
		
		if(limitCount > 0) {
			if(currentSize > limitCount ) {
				for(int i =0; i< limitCount; i++) {
					imagelist.add(WaitingList.images.poll());
				}
				
			}else {
				for(int i=0; i< currentSize; i++) {
					imagelist.add(WaitingList.images.poll());
				}
			}
			
			
			for(ImageInfo info: WaitingList.images) {
				
				VisionInfo vision = new VisionInfo(info.getPath(), info.getImageId());
				vision.start();			
			}
		}else {
			System.out.println("no lmages");
		} 

	}

}
