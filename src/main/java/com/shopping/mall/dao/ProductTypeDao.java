package com.shopping.mall.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.shopping.mall.model.ProductType;
 
 
@Mapper
public interface ProductTypeDao {
	
    public void save(ProductType productType);
	
	public void delete(int id);
	
	public ProductType findOne(int id);
	
	public List<ProductType> findAll();
	
	public List<ProductType> findProductTypeListByCategoryId(int id);

	public List<ProductType> findProductTypeListByCategoryName(String name);
}
