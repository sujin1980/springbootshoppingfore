package com.shopping.mall.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shopping.mall.model.Brand;
import com.shopping.mall.service.BrandService;

@Controller
public class BrandController {
	//private static Logger logger = Logger.getLogger(BrandController.class);
	@Autowired
	private BrandService brandService;

	
	@RequestMapping("/brand/")
    public String index() {
        return "redirect:/brand/list";
    }

    @RequestMapping("/brand/list")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<Brand> brands=brandService.findAll();
        model.addAttribute("Brands", brands);
        return "templates/Brand/list";
    }

    @RequestMapping("/brand/toAdd")
    public String toAdd() {
        return "templates/Brand/BrandAdd";
    }

    @RequestMapping("/brand/add")
    public String add(Brand brand) {
        brandService.addBrand(brand);
        return "redirect:/brand/list";
    }

    @RequestMapping("/brand/toEdit")
    public String toEdit(Model model,int id) {
        Brand brand=brandService.findBrandById(id);
        model.addAttribute("Brand", brand);
        return "templates/Brand/BrandEdit";
    }

    @RequestMapping("/brand/edit")
    public String edit(Brand brand) {
        brandService.updateBrand(brand);
        return "redirect:/brand/list";
    }


    @RequestMapping("/brand/toDelete")
    public String delete(int id) {
        brandService.deleteBrand(id);
        return "redirect:/brand/list";
    }

}

