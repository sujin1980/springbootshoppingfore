package com.shopping.mall.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.mall.model.Loginfo;
 
 
@Mapper
public interface LoginfoDao {
	
    public void save(Loginfo loginfo);
	
    public void add(Loginfo loginfo);
    
	public void delete(int id);
	
	public Loginfo findOne(int id);
	
	public List<Loginfo> findAll();
	
	public void deleteLoginfos(@Param("idList") List<String> idList);
}
