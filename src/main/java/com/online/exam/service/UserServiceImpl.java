package com.online.exam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.online.exam.dao.UserDao;
import com.online.exam.model.User;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao userDao;
	
	@Override
	@Transactional
	public void saveUser(User user) {
		// TODO Auto-generated method stub
		userDao.saveUser(user);
	}	
}