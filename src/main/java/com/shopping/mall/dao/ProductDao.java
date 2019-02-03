package com.shopping.mall.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.mall.model.Product;
import com.shopping.mall.model.ProductCategory;
 
 
@Mapper
public interface ProductDao {
	
    public void save(Product product);
	
    public void add(Product product);
    
	public void delete(int id);
	
	public Product findOne(int id);
	
	public List<Product> findByName(String name);
	
	public List<Product> findAll();
	
	public void deleteProducts(@Param("idList") List<String> idList);
	
	public List<Product> findProductListByTypeId(int typeid);
}
