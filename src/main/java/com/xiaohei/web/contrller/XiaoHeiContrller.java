package com.xiaohei.web.contrller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class XiaoHeiContrller {

	 @GetMapping("/sayHello")
	 public String login(){
		 return "hello xiaohei";
	 }
}
