package com.shopping.mall.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.model.Product;
 
 
@Mapper
public interface OrderDao {
	
    public void save(ShoppingMallOrder order);
	
    public void add(ShoppingMallOrder order);
    
	public void delete(long id);
	
	public ShoppingMallOrder findOne(long id);
	
	public List<ShoppingMallOrder> findAll();
	
	public void deleteOrders(@Param("idList") List<String> idList);
	
	public List<ShoppingMallOrder> findOrderListByClientId(int clientId);
	
	public List<ShoppingMallOrder> findOrderListByClientName(String clientName);

	public ShoppingMallOrder findUnPayedOrderByClientId(int clientId);
}
