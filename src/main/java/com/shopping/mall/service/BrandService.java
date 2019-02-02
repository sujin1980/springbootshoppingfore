package com.shopping.mall.service;

import java.util.List;

import com.shopping.mall.model.Brand;

public interface BrandService {

	boolean addBrand(Brand brand);

	boolean updateBrand(Brand brand);
	
	boolean deleteBrand(int id);

	Brand findBrandById(int id);
	
	List<Brand> findAll();
}
