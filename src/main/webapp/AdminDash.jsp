<%@ page import="com.Major.Entity.UserEntity"%>
<%@ page import="com.Major.Entity.UserEntity"%>
<%
session = request.getSession(false); // Get the current session, but don't create a new one
if (session == null || session.getAttribute("user") == null) {
	response.sendRedirect("login.jsp");
	return; // Stop further processing
}

UserEntity user = (UserEntity) session.getAttribute("user");

if (user.getStatus() != 2) {
	response.sendRedirect("404.jsp");
	return;
}

// Add cache-control headers to prevent caching
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--primary-color: #00b075;
	--secondary-color: #008a5e;
	--accent-color: #00d394;
	--light-color: #f8f9fa;
	--dark-color: #212529;
}

body {
	background-color: #f5f7fa;
	font-family: 'Poppins', Arial, sans-serif;
	min-height: 100vh;
}

.navbar {
	background: white;
	box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
	padding: 15px 0;
}

.navbar-brand {
	font-weight: 700;
	font-size: 1.8rem;
}

.navbar-brand span.text-primary {
	color: var(--primary-color) !important;
}

.btn-logout {
	background: linear-gradient(to right, var(--primary-color),
		var(--secondary-color));
	border: none;
	padding: 10px 25px;
	border-radius: 50px;
	font-weight: 500;
	transition: all 0.3s;
	box-shadow: 0 4px 15px rgba(0, 176, 117, 0.3);
}

.btn-logout:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(0, 176, 117, 0.4);
}

.dashboard {
	padding: 40px 0;
}

.welcome-section {
	text-align: center;
	margin-bottom: 40px;
}

.welcome-section h1 {
	font-weight: 700;
	color: var(--dark-color);
	margin-bottom: 10px;
}

.welcome-section p {
	color: #6c757d;
	font-size: 1.1rem;
}

.card {
	border: none;
	border-radius: 12px;
	overflow: hidden;
	transition: all 0.3s ease;
	height: 100%;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	border-top: 4px solid var(--primary-color);
}

.card:hover {
	transform: translateY(-10px);
	box-shadow: 0 15px 30px rgba(0, 176, 117, 0.15);
}

.card-body {
	padding: 30px;
	text-align: center;
}

.card-icon {
	font-size: 2.5rem;
	color: var(--primary-color);
	margin-bottom: 20px;
	background: rgba(0, 176, 117, 0.1);
	width: 70px;
	height: 70px;
	border-radius: 50%;
	display: inline-flex;
	align-items: center;
	justify-content: center;
}

.card-title {
	font-size: 1.3rem;
	font-weight: 600;
	margin-bottom: 15px;
	color: var(--dark-color);
}

.card-text {
	color: #6c757d;
	margin-bottom: 25px;
	font-size: 0.95rem;
}

.btn-card {
	background: linear-gradient(to right, var(--primary-color),
		var(--secondary-color));
	border: none;
	padding: 8px 20px;
	border-radius: 50px;
	font-weight: 500;
	transition: all 0.3s;
	box-shadow: 0 4px 15px rgba(0, 176, 117, 0.2);
	width: 80%;
	max-width: 200px;
}

.btn-card:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 25px rgba(0, 176, 117, 0.3);
}

@media ( max-width : 768px) {
	.dashboard {
		padding: 30px 15px;
	}
	.card {
		margin-bottom: 20px;
	}
	.welcome-section h1 {
		font-size: 1.8rem;
	}
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg sticky-top">
		<div class="container">
			<a href="#" class="navbar-brand">
				<h1 class="m-0">
					Scholarship<span style="color: var(--primary-color);">Info</span>
				</h1>
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<div class="navbar-nav ms-auto">
					<form action="loginsignup" method="get">
						<button type="submit" class="btn btn-logout">
							Log Out <i class="fas fa-sign-out-alt ms-2"></i>
						</button>
					</form>
				</div>
			</div>
		</div>
	</nav>

	<div class="container dashboard">
		<div class="welcome-section">
			<h1>
				Welcome,
				<%=user.getName()%>!
			</h1>
			<p>Manage scholarship schemes with ease</p>
		</div>

		<div class="row g-4">
			<!-- Card 1 -->
			<div class="col-lg-4 col-md-6">
				<div class="card">
					<div class="card-body">
						<div class="card-icon">
							<i class="fas fa-list-ul"></i>
						</div>
						<h5 class="card-title">View Scheme List</h5>
						<p class="card-text">Browse all available scholarship schemes
							and programs</p>
						<form action="Schemes" method="post">
							<input type="hidden" name="adminID" value="<%=user.getId()%>">
							<button type="submit" class="btn btn-card">
								View Schemes <i class="fas fa-arrow-right ms-2"></i>
							</button>
						</form>
					</div>
				</div>
			</div>

			<!-- Card 2 -->
			<div class="col-lg-4 col-md-6">
				<div class="card">
					<div class="card-body">
						<div class="card-icon">
							<i class="fas fa-plus-circle"></i>
						</div>
						<h5 class="card-title">Add New Scheme</h5>
						<p class="card-text">Create and publish new scholarship
							opportunities</p>
						<form action="NewScheme" method="post">
							<input type="hidden" name="author" value="<%=user.getName()%>">
							<button type="submit" class="btn btn-card">
								Add Scheme <i class="fas fa-plus ms-2"></i>
							</button>
						</form>
					</div>
				</div>
			</div>


			<div class="col-lg-4 col-md-6">
				<div class="card ">
					<div class="card-body">
						<div class="card-icon">
							<i class="fas fa-users"></i>
						</div>
						<h5 class="card-title">User Management</h5>
						<p class="card-text">Manage admin and user accounts</p>
						<form action="Members" method="post">
							<button type="submit" class="btn btn-card">
								Manage Users <i class="fas fa-cog ms-2"></i>
							</button>
						</form>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-6">
				<div class="card">
					<div class="card-body">
						<div class="card-icon">
							<i class="fas fa-briefcase"></i>
						</div>
						<h5 class="card-title">Add Job</h5>
						<p class="card-text">Explore and manage job opportunities for
							students</p>
						<form action="PostNewJob.jsp" method="post">
							<button type="submit" class="btn btn-card">
								View Jobs <i class="fas fa-briefcase ms-2"></i>
							</button>
						</form>
					</div>
				</div>
			</div>


			<!--  Jobs Application -->
			<div class="col-lg-4 col-md-6">
				<div class="card">
					<div class="card-body">
						<div class="card-icon">
							<i class="fas fa-list-ul"></i>
						</div>
						<h5 class="card-title">View Job Application</h5>
						<p class="card-text">Explore and manage job opportunities for
							students</p>
						<form method="post"
							action="<%=request.getContextPath()%>/ApplyJob">
							<input type="hidden" name="action" value="fetch"> <input
								type="hidden" name="type" value="superadmin">
							<button type="submit" class="btn btn-card">
								View Applications <i class="fas fa-arrow-right ms-2"></i>
							</button>
						</form>

					</div>
				</div>
			</div>
			<!-- Card 3 - Placeholder for future feature -->
			<div class="col-lg-4 col-md-6">
				<div class="card card-users">
					<div class="card-body">
						<div class="card-icon">
							<i class="fas fa-chart-line"></i>
						</div>
						<h5 class="card-title">Analytics Dashboard</h5>
						<p class="card-text">View insights and statistics about your
							schemes</p>
						<button class="btn btn-card" disabled>
							Coming Soon <i class="fas fa-clock ms-2"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS Bundle -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>