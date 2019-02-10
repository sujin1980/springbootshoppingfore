package com.shopping.mall.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shopping.mall.dao.OrderDao;
import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.service.OrderService;

 
@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
    private OrderDao orderDao;
	
	@Override
	public boolean addOrder(ShoppingMallOrder order) {
		boolean flag=false;
		try{
			orderDao.add(order);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateOrder(ShoppingMallOrder order) {
		boolean flag=false;
		try{
			orderDao.save(order);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteOrder(long id) {
		boolean flag=false;
		try{
			orderDao.delete(id);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public ShoppingMallOrder findOrderById(long id) {
		return orderDao.findOne(id);
	}

	@Override
	public List<ShoppingMallOrder> findAll() {
		return orderDao.findAll();
		
	}

	@Override
	public boolean deleteOrders(List<String> listid) {
		orderDao.deleteOrders(listid);
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<ShoppingMallOrder> findOrderListByClientId(int clientId) {
		// TODO Auto-generated method stub
		return orderDao.findOrderListByClientId(clientId);
	}

	@Override
	public List<ShoppingMallOrder> findOrderListByClientName(String clientName) {
		// TODO Auto-generated method stub
		return orderDao.findOrderListByClientName(clientName);
	}

	@Override
	public ShoppingMallOrder findUnPayedOrderByClientId(int clientId) {
		// TODO Auto-generated method stub
		return orderDao.findUnPayedOrderByClientId(clientId);
	}

	@Override
	public List<ShoppingMallOrder> findUnPayedOrderByClientName(String clientName) {
		// TODO Auto-generated method stub
		return orderDao.findUnPayedOrderByClientName(clientName);
	}


}
