package com.shopping.mall.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shopping.mall.model.ProductCategory;
 
 
@Mapper
public interface ProductCategoryDao {
	
	public void save(ProductCategory productCategory);
	
	public void delete(int id);
	
	public ProductCategory findOne(int id);
	
	public List<ProductCategory> findAll();
}
