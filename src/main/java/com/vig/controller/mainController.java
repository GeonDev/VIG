package com.vig.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vig.domain.Category;
import com.vig.domain.Event;
import com.vig.domain.User;
import com.vig.service.CategoryService;
import com.vig.service.EventService;

@Controller
public class mainController {

	@Autowired
	private CategoryService categoryServices;

	@Autowired
	private EventService eventServices;

	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;



	public mainController() {	}

	@GetMapping
	public ModelAndView getMain(Model model, HttpSession session) throws Exception {

		List<Category> categoryList = categoryServices.getAllCategoryList();
		List<Event> eventList = eventServices.getLastEventList();

		User user = (User) session.getAttribute("user");		

		model.addAttribute("user", user);

		model.addAttribute("eventList", eventList);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("pageSize", pageSize);

		
		return new ModelAndView("main/main");
	}



	


}
