package com.shopping.mall.service;

import java.util.List;
import com.shopping.mall.model.OrderGoods;

public interface OrderGoodsService {

	boolean addOrderGoods(OrderGoods orderGoods);

	boolean updateOrderGoods(OrderGoods orderGoods);
	
	boolean deleteOrderGoods(long orderId, int goodsId);
	
	OrderGoods findOrderGoodsById(long orderId, int productId);

	List<OrderGoods> findOrderGoodsListByOrderId(long id);
	
	List<OrderGoods> findAll();
}
