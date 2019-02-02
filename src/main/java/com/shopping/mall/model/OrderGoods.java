package com.shopping.mall.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class OrderGoods  implements Serializable{
	private static final long serialVersionUID = 8144897400964354476L;
	
	private long orderId;
	private int  goodsId;
	private int  goodsNumber;
	private BigDecimal price;
	private BigDecimal goodsFee;
	private String picture;
	private BigDecimal totalFee;
	private String remarks;
	private String goodsName;
	
	public long getOrderId() {
		return orderId;
	}
	public void setOrderId(long orderId) {
		this.orderId = orderId;
	}
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public int getGoodsNumber() {
		return goodsNumber;
	}
	public void setGoodsNumber(int goodsNumber) {
		this.goodsNumber = goodsNumber;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public BigDecimal getGoodsFee() {
		return goodsFee;
	}
	public void setGoodsFee(BigDecimal goodsFee) {
		this.goodsFee = goodsFee;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}

	public BigDecimal getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(BigDecimal totalFee) {
		this.totalFee = totalFee;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	
}
