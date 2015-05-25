package com.online.exam;

import java.io.Reader;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.online.exam.model.Role;
import com.online.exam.model.User;
import com.online.exam.service.RoleService;
import com.online.exam.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "login";
	}
	
	@RequestMapping(value="/register")
	public ModelAndView registrationScreen(){
		ModelAndView modelAndView = new ModelAndView("registration","command",new User());
		return modelAndView;
	}
	
	@RequestMapping(value="/add")
	public String addUser(@ModelAttribute("command")User user){
		BCryptPasswordEncoder enc = new BCryptPasswordEncoder();
		String newPassword = enc.encode(user.getPassword());
		user.setPassword(newPassword);
		Role role = new Role();
		role.setRole("ROLE_USER");
		List<Role> roles = new ArrayList<Role>();
		roles.add(role);
		user.setRoles(roles);
		user.setEnabled(true);
		userService.saveUser(user);		
		role.setUser(user);
		roleService.saveRole(role);		
		return "redirect:/login";
	}
	
	@RequestMapping(value="/login")
	public String loggedin(@RequestParam(value="error",required=false)String error,@RequestParam(value="logout",required=false)String logout,Model model){
		if(error!=null){
			model.addAttribute("error", "Invalid Username or Password.");
		}
		if(logout!=null){
			model.addAttribute("msg", "You have been Logout Successfully.");
		}
		return "login";
	}
	
	@RequestMapping(value="/admin")
	public String admin(){		
		return "admin";
	}
}