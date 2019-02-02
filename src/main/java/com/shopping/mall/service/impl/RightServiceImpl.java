package com.shopping.mall.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shopping.mall.dao.RightDao;
import com.shopping.mall.model.Right;
import com.shopping.mall.service.RightService;

 
@Service
public class RightServiceImpl implements RightService{
	
	@Autowired
    private RightDao rightDao;
	
	@Override
	public boolean addRight(Right right) {
		boolean flag=false;
		try{
			rightDao.add(right);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateRight(Right right) {
		boolean flag=false;
		try{
			rightDao.save(right);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteRight(int id) {
		boolean flag=false;
		try{
			rightDao.delete(id);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public Right findRightById(int id) {
		return rightDao.findOne(id);
	}

	@Override
	public List<Right> findAll() {
		return rightDao.findAll();
		
	}

	@Override
	public boolean deleteRights(List<String> listid) {
		rightDao.deleteRights(listid);
		// TODO Auto-generated method stub
		return false;
	}
}
