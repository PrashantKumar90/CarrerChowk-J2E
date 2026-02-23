<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Signup Form</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f3f3f3;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.signup-form {
	background: #ffffff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 500px;
}

.btn-custom {
	background-color: #00b075;
	color: #ffffff;
	border: none;
}

.btn-custom:hover {
	background-color: #21b684;
	color: #ffffff;
}
</style>
</head>
<body>
	<div class="container">
	<div class="row justify-content-center">
		<div class="col-12 col-md-8 col-lg-6">
			<form action="loginsignup" method="POST" autocomplete="off" class="signup-form">
				<h2 class="text-center mb-4">Signup Form</h2>

				<!-- Role Toggle -->
				<div class="mb-3">
					<label class="form-label">Register As</label>
					<select id="usertype" name="usertype" class="form-select" required>
						<option value="admin">Admin</option>
						<option value="user">User</option>
					</select>
				</div>

				<!-- Basic Fields -->
				<div class="mb-3">
					<input type="text" id="name" name="name" class="form-control" placeholder="Enter your name" required>
				</div>
				<div class="mb-3">
					<input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
				</div>
				<div class="mb-3">
					<input type="password" id="passcode" name="passcode" class="form-control" placeholder="Enter your passcode" required>
				</div>
				<div class="mb-3">
					<input type="tel" id="phone" name="phone" class="form-control" placeholder="Enter your phone number" pattern="\d*" maxlength="10" required>
				</div>

				<div class="mb-3">
					<select id="state" name="state" class="form-select" required>
                    <option value="Andaman and Nicobar Islands">Andaman and Nicobar Islands</option>
                    <option value="Andhra Pradesh">Andhra Pradesh</option>
                    <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                    <option value="Assam">Assam</option>
                    <option value="Bihar">Bihar</option>
                    <option value="Chandigarh">Chandigarh</option>
                    <option value="Chhattisgarh">Chhattisgarh</option>
                    <option value="Dadra and Nagar Haveli and Daman and Diu">Dadra and Nagar Haveli and Daman and Diu</option>
                    <option value="Delhi">Delhi</option>
                    <option value="Goa">Goa</option>
                    <option value="Gujarat">Gujarat</option>
                    <option value="Haryana">Haryana</option>
                    <option value="Himachal Pradesh">Himachal Pradesh</option>
                    <option value="Jammu and Kashmir">Jammu and Kashmir</option>
                    <option value="Jharkhand">Jharkhand</option>
                    <option value="Karnataka">Karnataka</option>
                    <option value="Kerala">Kerala</option>
                    <option value="Ladakh">Ladakh</option>
                    <option value="Lakshadweep">Lakshadweep</option>
                    <option value="Madhya Pradesh">Madhya Pradesh</option>
                    <option value="Maharashtra">Maharashtra</option>
                    <option value="Manipur">Manipur</option>
                    <option value="Meghalaya">Meghalaya</option>
                    <option value="Mizoram">Mizoram</option>
                    <option value="Nagaland">Nagaland</option>
                    <option value="Odisha">Odisha</option>
                    <option value="Puducherry">Puducherry</option>
                    <option value="Punjab">Punjab</option>
                    <option value="Rajasthan">Rajasthan</option>
                    <option value="Sikkim">Sikkim</option>
                    <option value="Tamil Nadu">Tamil Nadu</option>
                    <option value="Telangana">Telangana</option>
                    <option value="Tripura">Tripura</option>
                    <option value="Uttar Pradesh">Uttar Pradesh</option>
                    <option value="Uttarakhand">Uttarakhand</option>
                    <option value="West Bengal">West Bengal</option>
					</select>
				</div>

				<input type="hidden" name="action" value="registration">
				<button type="submit" class="btn btn-custom w-100">Sign Up</button>
				<center>
					<a href="Credential">Already have account? Login</a>
				</center>
			</form>
		</div>
	</div>
</div>


	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
