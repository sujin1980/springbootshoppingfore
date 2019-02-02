package com.shopping.mall.controller;


import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.shopping.mall.model.Loginfo;
import com.shopping.mall.service.LoginfoService;

@Controller
public class LoginfoController2 {
	//private static Logger logger = Logger.getLogger(LoginfoController.class);
	
	@Autowired
	private LoginfoService loginfoService;
	

	
	@RequestMapping("/loginfo/hello")
    public String hello(Model model) {
        return "redirect:/loginfo/list2";
    }
	
//    @RequestMapping("/loginfo/list2")
//    public String list(Model model) {
//    	System.out.println("Thymeleaf查询所有");
//        List<Loginfo> loginfos=loginfoService.findAll();
//        model.addAttribute("loginfos", loginfos);
//        return "loginfo/list2";
//    }
    @RequestMapping("/loginfo/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<Loginfo> loginfos=loginfoService.findAll();
        model.addAttribute("loginfos", loginfos);
        return "loginfo/list2";
    }


    @RequestMapping(value = "/loginfo/deleteLoginfos", method = { RequestMethod.POST })
    public String deleteLoginfos(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        List<String>  idlist = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	
        	Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlist.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	
        }
        System.out.println(idlist);
        loginfoService.deleteLoginfos(idlist);
        return "redirect:/loginfo/list2";
    }  
    
    @RequestMapping("/loginfo/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "loginfo/Add2";
    }
        
    
    @RequestMapping(value ="/loginfo/add2", method = { RequestMethod.POST })
    public String add(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        Loginfo loginfo = new Loginfo();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(loginfo);
        loginfoService.addLoginfo(loginfo);
        return "redirect:/loginfo/list2";
    }      

    @RequestMapping("/loginfo/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        
        Loginfo  loginfo = loginfoService.findLoginfoById(id);
        model.addAttribute("loginfo", loginfo);
        return "loginfo/Edit2";
    }

    @RequestMapping("/loginfo/edit2")
    public String edit(HttpServletRequest request, @RequestBody String idlistJson) throws UnsupportedEncodingException {
    	List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        Loginfo loginfo = new Loginfo();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(loginfo);
        loginfoService.updateLoginfo(loginfo);
        return "redirect:/loginfo/list2";
    }

    @RequestMapping("/loginfo/toDelete2")
    public String delete(int id) {
        loginfoService.deleteLoginfo(id);
        return "redirect:/loginfo/list2";
    }
}

