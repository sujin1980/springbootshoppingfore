package com.shopping.mall.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.mall.model.Role;
 
 
@Mapper
public interface RoleDao {
	
    public void save(Role role);
	
    public void add(Role role);
    
	public void delete(int id);
	
	public Role findOne(int id);
	
	public List<Role> findAll();
	
	public void deleteRoles(@Param("idList") List<String> idList);
}
