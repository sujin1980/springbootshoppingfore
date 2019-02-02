package com.shopping.mall.service;

import java.util.List;

import com.shopping.mall.model.Right;

public interface RightService {
	/**
	 * 新增用户
	 * @param Right
	 * @return
	 */
	boolean addRight(Right right);
	
	/**
	 * 修改用户
	 * @param Right
	 * @return
	 */
	boolean updateRight(Right right);
	
	
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	boolean deleteRight(int id);
	
	/**
     * 根据用户名字查询用户信息
     * @param RightName
     */
	Right findRightById(int id);
    /**
     * 查询所有
     * @return
     */
	List<Right> findAll();
	
	
	boolean deleteRights(List<String> listid);
}
