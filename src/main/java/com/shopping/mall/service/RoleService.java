package com.shopping.mall.service;

import java.util.List;

import com.shopping.mall.model.Role;

public interface RoleService {
	/**
	 * 新增用户
	 * @param Role
	 * @return
	 */
	boolean addRole(Role role);
	
	/**
	 * 修改用户
	 * @param Role
	 * @return
	 */
	boolean updateRole(Role role);
	
	
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	boolean deleteRole(int id);
	
	/**
     * 根据用户名字查询用户信息
     * @param RoleName
     */
	Role findRoleById(int id);
    /**
     * 查询所有
     * @return
     */
	List<Role> findAll();
	
	
	boolean deleteRoles(List<String> listid);
}
