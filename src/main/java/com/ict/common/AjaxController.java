package com.ict.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AjaxController {
	@GetMapping("spring_ajax_go.do")
	public ModelAndView getSpringAjax() {
		return new ModelAndView("ajax/ajax_exam");
	}
	
	@GetMapping("spring_ajax_go2.do")
	public ModelAndView getSpringAjax2() {
		return new ModelAndView("ajax/ajax_exam2");
	}
}
