package com.shopping.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.mall.config.ImageServerProperties;
import com.shopping.mall.dao.OrderGoodsDao;
import com.shopping.mall.model.OrderGoods;
import com.shopping.mall.model.Product;
import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.service.OrderGoodsService;

@Service
public class OrderGoodsServiceImpl implements OrderGoodsService{

	@Autowired
    private OrderGoodsDao orderGoodsDao;
	
	@Autowired
	private ImageServerProperties  imageServerProperties;
	
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

	
	@Override
	public List<OrderGoods> findAll() {
		List<OrderGoods> orderGoodsList = orderGoodsDao.findAll();
		if(orderGoodsList == null) {
			 return null;
		 }
		orderGoodsList.forEach(orderGoods -> orderGoods.setPicture(imageServerProperties.getAddress() + orderGoods.getPicture()));
		return orderGoodsList;
	}

	@Override
	public List<OrderGoods> findOrderGoodsListByOrderId(long id) {
		List<OrderGoods> orderGoodsList = orderGoodsDao.findOrderGoodsListByOrderId(id);
		if(orderGoodsList == null) {
			 return null;
		 }
		orderGoodsList.forEach(orderGoods -> orderGoods.setPicture(imageServerProperties.getAddress() + orderGoods.getPicture()));
		return orderGoodsList; 
	}

	@Override
	public OrderGoods findOrderGoodsById(long orderId, int goodsId) {
		// TODO Auto-generated method stub
		OrderGoods orderGoods = orderGoodsDao.findOne(orderId, goodsId);
		
		if(orderGoods == null) {
			return null;
		}
		orderGoods.setPicture(imageServerProperties.getAddress() + orderGoods.getPicture());
		return orderGoods;
	}

	@Override
	public List<OrderGoods> findGoods(List<String> idList) {
		 List<OrderGoods> orderGoodsList = orderGoodsDao.findGoods(idList);
		 
		 if(orderGoodsList == null) {
			 return null;
		 }
		 orderGoodsList.forEach(orderGoods -> orderGoods.setPicture(imageServerProperties.getAddress() + orderGoods.getPicture()));
		 return orderGoodsList;

	}

}
