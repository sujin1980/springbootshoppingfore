package com.shopping.mall.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.mall.config.ImageServerProperties;
import com.shopping.mall.dao.ProductDao;
import com.shopping.mall.model.Product;
import com.shopping.mall.service.ProductService;

 
@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
    private ProductDao productDao;
	
	@Autowired
	private ImageServerProperties  imageServerProperties;
	
	@Override
	public boolean addProduct(Product product) {
		boolean flag=false;
		try{
			productDao.add(product);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateProduct(Product product) {
		boolean flag=false;
		try{
			productDao.save(product);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteProduct(int id) {
		boolean flag=false;
		try{
			productDao.delete(id);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public Product findProductById(int id) {
		Product product = productDao.findOne(id);
		product.setIcon(imageServerProperties.getAddress() + product.getIcon());
		return  product;
	}

	@Override
	public List<Product> findByName(String name) {
		List<Product> productList = productDao.findByName(name);
		productList.forEach(product -> product.setIcon(imageServerProperties.getAddress() + product.getIcon()));
		return productList;
	}
	
	@Override
	public List<Product> findAll() {
		List<Product> productList = productDao.findAll();
		productList.forEach(product -> product.setIcon(imageServerProperties.getAddress() + product.getIcon()));
		return productList;
		
	}

	@Override
	public boolean deleteProducts(List<String> listid) {
		productDao.deleteProducts(listid);
		// TODO Auto-generated method stub
		return false;
	}
	
	@Override
	public List<Product> findProductListByTypeId(int typeid){
		List<Product> productList = productDao.findProductListByTypeId(typeid);
		productList.forEach(product -> product.setIcon(imageServerProperties.getAddress() + product.getIcon()));
		return productList;
	}
	
}
