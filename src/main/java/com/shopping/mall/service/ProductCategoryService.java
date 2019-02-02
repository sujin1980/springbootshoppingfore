package com.shopping.mall.service;

import java.util.List;

import com.shopping.mall.model.ProductCategory;
import com.shopping.mall.model.ProductType;

public interface ProductCategoryService {

	boolean addProductCategory(ProductCategory productCategory);
	
	boolean updateProductCategory(ProductCategory productCategory);
	
	boolean deleteProductCategory(int id);
	
	ProductCategory findProductCategoryById(int id);
 
	List<ProductCategory> findAll();
}
