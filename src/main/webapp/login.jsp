<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Responsive Login Form</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap Icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css"
	rel="stylesheet">
<style>
.toggle-password {
	position: absolute;
	right: 15px;
	top: 50%;
	transform: translateY(15%);
	cursor: pointer;
	color: #888;
}

.login-form {
	max-width: 100%;
	width: 100%;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

.form-container {
	padding: 15px;
}

.btn-custom {
	background-color: #00b075;
	color: white;
}

.btn-custom:hover {
	color: white;
	background-color: #21b684;
}
</style>
</head>
<body class="bg-light d-flex align-items-center justify-content-center"
	style="height: 100vh;">

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-4 col-md-6 col-sm-8 col-12 form-container">
				<form action="loginsignup" method="POST" autocomplete="off"
					class="login-form">
					<h2 class="text-center mb-4">Login</h2>
					<div class="mb-3 position-relative">
						<label for="email" class="form-label">Email</label> <input
							type="text" id="email" name="email" class="form-control"
							placeholder="Enter your email" required>
					</div>
					<div class="mb-3 position-relative">
						<label for="passcode" class="form-label">Passcode</label> <input
							type="password" id="passcode" name="passcode"
							class="form-control" placeholder="Enter your passcode" required>
						<i class="bi bi-eye-slash toggle-password" id="togglePasscodeIcon"
							onclick="togglePasscode()"></i>
					</div>
					<input type="hidden" name="action" value="login">
					<button type="submit" class="btn btn-custom w-100">Login</button>
					<center>
						<a href="Register">Don't Have Account? Please SignUp</a>
					</center>
				</form>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		function togglePasscode() {
			const passcodeField = document.getElementById('passcode');
			const toggleIcon = document.getElementById('togglePasscodeIcon');
			if (passcodeField.type === 'password') {
				passcodeField.type = 'text';
				toggleIcon.classList.remove('bi-eye-slash');
				toggleIcon.classList.add('bi-eye');
			} else {
				passcodeField.type = 'password';
				toggleIcon.classList.remove('bi-eye');
				toggleIcon.classList.add('bi-eye-slash');
			}
		}
	</script>
</body>
</html>
