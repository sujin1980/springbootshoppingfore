package com.shopping.mall.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.shopping.mall.model.ProductType;
import com.shopping.mall.service.ProductTypeService;

@Controller
public class ProductTypeController {
	//private static Logger logger = Logger.getLogger(ProductTypeController.class);
	
	@Autowired
	private ProductTypeService productTypeService;
	
	@RequestMapping("/producttype/hello")
    public String hello() {
        return "templates/producttype/hello";
    }
	
	@RequestMapping("/producttype/")
    public String index() {
        return "redirect:/producttype/list";
    }
	
	
    @RequestMapping("/producttype/list")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<ProductType> productTypes=productTypeService.findAll();
        model.addAttribute("producttypes", productTypes);
        return "templates/producttype/list";
    }

    @RequestMapping("/producttype/toAdd")
    public String toAdd() {
        return "templates/producttype/producttypeAdd";
    }

    @RequestMapping("/producttype/add")
    public String add(ProductType productType) {
        productTypeService.addProductType(productType);
        return "redirect:/producttype/list";
    }

    @RequestMapping("/producttype/toEdit")
    public String toEdit(Model model,int id) {
        ProductType productType=productTypeService.findProductTypeById(id);
        model.addAttribute("producttype", productType);
        return "templates/producttype/producttypeEdit";
    }

    @RequestMapping("/producttype/edit")
    public String edit(ProductType productType) {
        productTypeService.updateProductType(productType);
        return "redirect:/producttype/list";
    }


    @RequestMapping("/producttype/toDelete")
    public String delete(int id) {
        productTypeService.deleteProductType(id);
        return "redirect:/producttype/list";
    }
}

