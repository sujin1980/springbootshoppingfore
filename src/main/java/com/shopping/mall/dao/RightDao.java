package com.shopping.mall.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.mall.model.Right;
 
 
@Mapper
public interface RightDao {
	
    public void save(Right right);
	
    public void add(Right right);
    
	public void delete(int id);
	
	public Right findOne(int id);
	
	public List<Right> findAll();
	
	public void deleteRights(@Param("idList") List<String> idList);
}
