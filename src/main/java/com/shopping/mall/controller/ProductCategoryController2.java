package com.shopping.mall.controller;


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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.shopping.mall.model.ProductCategory;
import com.shopping.mall.model.ProductType;
import com.shopping.mall.service.ProductCategoryService;

@Controller
public class ProductCategoryController2 {
	private static Logger LOGGER = LoggerFactory.getLogger(AlipayWAPPayController.class);
	
	@Autowired
	private ProductCategoryService productCategoryService;
	
    @RequestMapping("/productcategory/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<ProductCategory> productCategorys=productCategoryService.findAll();
        model.addAttribute("productcategorys", productCategorys);
        return "jsp/productcategory/list2";
    }


    @RequestMapping("/productcategory/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "jsp/productcategory/Add2";
    }

    @RequestMapping("/productcategory/add2")
    public String add(ProductCategory productCategory) {
    	System.out.println("开始添加");
        productCategoryService.addProductCategory(productCategory);
        return "redirect:/productcategory/list2";
    }

    @RequestMapping("/productcategory/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        ProductCategory productcategory=productCategoryService.findProductCategoryById(id);
        model.addAttribute("productcategory", productcategory);
        return "jsp/productcategory/Edit2";
    }

    
    

    
    @RequestMapping("/productcategory/edit2")
    public String edit(ProductCategory productCategory) {
        productCategoryService.updateProductCategory(productCategory);
        return "redirect:/productcategory/list2";
    }

    @RequestMapping("/productcategory/toDelete2")
    public String delete(int id) {
        productCategoryService.deleteProductCategory(id);
        return "redirect:/productcategory/list2";
    }
}

