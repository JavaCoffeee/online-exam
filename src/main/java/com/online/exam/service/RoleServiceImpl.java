package com.online.exam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.online.exam.dao.RoleDao;
import com.online.exam.model.Role;

@Service
public class RoleServiceImpl implements RoleService{
	@Autowired
	private RoleDao roleDao;
	@Override
	@Transactional
	public void saveRole(Role role) {
		// TODO Auto-generated method stub
		roleDao.saveRole(role);
	}
}