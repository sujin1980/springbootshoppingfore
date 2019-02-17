package com.shopping.mall.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class UserController {
	 private static Logger LOGGER = LoggerFactory.getLogger(AlipayWAPPayController.class);

	
	
	 @RequestMapping("/hello")  
     public String index() {  
          return"Hello World";  
     } 
	 
	 
	 @RequestMapping("/get")  
	 @ResponseBody
     public String get(Integer userid) {  
		 //User u=userService.getNameById(userid);
		 
		 return "";//JSON.toJSONString(u);
     }
	 
	 
	 
}

