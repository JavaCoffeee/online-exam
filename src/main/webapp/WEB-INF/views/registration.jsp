<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create Account</title>
<link rel="stylesheet" href="resources/css/default/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/signin.css" />
</head>
<body>
	<div class="container">
		<form action="add" class="form-signin">
			<h2 class="form-signin-heading" align="center">Create Account</h2>
			<input type="text" name="userName" id="userName" class="form-control" autofocus="autofocus" required="required" placeholder="UserName">			
			<input type="password" name="password" id="password" class="form-control" required="required" placeholder="Password">
			<input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required="required" placeholder="Re Enter Password">
			<input type="email" name="email" id="email" class="form-control" required="required" placeholder="Email">
			<input type="text" name="dob" id="dob" class="form-control" required="required" placeholder="Birth Date">			
			<button class="btn btn-lg btn-success btn-block" type="submit">Create</button>
		</form>
	</div>
</body>
</html>