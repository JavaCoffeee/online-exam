package com.online.exam.service;

import com.online.exam.model.User;

public interface UserService {
	public void saveUser(User user);
	public User getUserFromVerificationCode(String verificationCode);
	public User getUserFromUserName(String userName);
	public User getUserFromEmailAddress(String email);
	public void updateUser(User user);
}
