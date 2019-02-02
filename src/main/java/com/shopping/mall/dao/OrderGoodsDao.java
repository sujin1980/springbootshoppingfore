package com.shopping.mall.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.mall.model.OrderGoods;
 
 
@Mapper
public interface OrderGoodsDao {
	
	public void add(OrderGoods orderGoods);
	
    public void save(OrderGoods orderGoods);
	
	public void delete(@Param("orderId") long orderId, @Param("goodsId")int goodsId);
	
	public OrderGoods findOne(@Param("orderId")long orderId, @Param("goodsId")int goodsId);
	
	public List<OrderGoods> findAll();
	
	public List<OrderGoods> findOrderGoodsListByOrderId(Long id);
}
