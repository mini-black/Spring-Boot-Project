package com.xiaohei.web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableAutoConfiguration
@ComponentScan(basePackages={"com.xiaohei.web.contrller"}) 
public class XiaoheiWebMain {
	public static void main(String[] args) {
        SpringApplication.run(XiaoheiWebMain.class, args);
	}
}
