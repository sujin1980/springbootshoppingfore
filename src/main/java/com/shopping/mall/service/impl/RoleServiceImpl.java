package com.shopping.mall.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shopping.mall.dao.RoleDao;
import com.shopping.mall.model.Role;
import com.shopping.mall.service.RoleService;

 
@Service
public class RoleServiceImpl implements RoleService{
	
	@Autowired
    private RoleDao roleDao;
	
	@Override
	public boolean addRole(Role role) {
		boolean flag=false;
		try{
			roleDao.add(role);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateRole(Role role) {
		boolean flag=false;
		try{
			roleDao.save(role);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteRole(int id) {
		boolean flag=false;
		try{
			roleDao.delete(id);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public Role findRoleById(int id) {
		return roleDao.findOne(id);
	}

	@Override
	public List<Role> findAll() {
		return roleDao.findAll();
		
	}

	@Override
	public boolean deleteRoles(List<String> listid) {
		roleDao.deleteRoles(listid);
		// TODO Auto-generated method stub
		return false;
	}
}
