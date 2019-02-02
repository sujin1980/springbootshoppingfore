package com.shopping.mall.controller;


import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.shopping.mall.model.Right;
import com.shopping.mall.service.RightService;

@Controller
public class RightController {
	//private static Logger logger = Logger.getLogger(RightController.class);
	
	@Autowired
	private RightService rightService;
	

	
	@RequestMapping("/right/hello")
    public String hello(Model model) {
        return "redirect:/right/list2";
    }
	
//    @RequestMapping("/right/list2")
//    public String list(Model model) {
//    	System.out.println("Thymeleaf查询所有");
//        List<Right> rights=rightService.findAll();
//        model.addAttribute("rights", rights);
//        return "right/list2";
//    }
    @RequestMapping("/right/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<Right> rights=rightService.findAll();
        model.addAttribute("rights", rights);
        return "right/list2";
    }


    @RequestMapping(value = "/right/deleteRights", method = { RequestMethod.POST })
    public String deleteRights(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        List<String>  idlist = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	
        	Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlist.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	
        }
        System.out.println(idlist);
        rightService.deleteRights(idlist);
        return "redirect:/right/list2";
    }  
    
    @RequestMapping("/right/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "right/Add2";
    }
        
    
    @RequestMapping(value ="/right/add2", method = { RequestMethod.POST })
    public String add(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        Right right = new Right();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(right);
        rightService.addRight(right);
        return "redirect:/right/list2";
    }      

    @RequestMapping("/right/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        
        Right  right = rightService.findRightById(id);
        model.addAttribute("right", right);
        return "right/Edit2";
    }

    @RequestMapping("/right/edit2")
    public String edit(HttpServletRequest request, @RequestBody String idlistJson) throws UnsupportedEncodingException {
    	List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        Right right = new Right();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(right);
        rightService.updateRight(right);
        return "redirect:/right/list2";
    }

    @RequestMapping("/right/toDelete2")
    public String delete(int id) {
        rightService.deleteRight(id);
        return "redirect:/right/list2";
    }
}

