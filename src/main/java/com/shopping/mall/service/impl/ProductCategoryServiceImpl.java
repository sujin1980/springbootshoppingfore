package com.shopping.mall.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shopping.mall.dao.ProductCategoryDao;
import com.shopping.mall.model.ProductCategory;
import com.shopping.mall.model.ProductType;
import com.shopping.mall.service.ProductCategoryService;
 

@Service
public class ProductCategoryServiceImpl implements ProductCategoryService{
	
	@Autowired
    private ProductCategoryDao productCategoryDao;
	
	
	@Override
	public boolean addProductCategory(ProductCategory productCategory) {
		boolean flag=false;
		try{
			productCategoryDao.save(productCategory);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateProductCategory(ProductCategory productCategory) {
		boolean flag=false;
		try{
			productCategoryDao.save(productCategory);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteProductCategory(int id) {
		boolean flag=false;
		try{
			productCategoryDao.delete(id);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public ProductCategory findProductCategoryById(int id) {
		return productCategoryDao.findOne(id);
	}

	@Override
	public List<ProductCategory> findAll() {
		
		return productCategoryDao.findAll();
	}

}
