package com.shopping.mall.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shopping.mall.dao.LoginfoDao;
import com.shopping.mall.model.Loginfo;
import com.shopping.mall.service.LoginfoService;

 
@Service
public class LoginfoServiceImpl implements LoginfoService{
	
	@Autowired
    private LoginfoDao loginfoDao;
	
	@Override
	public boolean addLoginfo(Loginfo loginfo) {
		boolean flag=false;
		try{
			loginfoDao.add(loginfo);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateLoginfo(Loginfo loginfo) {
		boolean flag=false;
		try{
			loginfoDao.save(loginfo);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteLoginfo(int id) {
		boolean flag=false;
		try{
			loginfoDao.delete(id);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public Loginfo findLoginfoById(int id) {
		return loginfoDao.findOne(id);
	}

	@Override
	public List<Loginfo> findAll() {
		return loginfoDao.findAll();
		
	}

	@Override
	public boolean deleteLoginfos(List<String> listid) {
		loginfoDao.deleteLoginfos(listid);
		// TODO Auto-generated method stub
		return false;
	}
}
