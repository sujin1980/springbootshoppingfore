package com.shopping.mall.service;

import java.util.List;

import com.shopping.mall.model.ShoppingMallClient;

public interface ClientService {
	/**
	 * 新增用户
	 * @param ShoppingMallClient
	 * @return
	 */
	boolean addClient(ShoppingMallClient client);
	
	/**
	 * 修改用户
	 * @param ShoppingMallClient
	 * @return
	 */
	boolean updateClient(ShoppingMallClient client);
	
	
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	boolean deleteClient(int id);
	
	/**
     * 根据用户名字查询用户信息
     * @param ClientName
     */
	ShoppingMallClient findClientById(int id);
    /**
     * 查询所有
     * @return
     */
	List<ShoppingMallClient> findAll();
	
	
	ShoppingMallClient findOneByName(String name);
	
	boolean deleteClients(List<String> listid);
}
