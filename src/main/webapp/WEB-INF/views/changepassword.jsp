<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reset Password</title>
<script type="text/javascript" src="/ur/resources/js/default/jquery.js"></script>
<script type="text/javascript" src="/ur/resources/js/default/jquery.validate.min.js"></script>
<script type="text/javascript" src="/ur/resources/js/default/jquery-ui.js"></script>
<link rel="stylesheet" href="/ur/resources/css/default/jquery-ui.css">
<link rel="stylesheet" href="/ur/resources/css/default/bootstrap.min.css">
<link rel="stylesheet" href="/ur/resources/css/signin.css" />
<link rel="icon" href="/ur/resources/img/favicon.ico">
</head>
<body>
	<div class="container">
		<form action="changepassword" class="form-signin" id="reset-password">
			<h2 class="form-signin-heading" align="center">Reset Password</h2>						
			<input type="password" name="password" id="password" class="form-control" required="required" placeholder="New Password">
			<input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required="required" placeholder="Re Enter your new password">
			<input type="text" name="username" id="username" class="form-control" value="${value}"> 												
			<button class="btn btn-lg btn-success btn-block" type="submit">Change</button>
		</form>
	</div>
	<script type="text/javascript">		
		$(function(){			
			$("#reset-password").validate({
				rules:{										
					password:{
						required : true,
						minlength : 6						
					},
					confirmPassword:{
						required : true,
						equalTo : "#password"
					}					
				},
				messages:{					
					password:{
						required : "This field is required",
						minlength : "Password must be 6 character long",
						pwcheck : "Password must contain 1 uppercase , 1 lowercase , 1 digit"
					},
					confirmPassword:{
						required : "This field is required",
						equalTo : "Password does not match"
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