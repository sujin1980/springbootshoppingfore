package com.shopping.mall.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.mall.model.User;
 
 
@Mapper
public interface UserDao {
	
    public void save(User user);
	
    public void add(User user);
    
	public void delete(int id);
	
	public User findOne(int id);
	
	public List<User> findAll();
	
	public User findOneByName(String name);
	
	public void deleteUsers(@Param("idList") List<String> idList);
}
