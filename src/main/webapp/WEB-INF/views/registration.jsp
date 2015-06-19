<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create Account</title>
<script type="text/javascript" src="resources/js/default/jquery.js"></script>
<script type="text/javascript" src="resources/js/default/jquery.validate.min.js"></script>
<script type="text/javascript" src="resources/js/default/jquery-ui.js"></script>
<link rel="stylesheet" href="resources/css/default/jquery-ui.css">
<link rel="stylesheet" href="resources/css/default/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/signin.css" />
<link rel="icon" href="resources/img/favicon.ico">
</head>
<body>
	<div class="container">
		<form action="add" class="form-signin" id="registration-form">
			<h2 class="form-signin-heading" align="center">Create Account</h2>
			<input type="text" name="userName" id="userName" class="form-control" autofocus="autofocus" required="required" placeholder="UserName">			
			<input type="password" name="password" id="password" class="form-control" required="required" placeholder="Password">
			<input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required="required" placeholder="Re Enter Password">
			<input type="email" name="email" id="email" class="form-control" required="required" placeholder="Email">			
			<input type="text" name="dob" id="dob" class="form-control" required="required" placeholder="Birth Date">									
			<button class="btn btn-lg btn-success btn-block" type="submit">Create</button>
		</form>
	</div>
	<script type="text/javascript">
		$(function(){
			$("#dob").datepicker({
				changeMonth: true,
			    changeYear: true});
		});		
		
		$(function(){			
			$("#registration-form").validate({
				rules:{
					userName:{
						required:true						
					},					
					password:{
						required : true,
						minlength : 6,
						pwcheck : true
					},
					confirmPassword:{
						required : true,
						equalTo : "#password"
					},
					email:{
						required : true,
						email : true
					},
					dob:{
						required : true
					}
				},
				messages:{
					userName:{
						required : "This field is required"						
					},
					password:{
						required : "This field is required",
						minlength : "Password must be 6 character long",
						pwcheck : "Password must contain 1 uppercase , 1 lowercase , 1 digit"
					},
					confirmPassword:{
						required : "This field is required",
						equalTo : "Password does not match"
					},
					email:{
						required : "This field is required",
						email : "Enter valid email address"
					},
					dob:{
						required : "This field is required"
					}
				},
				submitHandler:function(form){
					form.submit();
				}			
			});
		});			
		
		$.validator.addMethod("pwcheck", function(value) {
			   return /^[A-Za-z0-9\d=!\-@._*]*$/.test(value) // consists of only these
			       && /[a-z]/.test(value) // has a lowercase letter
			       && /\d/.test(value) // has a digit
			       && /[A-Z]/.test(value) // has an uppercase letter
			       && /\W/.test(value) // has one special character
			});
	</script>
</body>
</html>