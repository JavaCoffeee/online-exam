package com.online.exam.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.online.exam.model.Role;

@Repository
public class RoleDaoImpl implements RoleDao{
	@Autowired
	private SessionFactory sessionFactory;
	@Override
	public void saveRole(Role role) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().persist(role);
	}

}
