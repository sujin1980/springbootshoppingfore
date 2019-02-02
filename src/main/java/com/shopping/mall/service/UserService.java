package com.shopping.mall.service;

import java.util.List;

import com.shopping.mall.model.User;

public interface UserService {
	/**
	 * 新增用户
	 * @param User
	 * @return
	 */
	boolean addUser(User user);
	
	/**
	 * 修改用户
	 * @param User
	 * @return
	 */
	boolean updateUser(User user);
	
	
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	boolean deleteUser(int id);
	
	/**
     * 根据用户名字查询用户信息
     * @param UserName
     */
	User findUserById(int id);
    /**
     * 查询所有
     * @return
     */
	List<User> findAll();
	
	User findOneByName(String name);
	
	boolean deleteUsers(List<String> listid);
}
