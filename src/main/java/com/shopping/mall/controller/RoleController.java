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
import com.shopping.mall.model.Role;
import com.shopping.mall.service.RoleService;

@Controller
public class RoleController {
	//private static Logger logger = Logger.getLogger(RoleController.class);
	
	@Autowired
	private RoleService roleService;
	

	
	@RequestMapping("/role/hello")
    public String hello(Model model) {
        return "redirect:/role/list2";
    }
	
//    @RequestMapping("/role/list2")
//    public String list(Model model) {
//    	System.out.println("Thymeleaf查询所有");
//        List<Role> roles=roleService.findAll();
//        model.addAttribute("roles", roles);
//        return "role/list2";
//    }
    @RequestMapping("/role/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<Role> roles=roleService.findAll();
        model.addAttribute("roles", roles);
        return "role/list2";
    }


    @RequestMapping(value = "/role/deleteRoles", method = { RequestMethod.POST })
    public String deleteRoles(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        List<String>  idlist = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	
        	Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlist.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	
        }
        System.out.println(idlist);
        roleService.deleteRoles(idlist);
        return "redirect:/role/list2";
    }  
    
    @RequestMapping("/role/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "role/Add2";
    }
        
    
    @RequestMapping(value ="/role/add2", method = { RequestMethod.POST })
    public String add(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        Role role = new Role();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(role);
        roleService.addRole(role);
        return "redirect:/role/list2";
    }      

    @RequestMapping("/role/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        
        Role  role = roleService.findRoleById(id);
        model.addAttribute("role", role);
        return "role/Edit2";
    }

    @RequestMapping("/role/edit2")
    public String edit(HttpServletRequest request, @RequestBody String idlistJson) throws UnsupportedEncodingException {
    	List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        Role role = new Role();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(role);
        roleService.updateRole(role);
        return "redirect:/role/list2";
    }

    @RequestMapping("/role/toDelete2")
    public String delete(int id) {
        roleService.deleteRole(id);
        return "redirect:/role/list2";
    }
}

