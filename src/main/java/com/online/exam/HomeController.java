package com.online.exam;

import java.io.File;
import java.io.Reader;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.online.exam.model.Role;
import com.online.exam.model.User;
import com.online.exam.service.RoleService;
import com.online.exam.service.UserService;
import com.online.exam.util.MailUtil;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	private static final Logger logger = LoggerFactory
			.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		logger.info("Welcome home! The client locale is {}.", locale);
		System.out.println("Inside First..!!");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG,
				DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();

		if (name.equals("anonymousUser")) {
			model.addAttribute("value", "SignIn");
		} else {
			model.addAttribute("value", name);
		}

		return "home";
	}

	@RequestMapping(value = "/register")
	public ModelAndView registrationScreen() {
		ModelAndView modelAndView = new ModelAndView("registration", "command",
				new User());
		return modelAndView;
	}

	@RequestMapping(value = "/add")
	public String addUser(@ModelAttribute("command") User user) {
		BCryptPasswordEncoder enc = new BCryptPasswordEncoder();
		String newPassword = enc.encode(user.getPassword());
		user.setPassword(newPassword);
		user.setVerified(false);
		String verificationString = UUID.randomUUID().toString();
		user.setVerificationString(verificationString);

		Role role = new Role();
		role.setRole("ROLE_USER");
		List<Role> roles = new ArrayList<Role>();
		roles.add(role);
		user.setRoles(roles);
		user.setEnabled(true);
		userService.saveUser(user);

		role.setUser(user);
		roleService.saveRole(role);

		String appendLink = "192.168.15.178:6060/ur/verify/" + verificationString;
		System.out.println(appendLink);

		MailUtil.sendMsg(user.getEmail(), appendLink);

		return "redirect:/login";
	}

	@RequestMapping(value = "/login")
	public String loggedin(
			@ModelAttribute("username")String username,
			@ModelAttribute("forgotPasswordSentMsg")String forgotPasswordSentMsg,
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout,
			Model model) {		
		if (error != null) {
			model.addAttribute("error", "Invalid Username or Password");
		}
		if (logout != null) {
			model.addAttribute("msg", "You have been Logout Successfully.");
		}		
		if(username.equals("")){			
		}else{
			model.addAttribute("verificationMsg", "Congratulations..!! Verification has been done.");
		}
		
		if(!forgotPasswordSentMsg.equals("")){
			System.out.println("==> "+forgotPasswordSentMsg);
			model.addAttribute("forgotPasswordSentMsg", "Email has been sent.");
		}else{
			System.out.println(":: :: "+forgotPasswordSentMsg);
		}
		return "login";
	}

	@RequestMapping(value = "/admin")
	public String admin() {
		return "admin";
	}

	@RequestMapping(value = "/verify/{verificationCode}")
	public String verification(@PathVariable String verificationCode,
			Model model, RedirectAttributes redirectAttributes) {		
		User user = userService.getUserFromVerificationCode(verificationCode);
		user.setVerified(true);
		userService.updateUser(user);
		String name = user.getUserName();
		if (name.equals("anonymousUser")) {
			model.addAttribute("value", "Sign in");
		} else {
			model.addAttribute("value", name);
		}
		redirectAttributes.addFlashAttribute("username", name);
		return "redirect:/login";
	}	
	
	@RequestMapping(value="/verify/changepassword")
	public String changePassword(HttpServletRequest request){
		System.out.println("Inside");		
		System.out.println("Username : "+request.getParameter("username"));
		User user = userService.getUserFromUserName(request.getParameter("username"));
				
		BCryptPasswordEncoder enc = new BCryptPasswordEncoder();
		String newPassword = enc.encode(request.getParameter("password"));
		
		user.setPassword(newPassword);
		userService.updateUser(user);
		return "redirect:/";
	}
	
	@RequestMapping(value="/forgotpassword")
	public String forgotPassword(@RequestParam("email")String email,RedirectAttributes redirectAttributes){
		System.out.println("inside forgot password : "+email);
		User user = userService.getUserFromEmailAddress(email);
		if(user!=null){
			String password = user.getUserName().concat("123@");				
			BCryptPasswordEncoder enc = new BCryptPasswordEncoder();
			String newPassword = enc.encode(password);			
			
			MailUtil.sendMsg(user.getEmail(),password);
			
			user.setPassword(newPassword);
			userService.updateUser(user);
			
			redirectAttributes.addFlashAttribute("forgotPasswordSentMsg", "Msg");
			
		}else{
			System.out.println("No user found with this email address");
		}
		return "redirect:/login";
	}
}