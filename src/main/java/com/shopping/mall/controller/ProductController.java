package com.shopping.mall.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.shopping.mall.model.Product;
import com.shopping.mall.service.ProductService;

@Controller
public class ProductController {
	//private static Logger logger = Logger.getLogger(ProductController.class);
	
	@Autowired
	private ProductService productService;

	
	@RequestMapping("/product/")
    public String index() {
        return "redirect:/product/list";
    }
	
	
    @RequestMapping("/product/list")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<Product> Products=productService.findAll();
        model.addAttribute("Products", Products);
        return "templates/Product/list";
    }

    @RequestMapping("/product/toAdd")
    public String toAdd() {
        return "templates/Product/ProductAdd";
    }

    @RequestMapping("/product/add")
    public String add(Product product) {
        productService.addProduct(product);
        return "redirect:/product/list";
    }

    @RequestMapping("/product/toEdit")
    public String toEdit(Model model,int id) {
        Product product=productService.findProductById(id);
        model.addAttribute("Product", product);
        return "templates/Product/ProductEdit";
    }

    @RequestMapping("/product/edit")
    public String edit(Product product) {
        productService.updateProduct(product);
        return "redirect:/product/list";
    }


    @RequestMapping("/product/toDelete")
    public String delete(int id) {
        productService.deleteProduct(id);
        return "redirect:/product/list";
    }
}

