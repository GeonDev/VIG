package com.vig;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


/**
 * <p> 처음 URL 접속시 view 연결용 Controller 
 * 
 * @author Son Geon
 * @version 2.0, 2021. 2. 3.
 */


@Controller
public class StartController {
	@GetMapping
	public String index() {
		return "index";
	}
}
