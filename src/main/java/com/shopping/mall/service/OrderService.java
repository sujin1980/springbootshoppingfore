package com.shopping.mall.service;

import java.util.List;

import com.shopping.mall.model.ShoppingMallOrder;

public interface OrderService {
	/**
	 * 新增用户
	 * @param ShoppingMallOrder
	 * @return
	 */
	boolean addOrder(ShoppingMallOrder order);
	
	/**
	 * 修改用户
	 * @param ShoppingMallOrder
	 * @return
	 */
	boolean updateOrder(ShoppingMallOrder order);
	
	
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	boolean deleteOrder(long id);
	
	/**
     * 根据用户名字查询用户信息
     * @param OrderName
     */
	ShoppingMallOrder findOrderById(long id);
    /**
     * 查询所有
     * @return
     */
	List<ShoppingMallOrder> findAll();
	
	
	boolean deleteOrders(List<String> listid);
	
	List<ShoppingMallOrder> findOrderListByClientId(int clientId);

	List<ShoppingMallOrder> findOrderListByClientName(String clientName);
	
	ShoppingMallOrder findUnPayedOrderByClientId(int clientId);
}
