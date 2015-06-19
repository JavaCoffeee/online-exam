<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Sign In</title>
<script type="text/javascript" src="resources/js/default/jquery.js"></script>
<script type="text/javascript" src="resources/js/default/jquery-ui.js"></script>
<link rel="stylesheet" href="resources/css/default/jquery-ui.css">
<link rel="stylesheet" href="resources/css/default/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/signin.css" />
<link rel="icon" href="resources/img/favicon.ico">

<!-- <style>
body {
	font-size: 62.5%;
}

label, input {
	display: block;
}

input.text {
	margin-bottom: 12px;
	width: 95%;
	padding: .4em;
}

fieldset {
	padding: 0;
	border: 0;
	margin-top: 25px;
}

h1 {
	font-size: 1.2em;
	margin: .6em 0;
}

div#users-contain {
	width: 350px;
	margin: 20px 0;
}

div#users-contain table {
	margin: 1em 0;
	border-collapse: collapse;
	width: 100%;
}

div#users-contain table td, div#users-contain table th {
	border: 1px solid #eee;
	padding: .6em 10px;
	text-align: left;
}

.ui-dialog .ui-state-error {
	padding: .3em;
}

.validateTips {
	border: 1px solid transparent;
	padding: 0.3em;
}
</style> -->

<script>
	$(function() {
		var dialog, form,

		// From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
		emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/, name = $("#name"), email = $("#email"), password = $("#password"), allFields = $(
				[]).add(name).add(email).add(password), tips = $(".validateTips");

		function updateTips(t) {
			tips.text(t).addClass("ui-state-highlight");
			setTimeout(function() {
				tips.removeClass("ui-state-highlight", 1500);
			}, 500);
		}

		function checkLength(o, n, min, max) {
			if (o.val().length > max || o.val().length < min) {
				o.addClass("ui-state-error");
				updateTips("Length of " + n + " must be between " + min
						+ " and " + max + ".");
				return false;
			} else {
				return true;
			}
		}

		function checkRegexp(o, regexp, n) {
			if (!(regexp.test(o.val()))) {
				o.addClass("ui-state-error");
				updateTips(n);
				return false;
			} else {
				return true;
			}
		}

		function addUser() {
			var valid = true;
			allFields.removeClass("ui-state-error");
			
			valid = valid && checkLength(email, "email", 6, 80);			

			valid = valid
					&& checkRegexp(email, emailRegex, "eg. ui@jquery.com");

			if (valid) {
				alert(email.val());
				$.ajax({					
					url:"/ur/forgotpassword?email="+email.val(),
					success:function(data){
						//alert("Email has been sent");						
					}
				});
				dialog.dialog("close");
			}		
			
			return valid;
		}

		dialog = $("#dialog-form").dialog({
			autoOpen : false,
			height : 200,
			width : 350,
			modal : true,
			buttons : {
				"Send" : addUser,
				Cancel : function() {
					dialog.dialog("close");
				}
			},
			close : function() {
				form[0].reset();
				allFields.removeClass("ui-state-error");
			}
		});

		form = dialog.find("form").on("submit", function(event) {
			event.preventDefault();
			addUser();
		});

		$("#create-user").button().on("click", function() {
			dialog.dialog("open");
		});
	});
</script>

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
			<c:if test="${not empty verificationMsg}">
				<div class="alert alert-success">${verificationMsg}</div>
			</c:if>
			
			<c:if test="${not empty forgotPasswordSentMsg}">
				<div class="alert alert-success">${forgotPasswordSentMsg}</div>
			</c:if>	
			
			<label for="j_username" class="sr-only">User</label> <input
				type='text' name='j_username' value='' class="form-control"
				required="required" autofocus="autofocus" placeholder="Username">

			<label for="j_username" class="sr-only">Password</label> <input
				type='password' name='j_password' class="form-control"
				required="required" placeholder="Password" />

			<button class="btn btn-lg btn-success btn-block" type="submit">Sign
				In</button>
			<button id="create-user" class="btn btn-lg btn-danger btn-block" type="button">Forgot Password</button>
				 <a href="register" class="btn btn-lg btn-primary btn-block">Create
				Account</a>			

			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
	</div>

	<div id="dialog-form" title="Send Email">
		<form>
			<fieldset>
				<label for="email">Email</label> <input type="email" name="email"
					id="email" placeholder="email"
					class="text ui-widget-content ui-corner-all"> <input
					type="submit" tabindex="-1"
					style="position: absolute; top: -1000px">
			</fieldset>
		</form>
	</div>

	<!-- <button id="create-user" class="btn btn-lg btn-danger btn-block">Forgot Password</button> --> 

</body>
</html>