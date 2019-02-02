package com.shopping.mall.controller;


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
import com.shopping.mall.model.ProductType;
import com.shopping.mall.service.ProductService;
import com.shopping.mall.service.ProductTypeService;

@Controller
public class ProductTypeController2 {
	//private static Logger logger = Logger.getLogger(ProductTypeController.class);
	
	@Autowired
	private ProductTypeService productTypeService;
	
	@Autowired
	private ProductService productService;
	
    @RequestMapping("/producttype/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<ProductType> productTypes=productTypeService.findAll();
        model.addAttribute("producttypes", productTypes);	
        return "jsp/producttype/list2";
    }


    @RequestMapping("/producttype/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "jsp/producttype/Add2";
    }

    @RequestMapping("/producttype/add2")
    public String add(ProductType productType) {
    	System.out.println("开始添加");
        productTypeService.addProductType(productType);
        return "redirect:/producttype/list2";
    }

    @RequestMapping("/producttype/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        ProductType producttype=productTypeService.findProductTypeById(id);
        model.addAttribute("producttype", producttype);
        return "jsp/producttype/Edit2";
    }

    @RequestMapping("/producttype/edit2")
    public String edit(ProductType productType) {
        productTypeService.updateProductType(productType);
        return "redirect:/producttype/list2";
    }

    @RequestMapping("/producttype/toDelete2")
    public String delete(int id) {
        productTypeService.deleteProductType(id);
        return "redirect:/producttype/list2";
    }
    
    @RequestMapping(value = "/producttype/getTypeListByCategoryId", method = { RequestMethod.POST })
    @ResponseBody
    public List<ProductType>  getTypeListByCategoryId(HttpServletRequest request, @RequestBody String str){
    	String strid = str.substring(0, str.indexOf("="));
    	
    	List<ProductType> productTypeList = productTypeService.findProductTypeListByCategoryId(Integer.valueOf(strid));  
    	//request.get
    	return  productTypeList;
    }  
    
    @RequestMapping(value = "/producttype/getTypeListByCategoryName", method = { RequestMethod.POST })
    @ResponseBody
    public List<ProductType>  getTypeListByCategoryName(HttpServletRequest request, @RequestParam String name){

    	System.out.println("name = " + name.trim());
    	
    	List<ProductType> productTypeList = productTypeService.findProductTypeListByCategoryName(name.trim());  
    	
    	for(ProductType productType: productTypeList) {
    		productType.setProductList(productService.findProductListByTypeId(productType.getId()));
    	}
    	
    	return  productTypeList;
    } 
    
    
    @RequestMapping(value = "/producttype/getTypeListByCategoryStrId", method = { RequestMethod.POST })
    @ResponseBody
    public List<ProductType>  getTypeListByCategoryStrId(HttpServletRequest request, @RequestBody String str){
    	String strid = str.substring(str.indexOf("=") + 1, str.length());
    	int id = Integer.valueOf(strid);
 
    	List<ProductType> productTypeList = productTypeService.findProductTypeListByCategoryId(id);    	
    	return  productTypeList;
    }  
    
}

