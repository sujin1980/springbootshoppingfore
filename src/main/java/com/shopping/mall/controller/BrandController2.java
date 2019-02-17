package com.shopping.mall.controller;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.shopping.mall.model.Brand;
import com.shopping.mall.service.BrandService;

@Controller
public class BrandController2 {
	private static Logger LOGGER = LoggerFactory.getLogger(AlipayWAPPayController.class);
	
	@Autowired
	private BrandService brandService;
	
    @RequestMapping("/brand/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<Brand> brands=brandService.findAll();
        model.addAttribute("brands", brands);
        return "jsp/brand/list2";
    }


    @RequestMapping("/brand/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "jsp/brand/Add2";
    }

    @RequestMapping("/brand/add2")
    public String add(Brand brand) {
    	System.out.println("开始添加");
        brandService.addBrand(brand);
        return "redirect:/brand/list2";
    }

    @RequestMapping("/brand/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        Brand brand=brandService.findBrandById(id);
        model.addAttribute("brand", brand);
        return "jsp/brand/Edit2";
    }

    @RequestMapping("/brand/edit2")
    public String edit(Brand brand) {
        brandService.updateBrand(brand);
        return "redirect:/brand/list2";
    }

    @RequestMapping("/brand/toDelete2")
    public String delete(int id) {
        brandService.deleteBrand(id);
        return "redirect:/brand/list2";
    }
}

