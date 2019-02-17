package com.shopping.mall.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import com.shopping.mall.config.ImageServerProperties;
import com.shopping.mall.model.OrderGoods;
import com.shopping.mall.model.Product;
import com.shopping.mall.model.ProductCategory;
import com.shopping.mall.model.ProductType;
import com.shopping.mall.model.ShoppingMallClient;
import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.service.OrderGoodsService;
import com.shopping.mall.service.OrderService;
import com.shopping.mall.service.ProductService;
import com.shopping.mall.service.ProductTypeService;

@Controller
public class ProductController2 {
	private static Logger LOGGER = LoggerFactory.getLogger(AlipayWAPPayController.class);
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ProductTypeService productTypeService;
	
	@Autowired
	private OrderGoodsService orderGoodsService;
	
	@Autowired
	private OrderService orderService;
	
	@RequestMapping("/product/hello")
    public String hello(Model model) {
        return "redirect:/product/list2";
    }
	

    @RequestMapping("/product/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<Product> products=productService.findAll();
        model.addAttribute("products", products);
        return "product/list2";
    }


    @RequestMapping(value = "/product/deleteProducts", method = { RequestMethod.POST })
    public String deleteProducts(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        List<String>  idlist = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	
        	Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlist.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	
        }
        System.out.println(idlist);
        productService.deleteProducts(idlist);
        return "redirect:/product/list2";
    }  
    
    @RequestMapping(value = "/product/getproductbyname", method = { RequestMethod.POST })
    @ResponseBody
    public List<Product> getproductbyname(HttpServletRequest request, @RequestParam String name){  
        String productName;
       
		try {
			productName = URLDecoder.decode(name, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
        

        List<Product> productList = new ArrayList<>();
		if(productName.length() == 0) {
			productList = productService.findAll();
		}else {
	        System.out.println(productName);
	        productList = productService.findByName(productName);
		}
        //model.addAttribute("products", productList);
        return productList;
    } 
    
   
    
    @RequestMapping(value = "/product/buyNow", method = { RequestMethod.POST })
    @ResponseBody
    public String  buyNow(HttpServletRequest request, @RequestParam String goodsid){
    	
    	ShoppingMallClient client = (ShoppingMallClient)request.getSession().getAttribute("loginClient");
    	if(client == null) {
    		request.getSession().setAttribute("addgoods", goodsid);
    		LOGGER.info("用户没有登录");
    		return "NOLOGIN";
    	}else {
        	ShoppingMallOrder order = orderService.findUnPayedOrderByClientId(client.getId());
        	if(order == null) {
        		LOGGER.info("用户还没有订单");
        		return "NOORDER";
        	}
        	Product  product = productService.findProductById(Integer.valueOf(goodsid));
        	
        	OrderGoods orderGoods = orderGoodsService.findOrderGoodsById(order.getId(), product.getId());
        	
        	System.out.println("order id = " + order.getId() + ", product id = " + product.getId() + "======================");
        	if(orderGoods == null) {
        		orderGoodsService.addGoodsToOrder(order, product);
        	}else {
        		orderGoods.setGoodsNumber(orderGoods.getGoodsNumber() + 1);
        		orderGoodsService.updateOrderGoods(orderGoods);
        	}
        	return "OK";
    	}
    } 
    
    
    @RequestMapping("/product/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "product/Add2";
    }
        
    
    @RequestMapping(value ="/product/add2", method = { RequestMethod.POST })
    public String add(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        Product product = new Product();
        for(String jsonStr: jsonStrlist) {
        	if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("name") )){
        		product.setName(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("price") )){
        		product.setPrice(new BigDecimal(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length())));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("remarks") )){
        		product.setRemarks(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("icon") )){
        		product.setIcon(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("typeid") )){
        		ProductType productType = productTypeService.findProductTypeById(Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length())));
        		product.setProductType(productType);
        		product.setTypeid(productType.getId());
        	}
        	
        }
        System.out.println(product);
        productService.addProduct(product);
        return "redirect:/product/list2";
    }      

    @RequestMapping("/product/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        
        Product  product = productService.findProductById(id);
        model.addAttribute("product", product);
        return "product/Edit2";
    }

    @RequestMapping("/product/edit2")
    public String edit(HttpServletRequest request, @RequestBody String idlistJson) throws UnsupportedEncodingException {
    	List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        Product product = new Product();
        for(String jsonStr: jsonStrlist) {
        	if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("id") )){
        		product.setId(Integer.valueOf(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8")));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("name") )){
        		product.setName(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("price") )){
        		product.setPrice(new BigDecimal(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length())));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("remarks") )){
        		product.setRemarks(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("icon") )){
        		product.setIcon(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("typeid") )){
        		ProductType productType = productTypeService.findProductTypeById(Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length())));
        		product.setProductType(productType);
        		product.setTypeid(productType.getId());
        	}
        	
        }
        System.out.println(product);
        productService.updateProduct(product);
        return "redirect:/product/list2";
    }

    @RequestMapping("/product/toDelete2")
    public String delete(int id) {
        productService.deleteProduct(id);
        return "redirect:/product/list2";
    }
}

