package com.shopping.mall.service;

import java.util.List;

import com.shopping.mall.model.Product;

public interface ProductService {
	/**
	 * 新增用户
	 * @param Product
	 * @return
	 */
	boolean addProduct(Product product);
	
	/**
	 * 修改用户
	 * @param Product
	 * @return
	 */
	boolean updateProduct(Product product);
	
	
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	boolean deleteProduct(int id);
	
	/**
     * 根据用户名字查询用户信息
     * @param ProductName
     */
	Product findProductById(int id);
	
	List<Product>  findByName(String name);
	
	List<Product> findProductListByTypeId(int id);
    /**
     * 查询所有
     * @return
     */
	List<Product> findAll();
	
	
	boolean deleteProducts(List<String> listid);
}
