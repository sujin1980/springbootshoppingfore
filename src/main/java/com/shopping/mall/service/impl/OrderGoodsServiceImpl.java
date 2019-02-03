package com.shopping.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.mall.dao.OrderGoodsDao;
import com.shopping.mall.model.OrderGoods;
import com.shopping.mall.model.Product;
import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.service.OrderGoodsService;

@Service
public class OrderGoodsServiceImpl implements OrderGoodsService{

	@Autowired
    private OrderGoodsDao orderGoodsDao;
	
	@Override
	public boolean addOrderGoods(OrderGoods orderGoods) {
		boolean flag=false;
		try{
			orderGoodsDao.add(orderGoods);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateOrderGoods(OrderGoods orderGoods) {
		boolean flag=false;
		try{
			orderGoodsDao.save(orderGoods);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteOrderGoods(long orderId, int goodsId) {
		boolean flag=false;
		try{
			orderGoodsDao.delete(orderId, goodsId);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public List<OrderGoods> findAll() {
		return orderGoodsDao.findAll();
	}

	@Override
	public List<OrderGoods> findOrderGoodsListByOrderId(long id) {
		// TODO Auto-generated method stub
		return orderGoodsDao.findOrderGoodsListByOrderId(id);
	}

	@Override
	public OrderGoods findOrderGoodsById(long orderId, int goodsId) {
		// TODO Auto-generated method stub
		return orderGoodsDao.findOne(orderId, goodsId);
	}

	@Override
	public boolean addGoodsToOrder(ShoppingMallOrder order, Product product) {
		boolean flag=false;
		try{  
			OrderGoods  orderGoods = new OrderGoods();
			orderGoods.setOrderId(order.getId());
			orderGoods.setGoodsId(product.getId());
			orderGoods.setGoodsName(product.getName());
			orderGoods.setGoodsNumber(1);
			orderGoods.setPrice(product.getPrice());
			orderGoods.setPicture(product.getIcon());
			orderGoods.setGoodsFee(product.getPrice());
			
			orderGoodsDao.add(orderGoods);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

}
