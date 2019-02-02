package com.shopping.mall.controller;


import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.shopping.mall.model.OrderGoods;
import com.shopping.mall.model.ShoppingMallClient;
import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.service.ClientService;
import com.shopping.mall.service.OrderGoodsService;
import com.shopping.mall.service.OrderService;

@Controller
public class OrderController2 {
	//private static Logger logger = Logger.getLogger(OrderController.class);
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ClientService clientService;
	
	@Autowired
	private OrderGoodsService orderGoodsService;
	
	@RequestMapping("/order/hello")
    public String hello(Model model) {
        return "redirect:/order/list2";
    }
	
    @RequestMapping("/order/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<ShoppingMallOrder> orders=orderService.findAll();
        model.addAttribute("orders", orders);
        return "order/list2";
    } 
    
    @RequestMapping("/order/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "order/Add2";
    }
        
    
    @RequestMapping(value ="/order/getOrderListByClientName", method = { RequestMethod.POST })
    @ResponseBody
    public List<ShoppingMallOrder> getOrderListByClientName(HttpServletRequest request, @RequestParam String clientName) throws Exception{  
    	if((clientName == null) || (clientName.trim().length() == 0)) {
    		return orderService.findAll();
    	}
        
        return  orderService.findOrderListByClientName(clientName);
    } 
    
    
    @RequestMapping(value ="/order/add2", method = { RequestMethod.POST })
    public String add(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        ShoppingMallOrder order = new ShoppingMallOrder();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(order);
        orderService.addOrder(order);
        return "redirect:/order/list2";
    }      
    
    @RequestMapping(value ="/order/create2", method = { RequestMethod.POST })
    public String create2(HttpServletRequest request, @RequestParam String id) throws Exception{  
        
    	ShoppingMallClient client = clientService.findClientById(Integer.valueOf(id));
    	
    	ShoppingMallOrder order = new ShoppingMallOrder();
    	order.setId(System.currentTimeMillis());
    	order.setClientId(client.getId());
    	order.setClientName(client.getName());
    	
    	String createTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(System.currentTimeMillis());
    	order.setCreateTime(createTime);
    	order.setReceiverMobile(client.getTelephone());
    	order.setConsignTime("未发货");
    	order.setPaymentTime("未付款");
    	order.setReceiverAreaName(client.getAddress());
    	orderService.addOrder(order);
        return "redirect:/order/list2";
    }      
    
    @RequestMapping(value = "/order/deleteOrders", method = { RequestMethod.POST })
    @ResponseBody
    public String deleteClients(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        List<String>  idlist = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	
        	//Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlist.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	
        }
        System.out.println(idlist);
        orderService.deleteOrders(idlist);
        return "ok";
    }
    
    

    @RequestMapping("/order/toEdit2")
    public String toEdit(HttpServletRequest request, Model model,Long id) {
    	System.out.println("开始编辑");
        
        ShoppingMallOrder  order = orderService.findOrderById(id);
        model.addAttribute("order", order);
        
        List<OrderGoods>   orderGoodsList = orderGoodsService.findOrderGoodsListByOrderId(id);
        model.addAttribute("ordergoods", orderGoodsList);
        
        request.getSession().setAttribute("clientorder", order);
        return "order/Edit2";
    }
    
    @RequestMapping(value ="/order/getOrderById", method = { RequestMethod.POST })
    @ResponseBody
    public List<ShoppingMallOrder> getOrderById(HttpServletRequest request, @RequestParam String id) throws Exception{  
        if((id == null) || (id.trim().length() == 0)) {
        	return orderService.findAll();
        }
    	
    	List<ShoppingMallOrder> orderList = new ArrayList<>();
    	ShoppingMallOrder order = orderService.findOrderById(Long.valueOf(id));
    	orderList.add(order);
        return orderList;
    } 
    
    

    @RequestMapping("/order/edit2")
    public String edit(HttpServletRequest request, @RequestBody String idlistJson) throws UnsupportedEncodingException {
    	List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        ShoppingMallOrder order = new ShoppingMallOrder();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(order);
        orderService.updateOrder(order);
        return "redirect:/order/list2";
    }

    @RequestMapping("/order/toDelete2")
    public String delete(int id) {
        orderService.deleteOrder(id);
        return "redirect:/order/list2";
    }
}

