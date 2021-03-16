package com.vig;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.vig.controller.mainController;
import com.vig.domain.Image;
import com.vig.domain.Search;
import com.vig.domain.User;
import com.vig.service.ColorService;
import com.vig.service.ImageService;
import com.vig.service.KeywordService;
import com.vig.service.UserService;
import com.vig.util.CommonUtil;
import com.vig.util.VisionInfo;

public class SetImages {
	
	public static final Logger logger = LoggerFactory.getLogger(mainController.class);
	
	private static String OS = System.getProperty("os.name").toLowerCase();

	@Autowired	
	private UserService userServices;

	@Autowired
	private ImageService imageServices;

	@Autowired
	private KeywordService keywordServices;

	@Autowired
	private ColorService colorServices;

	@Autowired
	private ServletContext context;
	
	@Value("${uploadPath}")
	String uploadPath;

	@Value("${realPath}")
	String realPath;

	public static void main(String[] args) {
	
		
		SetImages setting = new SetImages();
		
		try {
			setting.setPasswordforSHA();
			//setting.setImageKeyword();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void setPasswordforSHA() throws Exception{
		
		//해쉬값을 위한 추출임으로 별다른 입력값없이 수행시킨다.
		List<User> list = userServices.getAllUserList(new Search());
		
		logger.debug("회원정보 해쉬 적용 시작");

		for (User user : list) {			
			user.setPassword(CommonUtil.generateSHA256(user.getPassword()));		
			userServices.updateUser(user);
		}

		logger.debug("회원정보 해쉬 적용 완료");
	}
	
	
	
	// 최소 암호화, 비전 키워드, 색상을 추출해주는 함수
	public void setImageKeyword() throws Exception {
	
			String path = context.getRealPath("/");

			if (OS.contains("win")) {
				// 워크스페이스 경로를 받아온다.
				path = path.substring(0, path.indexOf("\\.metadata"));
				path += uploadPath;
			} else {
				// 실제 톰켓 데이터가 저장되는 경로를 가리킨다.
				path = realPath;
			}

			List<Image> imagelist = new ArrayList<Image>();
			// 저장되어 있는 모든 이미지를 불러옴
			imagelist = imageServices.getALLImageList();

			logger.debug("이미지 정보 추출 시작");
			long Totalstart = System.currentTimeMillis();

			// 비전의 분당 최대 요청량 => 요청량이 1800이 넘을 경우 별도 처리
			if (imagelist.size() * 5 > 1800) {

				// 나누어 요청해야 되는 횟수
				int imageGroup = (int) Math.ceil(imagelist.size() / 350);

				for (int i = 1; i <= imageGroup; i++) {

					// 비전 정보 + 쓰레드 동작을 위한 비전 배열
					ArrayList<VisionInfo> visions = new ArrayList<VisionInfo>();

					for (int j = (i - 1) * 350; j < (350 * i) - 1; j++) {
						if (j < imagelist.size()) {
							VisionInfo vision = new VisionInfo(path + imagelist.get(j).getImageFile(),
									imagelist.get(j).getImageId());
							vision.start();
							visions.add(vision);
						}
					}

					// 생성된 쓰래드를 연결하여 모든 쓰레드가 완료 될때 까지 기다림
					for (VisionInfo vision : visions) {
						vision.join();
					}
			

					// 1동안 멈춤
					logger.debug("VISION Request 할당량으로 인해 1분간 정지");
					Thread.sleep(60000);
					logger.debug("이미지 정보 추출 재시작");

				}

				long Totalend = System.currentTimeMillis();
				logger.debug("이미지 정보 추출 완료 / 총 추출 시간 : " + getTotalWorkTime(Totalstart, Totalend) + "초");			

			} else {

				// 비전 정보 + 쓰레드 동작을 위한 비전 배열
				ArrayList<VisionInfo> visions = new ArrayList<VisionInfo>();

				for (Image image : imagelist) {
					VisionInfo vision = new VisionInfo(path + image.getImageFile(), image.getImageId());
					vision.start();
					visions.add(vision);
				}

				// 생성된 쓰래드를 연결하여 모든 쓰레드가 완료 될때 까지 기다림
				for (VisionInfo vision : visions) {
					vision.join();
				}
				logger.debug("쓰레드 실행 완료 / DB 저장 시작");

				long Totalend = System.currentTimeMillis();
				logger.debug("이미지 정보 추출 완료 / 총 추출 시간 : " + getTotalWorkTime(Totalstart, Totalend) + "초");
			}


	}
	
	private int getTotalWorkTime(long start, long end) {
		return (int) ((end - start) / 1000);
	}

}
