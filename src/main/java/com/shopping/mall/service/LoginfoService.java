package com.shopping.mall.service;

import java.util.List;

import com.shopping.mall.model.Loginfo;

public interface LoginfoService {
	/**
	 * 新增用户
	 * @param Loginfo
	 * @return
	 */
	boolean addLoginfo(Loginfo loginfo);
	
	/**
	 * 修改用户
	 * @param Loginfo
	 * @return
	 */
	boolean updateLoginfo(Loginfo loginfo);
	
	
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	boolean deleteLoginfo(int id);
	
	/**
     * 根据用户名字查询用户信息
     * @param LoginfoName
     */
	Loginfo findLoginfoById(int id);
    /**
     * 查询所有
     * @return
     */
	List<Loginfo> findAll();
	
	
	boolean deleteLoginfos(List<String> listid);
}
