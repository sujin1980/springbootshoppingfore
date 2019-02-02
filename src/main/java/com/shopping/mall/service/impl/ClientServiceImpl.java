package com.shopping.mall.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shopping.mall.dao.ClientDao;
import com.shopping.mall.model.ShoppingMallClient;
import com.shopping.mall.service.ClientService;

 
@Service
public class ClientServiceImpl implements ClientService{
	
	@Autowired
    private ClientDao clientDao;
	
	@Override
	public boolean addClient(ShoppingMallClient client) {
		boolean flag=false;
		try{
			clientDao.add(client);
			flag=true;
		}catch(Exception e){
			System.out.println("新增失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean updateClient(ShoppingMallClient client) {
		boolean flag=false;
		try{
			clientDao.save(client);
			flag=true;
		}catch(Exception e){
			System.out.println("修改失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean deleteClient(int id) {
		boolean flag=false;
		try{
			clientDao.delete(id);
			flag=true;
		}catch(Exception e){
			System.out.println("删除失败!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public ShoppingMallClient findClientById(int id) {
		return clientDao.findOne(id);
	}

	@Override
	public List<ShoppingMallClient> findAll() {
		return clientDao.findAll();
		
	}

	@Override
	public boolean deleteClients(List<String> listid) {
		clientDao.deleteClients(listid);
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ShoppingMallClient findOneByName(String name) {
		// TODO Auto-generated method stub
		return clientDao.findOneByName(name);
	}
	
	
}
