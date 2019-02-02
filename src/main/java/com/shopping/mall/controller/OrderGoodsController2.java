package com.shopping.mall.controller;


import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.shopping.mall.model.ProductCategory;
import com.shopping.mall.model.ShoppingMallClient;
import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.model.OrderGoods;
import com.shopping.mall.model.Product;
import com.shopping.mall.service.OrderGoodsService;
import com.shopping.mall.service.ProductService;

@Controller
public class OrderGoodsController2 {
	//private static Logger logger = Logger.getLogger(OrderGoodsController.class);
	
	@Autowired
	private OrderGoodsService orderGoodsService;
	
	@Autowired
	private ProductService productService;
	
    @RequestMapping("/ordergoods/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<OrderGoods> orderGoodss=orderGoodsService.findAll();
        model.addAttribute("ordergoodss", orderGoodss);	
        return "jsp/ordergoods/list2";
    }


    @RequestMapping("/ordergoods/toAdd2")
    public String toAdd(HttpServletRequest request,int id) {
    	System.out.println("开始添加1");

        ShoppingMallOrder order =(ShoppingMallOrder) request.getSession().getAttribute("clientorder");     
        OrderGoods  orderGoods = orderGoodsService.findOrderGoodsById(order.getId(), id);
    	if(orderGoods != null) {
    		orderGoods.setGoodsNumber(orderGoods.getGoodsNumber() + 1);
    		orderGoods.setGoodsFee(orderGoods.getPrice().multiply(new BigDecimal(orderGoods.getGoodsNumber())));
    		orderGoodsService.updateOrderGoods(orderGoods);
    	}
    	 
    	Product product = productService.findProductById(id);
  
    	OrderGoods  orderGoods2 = new OrderGoods();
    	orderGoods2.setOrderId(order.getId());
    	orderGoods2.setGoodsId(product.getId());
    	orderGoods2.setGoodsName(product.getName());
    	orderGoods2.setGoodsNumber(1);
    	orderGoods2.setPrice(product.getPrice());
    	orderGoods2.setPicture(product.getIcon());
    	orderGoods2.setGoodsFee(product.getPrice());
    	
    	orderGoodsService.addOrderGoods(orderGoods2);
        return "redirect:/product/list2";
    }

    @RequestMapping(value ="/ordergoods/decGoodsNumber", method = { RequestMethod.POST })
    @ResponseBody
    public List<OrderGoods> decGoodsNumber(HttpServletRequest request, 
    		@RequestParam String orderid, @RequestParam String goodsid, @RequestParam String number){  
      
        
    	System.out.println("开始添加1");

    	int goodsnum = Integer.valueOf(number);
    	int goodsId = Integer.valueOf(goodsid);
    	long orderId = Long.valueOf(orderid);
    	
    	OrderGoods orderGoods = orderGoodsService.findOrderGoodsById(orderId, goodsId);
    	orderGoods.setGoodsNumber(orderGoods.getGoodsNumber() + goodsnum);
    	orderGoods.setGoodsFee(orderGoods.getPrice().multiply(new BigDecimal(orderGoods.getGoodsNumber())));
    	
    	if(orderGoods.getGoodsNumber() == 0) {
    		orderGoodsService.deleteOrderGoods(orderId, goodsId);
    	}else {
    		orderGoodsService.updateOrderGoods(orderGoods);
    	}
        return orderGoodsService.findOrderGoodsListByOrderId(orderId);
    } 
    
    @RequestMapping(value ="/ordergoods/modifyGoodsNumber", method = { RequestMethod.POST })
    @ResponseBody
    public List<OrderGoods> modifyGoodsNumber(HttpServletRequest request, 
    		@RequestParam String orderid, @RequestParam String goodsid, @RequestParam String number) throws Exception{  
     
    	System.out.println("开始修改======");

    	int goodsnum = Integer.valueOf(number);
    	int goodsId = Integer.valueOf(goodsid);
    	long orderId = Long.valueOf(orderid);
    	
    	OrderGoods orderGoods = orderGoodsService.findOrderGoodsById(orderId, goodsId);
    	orderGoods.setGoodsNumber(orderGoods.getGoodsNumber() + goodsnum);
    	orderGoods.setGoodsFee(orderGoods.getPrice().multiply(new BigDecimal(orderGoods.getGoodsNumber())));
    	
    	if(orderGoods.getGoodsNumber() == 0) {
    		orderGoodsService.deleteOrderGoods(orderId, goodsId);
    	}else {
    		orderGoodsService.updateOrderGoods(orderGoods);
    	}
        return orderGoodsService.findOrderGoodsListByOrderId(orderId);
    }
    
    
    
    
    @RequestMapping("/ordergoods/add2")
    public String add(OrderGoods orderGoods) {
    	System.out.println("开始添加");
        orderGoodsService.addOrderGoods(orderGoods);
        return "redirect:/ordergoods/list2";
    }

    @RequestMapping("/ordergoods/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        OrderGoods ordergoods=null;//orderGoodsService.findOrderGoodsById(id);
        model.addAttribute("ordergoods", ordergoods);
        return "jsp/ordergoods/Edit2";
    }

    @RequestMapping("/ordergoods/edit2")
    public String edit(OrderGoods orderGoods) {
        orderGoodsService.updateOrderGoods(orderGoods);
        return "redirect:/ordergoods/list2";
    }

    @RequestMapping("/ordergoods/toDelete2")
    public String delete(int id) {
        orderGoodsService.deleteOrderGoods(0, id);
        return "redirect:/ordergoods/list2";
    }
    
    @RequestMapping(value = "/ordergoods/getTypeListByCategoryId", method = { RequestMethod.POST })
    @ResponseBody
    public List<OrderGoods>  getTypeListByCategoryId(HttpServletRequest request, @RequestBody String str){
    	String strid = str.substring(0, str.indexOf("="));
    	
    	List<OrderGoods> orderGoodsList = orderGoodsService.findOrderGoodsListByOrderId(Integer.valueOf(strid));  
    	//request.get
    	return  orderGoodsList;
    }  
    
    
    @RequestMapping(value = "/ordergoods/getTypeListByCategoryStrId", method = { RequestMethod.POST })
    @ResponseBody
    public List<OrderGoods>  getTypeListByCategoryStrId(HttpServletRequest request, @RequestBody String str){
    	String strid = str.substring(str.indexOf("=") + 1, str.length());
    	int id = Integer.valueOf(strid);
 
    	List<OrderGoods> orderGoodsList = orderGoodsService.findOrderGoodsListByOrderId(id);    	
    	return  orderGoodsList;
    }  
    
}

