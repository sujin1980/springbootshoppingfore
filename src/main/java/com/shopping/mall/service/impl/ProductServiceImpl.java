package com.shopping.mall.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shopping.mall.dao.ProductDao;
import com.shopping.mall.model.Product;
import com.shopping.mall.service.ProductService;

 
@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
    private ProductDao productDao;
	
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
		return productDao.findOne(id);
	}

	@Override
	public Product findOneByName(String name) {
		return productDao.findOneByName(name);
	}
	
	@Override
	public List<Product> findAll() {
		return productDao.findAll();
		
	}

	@Override
	public boolean deleteProducts(List<String> listid) {
		productDao.deleteProducts(listid);
		// TODO Auto-generated method stub
		return false;
	}
	
	@Override
	public List<Product> findProductListByTypeId(int typeid){
		return productDao.findProductListByTypeId(typeid);
	}
	
}
