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

	@Override
	@Transactional
	public User getUserFromVerificationCode(String verificationCode) {
		// TODO Auto-generated method stub
		return userDao.getUserFromVerificationCode(verificationCode);
	}

	@Override
	@Transactional
	public void updateUser(User user) {
		// TODO Auto-generated method stub
		userDao.updateUser(user);
	}

	@Override
	@Transactional
	public User getUserFromUserName(String userName) {
		// TODO Auto-generated method stub
		return userDao.getUserFromUserName(userName);
	}

	@Override
	@Transactional
	public User getUserFromEmailAddress(String email) {
		// TODO Auto-generated method stub
		return userDao.getUserFromEmailAddress(email);
	}	
}