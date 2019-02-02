package com.shopping.mall.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shopping.mall.model.Brand;
 
 
@Mapper
public interface BrandDao {
	
	public void save(Brand Brand);
	
	public void delete(int id);
	
	public Brand findOne(int id);
	
	public List<Brand> findAll();
}
