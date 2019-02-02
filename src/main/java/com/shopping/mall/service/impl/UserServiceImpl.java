package com.shopping.mall.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shopping.mall.dao.UserDao;
import com.shopping.mall.model.User;
import com.shopping.mall.service.UserService;

 
@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
    private UserDao userDao;
	
	@Override
	public boolean addUser(User user) {
		boolean flag=false;
		try{
			userDao.add(user);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateUser(User user) {
		boolean flag=false;
		try{
			userDao.save(user);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteUser(int id) {
		boolean flag=false;
		try{
			userDao.delete(id);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public User findUserById(int id) {
		return userDao.findOne(id);
	}

	@Override
	public List<User> findAll() {
		return userDao.findAll();
		
	}

	@Override
	public boolean deleteUsers(List<String> listid) {
		userDao.deleteUsers(listid);
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public User findOneByName(String name) {
		// TODO Auto-generated method stub
		return userDao.findOneByName(name);
	}
}
