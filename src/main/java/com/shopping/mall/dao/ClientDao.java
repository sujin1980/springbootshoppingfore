package com.shopping.mall.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.mall.model.ShoppingMallClient;
 
 
@Mapper
public interface ClientDao {
	
    public void save(ShoppingMallClient product);
	
    public void add(ShoppingMallClient product);
    
	public void delete(int id);
	
	public ShoppingMallClient findOne(int id);
	
	public ShoppingMallClient findOneByName(String name);
	
	public List<ShoppingMallClient> findAll();
	
	public void deleteClients(@Param("idList") List<String> idList);
}
