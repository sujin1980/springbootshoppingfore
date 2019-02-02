package com.shopping.mall.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.shopping.mall.model.ShoppingMallClient;
import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.model.User;
import com.shopping.mall.model.Product;
import com.shopping.mall.service.ClientService;
import com.shopping.mall.service.OrderService;

@Controller
public class ClientController2 {
	//private static Logger logger = Logger.getLogger(ClientController.class);
	
	@Autowired
	private ClientService clientService;
	
	@Autowired
	private OrderService  orderService;

	
	@RequestMapping("/client/hello")
    public String hello(Model model) {
        return "redirect:/client/list2";
    }
	
	@RequestMapping("/client/login")  
	@ResponseBody
    public String login(HttpServletRequest request, @RequestParam String name, @RequestParam String password) {  
          //userService.findOneByName(param.getName());

         System.out.println("name = " + name);
         ShoppingMallClient client = clientService.findOneByName(name);

         if((client != null) && client.getPassword().equals(password)) {
        	 HttpSession session = request.getSession();
 			 session.setAttribute("loginClient", client);
			 return "OK";
		 }
		 return "";
    }
	
	@RequestMapping("/client/validatename")  
	@ResponseBody
    public String validatename(HttpServletRequest request, @RequestParam String name) {  
          //userService.findOneByName(param.getName());

         System.out.println("name = " + name);
         ShoppingMallClient client = clientService.findOneByName(name);

         if(client != null){
			 return "OK";
		 }
		 return "FAIL";
    }

    @RequestMapping("/client/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<ShoppingMallClient> clients=clientService.findAll();
        model.addAttribute("clients", clients);
        return "client/list2";
    }

    @RequestMapping("/client/toOrder2")
    public String clientOrder(Model model, int id) {
    	System.out.println("Thymeleaf查询所有");
        
        model.addAttribute("orders",  orderService.findOrderListByClientId(id));
        ShoppingMallClient client = clientService.findClientById(id);
        model.addAttribute("clientName",  client.getName());
        model.addAttribute("clientPhone",  client.getTelephone());
        return "client/order2";
    }

    @RequestMapping("/client/alltoOrder2")
    public String allclientOrder(Model model) {
    	System.out.println("Thymeleaf查询所有");
        
        model.addAttribute("orders",  orderService.findAll());
        return "client/order2";
    }
    
    @RequestMapping(value = "/client/deleteClients", method = { RequestMethod.POST })
    public String deleteClients(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        List<String>  idlist = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	
        	Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlist.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	
        }
        System.out.println(idlist);
        clientService.deleteClients(idlist);
        return "redirect:/client/list2";
    }  
    
    
    
    @RequestMapping("/client/toAdd2")
    public String toAdd() {
        return "client/Add2";
    }
        
    
    @RequestMapping(value ="/client/findClientByName", method = { RequestMethod.POST })
    @ResponseBody
    public List<ShoppingMallClient> findClientByName(HttpServletRequest request, @RequestParam String name) throws Exception{  
    	List<ShoppingMallClient> clientList = new ArrayList<>();
		if(name.length() == 0) {
			clientList = clientService.findAll();
		}else {
	        //System.out.println(name);
	        clientList.add(clientService.findOneByName(name));
		}
        
        return clientList;
    }  
    
    
    @RequestMapping(value ="/client/addClient", method = { RequestMethod.POST })
    @ResponseBody
    public String addClient(HttpServletRequest request, @RequestParam String name, @RequestParam String chinesename,
    		@RequestParam String password, @RequestParam String telephone, @RequestParam String address,
    		@RequestParam String weixin, @RequestParam String qq, @RequestParam String remarks){  
       
    	ShoppingMallClient client = new ShoppingMallClient();
    	client.setName(name);
    	client.setChineseName(chinesename);
    	client.setTelephone(telephone);
    	client.setPassword(password);
    	client.setAddress(address);
    	client.setQq(qq);
    	client.setWeixin(weixin);
    	client.setRemarks(remarks);
        
        System.out.println(client);
        try {
        	clientService.addClient(client);
        	return "OK";
        }catch (Exception e) {
        	return "FAIL";
        }
    }      
    
    @RequestMapping(value ="/client/add2", method = { RequestMethod.POST })
    public String add(HttpServletRequest request, @RequestBody String idlistJson){  
        System.out.println(idlistJson);  
        
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        ShoppingMallClient client = new ShoppingMallClient();
//        for(String jsonStr: jsonStrlist) {
//        	if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("name") )){
//        		try {
//					client.setName(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//				} catch (UnsupportedEncodingException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("telephone") )){
//        		client.setTelephone(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("address") )){
//        		client.setAddress(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("weixin") )){
//        		client.setWeixin(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("qq") )){
//        		client.setQq(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("remarks") )){
//        		client.setRemarks(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}
//        	
//        }
        
        System.out.println(client);
        clientService.addClient(client);
        return "redirect:/client/list2";
    }      

    @RequestMapping("/client/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        
        ShoppingMallClient  client = clientService.findClientById(id);
        model.addAttribute("client", client);
        return "client/order2";
    }

    @RequestMapping("/client/edit2")
    public String edit(HttpServletRequest request, @RequestBody String idlistJson) throws UnsupportedEncodingException {
    	List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        ShoppingMallClient client = new ShoppingMallClient();
        for(String jsonStr: jsonStrlist) {
        	if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("id") )){
        		client.setId(Integer.valueOf(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8")));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("name") )){
        		client.setName(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
        	}
        	
        }
        System.out.println(client);
        clientService.updateClient(client);
        return "redirect:/client/list2";
    }

    @RequestMapping("/client/toDelete2")
    public String delete(int id) {
        clientService.deleteClient(id);
        return "redirect:/client/list2";
    }
}

