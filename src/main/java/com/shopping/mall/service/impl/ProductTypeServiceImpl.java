package com.shopping.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.mall.dao.ProductTypeDao;
import com.shopping.mall.model.ProductType;
import com.shopping.mall.service.ProductTypeService;

@Service
public class ProductTypeServiceImpl implements ProductTypeService{

	@Autowired
    private ProductTypeDao productTypeDao;
	
	@Override
	public boolean addProductType(ProductType productType) {
		boolean flag=false;
		try{
			productTypeDao.save(productType);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateProductType(ProductType productType) {
		boolean flag=false;
		try{
			productTypeDao.save(productType);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteProductType(int id) {
		boolean flag=false;
		try{
			productTypeDao.delete(id);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public ProductType findProductTypeById(int id) {
		return productTypeDao.findOne(id);
	}

	@Override
	public List<ProductType> findAll() {
		return productTypeDao.findAll();
	}

	@Override
	public List<ProductType> findProductTypeListByCategoryId(int id) {
		// TODO Auto-generated method stub
		return productTypeDao.findProductTypeListByCategoryId(id);
	}

	@Override
	public List<ProductType> findProductTypeListByCategoryName(String name) {
		// TODO Auto-generated method stub
		return productTypeDao.findProductTypeListByCategoryName(name);
	}
}
