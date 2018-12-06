package com.xiaohei.web.configurer;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

public class XiaoHeiWebAppConfigurer {
	@Configuration
	public class MyWebAppConfigurer extends WebMvcConfigurerAdapter {

	    @Bean
	    public InternalResourceViewResolver viewResolver() {
	        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
	        viewResolver.setPrefix("/");
	        viewResolver.setSuffix(".jsp");
	        viewResolver.setViewClass(JstlView.class);
	        return viewResolver;
	    }
	}
}