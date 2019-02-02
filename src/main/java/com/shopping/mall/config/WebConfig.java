package com.shopping.mall.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

/**
 * 
* @Title: WebConfig
* @Description: 
* JSP和Thymeleaf模板的设置
* @Version:1.0.0  
* @author pancm
* @date 2018年7月16日
 */
@Configuration //用来定义 DispatcherServlet 应用上下文中的 bean
@EnableWebMvc
@ComponentScan
public class WebConfig extends WebMvcConfigurerAdapter {
	@Autowired
	LoginInterceptor loginInterceptor;
	   
	@Override
    public void addViewControllers( ViewControllerRegistry registry ) {
        registry.addViewController( "/" ).setViewName( "forward:/mainFrame.jsp" );
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE );
        super.addViewControllers( registry );
    } 
	
	@Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/");
        resolver.setSuffix(".jsp");
        resolver.setViewNames("*");
        resolver.setOrder(2);
        return resolver;
    }

//    @Bean
//    public ITemplateResolver templateResolver() {
//        SpringResourceTemplateResolver templateResolver = new SpringResourceTemplateResolver();
//        templateResolver.setTemplateMode("HTML5");
//        templateResolver.setPrefix("/WEB-INF/");
//        templateResolver.setSuffix(".html");
//        templateResolver.setCharacterEncoding("utf-8");
//        templateResolver.setCacheable(false);
//        return templateResolver;
//    }
//
//    @Bean
//    public SpringTemplateEngine templateEngine() {
//        SpringTemplateEngine templateEngine = new SpringTemplateEngine();
//        templateEngine.setTemplateResolver(templateResolver());
//        return templateEngine;
//    }
//
//    @Bean
//    public ThymeleafViewResolver viewResolverThymeLeaf() {
//        ThymeleafViewResolver viewResolver = new ThymeleafViewResolver();
//        viewResolver.setTemplateEngine(templateEngine());
//        viewResolver.setCharacterEncoding("utf-8");
//        viewResolver.setViewNames(new String[]{"thymeleaf/*"});
//        viewResolver.setOrder(1);
//        return viewResolver;
//    }

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        super.addResourceHandlers(registry);
    }
    
 
 
	/**
	 * 不需要登录拦截的url:登录注册和验证码
	 */
	final String[] notLoginInterceptPaths = {"/signin","/login/**","/index/**","/register/**",
			"/kaptcha.jpg/**", "/login.jsp", "/mainFrame.jsp", "/*.jsp", "/kaptcha/**"};//"/", "/login/**", "/person/**", "/register/**", "/validcode", "/captchaCheck", "/file/**", "/contract/htmltopdf", "/questions/**", "/payLog/**", "/error/**" };
 
	final String[] inLoginInterceptPaths = {"/user/**","/product/**","/producttype/**", 
			"/log/**", "/client/**","/order/**"};
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// 日志拦截器
		//registry.addInterceptor(logInterceptor).addPathPatterns("/**");
		
		// 登录拦截器
		//registry.addInterceptor(loginInterceptor).addPathPatterns(inLoginInterceptPaths).excludePathPatterns(notLoginInterceptPaths);
		super.addInterceptors(registry);
	}

}


