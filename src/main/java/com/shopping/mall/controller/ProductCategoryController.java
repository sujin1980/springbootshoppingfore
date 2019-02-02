package com.shopping.mall.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.shopping.mall.model.ProductCategory;
import com.shopping.mall.service.ProductCategoryService;

@Controller
public class ProductCategoryController {
	//private static Logger logger = Logger.getLogger(ProductCategoryController.class);
	
	@Autowired
	private ProductCategoryService productCategoryService;


	@RequestMapping("/productcategory/hello")
    public String hello() {
        return "templates/productcategory/hello";
    }
	
	
	@RequestMapping("/productcategory/")
    public String index() {
        return "redirect:/productcategory/list";
    }
	
	
    @RequestMapping("/productcategory/list")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<ProductCategory> productCategorys=productCategoryService.findAll();
        model.addAttribute("productcategorys", productCategorys);
        return "templates/productcategory/list";
    }


    @RequestMapping("/productcategory/toAdd")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "templates/productcategory/productcategoryAdd";
    }

    @RequestMapping("/productcategory/add")
    public String add(ProductCategory productCategory) {
    	System.out.println("开始添加");
        productCategoryService.addProductCategory(productCategory);
        return "redirect:/productcategory/list";
    }

    @RequestMapping("/productcategory/toEdit")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        ProductCategory productcategory=productCategoryService.findProductCategoryById(id);
        model.addAttribute("productcategory", productcategory);
        return "templates/productcategory/productcategoryEdit";
    }

    @RequestMapping("/productcategory/edit")
    public String edit(ProductCategory productCategory) {
        productCategoryService.updateProductCategory(productCategory);
        return "redirect:/productcategory/list";
    }


    @RequestMapping("/productcategory/toDelete")
    public String delete(int id) {
        productCategoryService.deleteProductCategory(id);
        return "redirect:/productcategory/list";
    }
}

