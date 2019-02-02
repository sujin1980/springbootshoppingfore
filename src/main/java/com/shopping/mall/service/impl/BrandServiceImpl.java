package com.shopping.mall.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.mall.dao.BrandDao;
import com.shopping.mall.model.Brand;
import com.shopping.mall.service.BrandService;
 

@Service
public class BrandServiceImpl implements BrandService{
	
//	@Autowired
//    private BrandDao brandDao;
//	
	
	@Override
	public boolean addBrand(Brand Brand) {
		boolean flag=false;
		try{
			//brandDao.save(Brand);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateBrand(Brand Brand) {
		boolean flag=false;
		try{
			//brandDao.save(Brand);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteBrand(int id) {
		boolean flag=false;
		try{
			//brandDao.delete(id);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public Brand findBrandById(int id) {
		return null;//brandDao.findOne(id);
	}

	@Override
	public List<Brand> findAll() {
		return null;//brandDao.findAll();
	}

}
