package com.vig.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vig.domain.Category;
import com.vig.domain.Event;
import com.vig.domain.Image;
import com.vig.domain.ImageColor;
import com.vig.domain.ImageKeyword;
import com.vig.domain.User;
import com.vig.service.CategoryService;
import com.vig.service.ColorService;
import com.vig.service.EventService;
import com.vig.service.ImageService;
import com.vig.service.KeywordService;
import com.vig.service.UserService;
import com.vig.util.VisionInfo;

@Controller
@RequestMapping("/main/*")
public class mainController {

	public static final Logger logger = LogManager.getLogger(mainController.class);

	private static String OS = System.getProperty("os.name").toLowerCase();

	@Autowired	
	private UserService userServices;

	@Autowired
	private CategoryService categoryServices;

	@Autowired
	private EventService eventServices;

	@Autowired
	private ImageService imageServices;

	@Autowired
	private KeywordService keywordServices;

	@Autowired
	private ColorService colorServices;


	@Autowired
	private ServletContext context;

	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;

	@Value("${uploadPath}")
	String uploadPath;

	@Value("${realPath}")
	String realPath;


	//BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	public mainController() {
	}

	@RequestMapping("vig")
	public ModelAndView getMain(Model model, HttpSession session) throws Exception {

		List<Category> categoryList = categoryServices.getAllCategoryList();
		List<Event> eventList = eventServices.getLastEventList();

		User user = (User) session.getAttribute("user");

		if (user != null) {
			user.setGoogleId("");
			user.setPassword("");

		}

		model.addAttribute("user", user);

		model.addAttribute("eventList", eventList);
		//model.addAttribute("categoryList", categoryList);
		model.addAttribute("pageSize", pageSize);

		
		
		return new ModelAndView("forward: /main/main.jsp");
	}

	// 최소 세팅시만 실행하는 함수
	@RequestMapping("setImage")
	public ModelAndView setImageKeyword() throws Exception {

		//기본 세팅한 키워드 개수 : 24개
		if (keywordServices.getKeywordAllCount() <= 25) {

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

			List<User> list = userServices.getAllUserList();

			logger.debug("회원정보 해쉬 적용 시작");

			for (User user : list) {
				//String pwdBycrypt = passwordEncoder.encode(user.getPassword());
				//user.setPassword(pwdBycrypt);
				
				user.setPassword(user.getPassword());
				userServices.updateUser(user);
			}

			logger.debug("회원정보 해쉬 적용 완료");

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

					// 쓰래드 실행이 완료 된 이후 DB에 데이터 삽입
					for (VisionInfo vision : visions) {

						for (ImageKeyword keyword : vision.getKeywords()) {
							keywordServices.addKeyword(keyword);
						}

						for (ImageColor color : vision.getColors()) {
							colorServices.addColor(color);
						}
					}

					// 1동안 멈춤
					logger.debug("VISION Request 할당량으로 인해 1분간 정지");
					Thread.sleep(60000);
					logger.debug("이미지 정보 추출 재시작");

				}

				long Totalend = System.currentTimeMillis();
				logger.debug("이미지 정보 추출 완료 / 총 추출 시간 : " + getTotalWorkTime(Totalstart, Totalend) + "초");
				return new ModelAndView("forward:/common/alertView.jsp", "message", "세팅 완료");

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

				// 쓰래드 실행이 완료 된 이후 DB에 데이터 삽입
				for (VisionInfo vision : visions) {

					for (ImageKeyword keyword : vision.getKeywords()) {
						keywordServices.addKeyword(keyword);
					}

					for (ImageColor color : vision.getColors()) {
						colorServices.addColor(color);
					}
				}

				long Totalend = System.currentTimeMillis();
				logger.debug("이미지 정보 추출 완료 / 총 추출 시간 : " + getTotalWorkTime(Totalstart, Totalend) + "초");
				return new ModelAndView("forward:/common/alertView.jsp", "message", "세팅 완료");

			}

		} else {
			return new ModelAndView("forward:/common/alertView.jsp", "message", "데이터가 이미 있습니다.");
		}
	}

	
	private int getTotalWorkTime(long start, long end) {
		return (int) ((end - start) / 1000);
	}

}
