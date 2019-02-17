package com.shopping.mall.config;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
 
/**
 * 书属性
 *
 * Created by bysocket on 27/09/2017.
 */
@Component
public class ImageServerProperties {
 
    /**
     * 书名
     */
    @Value("${image.server.address}")
    private String address;

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
 
   
}
