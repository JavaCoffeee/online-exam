<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Sign In</title>
<link rel="stylesheet" href="resources/css/default/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/signin.css" />
<link rel="icon" href="resources/img/favicon.ico">	
</head>
<body onload='document.loginForm.username.focus();'>

	<div class="container">

		<form name='loginForm'
			action="<c:url value='j_spring_security_check' />" method='POST'
			class="form-signin">
			<h2 class="form-signin-heading" align="center">Sign In</h2>

			<c:if test="${not empty error}">
				<div class="alert alert-danger">${error}</div>
			</c:if>
			<c:if test="${not empty msg}">
				<div class="alert alert-success">${msg}</div>
			</c:if>

			<label for="j_username" class="sr-only">User</label> <input
				type='text' name='j_username' value='' class="form-control"
				required="required" autofocus="autofocus" placeholder="Username">

			<label for="j_username" class="sr-only">Password</label> <input
				type='password' name='j_password' class="form-control"
				required="required" placeholder="Password" />

			<button class="btn btn-lg btn-success btn-block" type="submit">Sign
				In</button>
			<a href="forgotpassword" class="btn btn-lg btn-danger btn-block">Forgot Password</a>
			<a href="register" class="btn btn-lg btn-primary btn-block">Create Account</a>

			<!-- <a href="forgotpassword" class="forgot-password">Forgot Password</a>
			<a href="register" class="sign-up">Create Account</a> --> <input type="hidden"

				name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>

	</div>
</body>
</html>