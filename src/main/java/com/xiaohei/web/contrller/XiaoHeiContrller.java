package com.xiaohei.web.contrller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class XiaoHeiContrller {

	@RequestMapping("/apiTools")
	 public ModelAndView apiTools(){
		ModelAndView mav = new ModelAndView("/apiTools.jsp");
		return mav;
	 }
}
