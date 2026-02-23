<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.Major.Entity.*"%>
<%@ page import="com.Major.DAO.*"%>
<%
UserEntity user = (UserEntity) session.getAttribute("user");

session = request.getSession(false); // Get the current session, but don't create a new one
if (session == null || session.getAttribute("user") == null) {
	response.sendRedirect("login.jsp");
	return;
}

// Cache-control to prevent back button 
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<%
int id = Integer.parseInt(request.getParameter("id"));
JobDAO jobdao = new JobDAO();
JobEntity job = jobdao.getJobByID(id);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>JobEntry - Job Portal Website Template</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<link href="assets/img/favicon.ico" rel="icon">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">
<link href="assets/lib/animate/animate.min.css" rel="stylesheet">
<link href="assets/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="assets/css/bootstrap.min.css" rel="stylesheet">
<link href="assets/css/style.css" rel="stylesheet">
</head>
<body>
	<div class="container-xxl bg-white p-0">

		<!-- Spinner Start -->
		<div id="spinner"
			class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
			<div class="spinner-border text-primary"
				style="width: 3rem; height: 3rem;" role="status">
				<span class="sr-only">Loading...</span>
			</div>
		</div>
		<!-- Spinner End -->

		<!-- Navbar Start -->
		<jsp:include page="header.jsp" />
		<!-- Navbar End -->

		<!-- Header Start -->
		<div class="container-xxl py-5 bg-dark page-header mb-5">
			<div class="container my-5 pt-5 pb-4">
				<h1 class="display-3 text-white mb-3 animated slideInDown">Job
					Detail</h1>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb text-uppercase">
						<li class="breadcrumb-item"><a href="#">Home</a></li>
						<li class="breadcrumb-item"><a href="#">Pages</a></li>
						<li class="breadcrumb-item text-white active" aria-current="page">Job
							Detail</li>
					</ol>
				</nav>
			</div>
		</div>
		<!-- Header End -->

		<!-- Job Detail Start -->
		<div class="container-xxl py-5 wow fadeInUp" data-wow-delay="0.1s">
			<div class="container">
				<div class="row gy-5 gx-4">
					<div class="col-lg-8">
						<div class="d-flex align-items-center mb-5">
							<div class="text-start ps-4">
								<h3 class="mb-3"><%=job.getJobTitle()%></h3>
								<span class="text-truncate me-3"><i
									class="fa fa-map-marker-alt text-primary me-2"></i><%=job.getJobLocation()%></span>
								<span class="text-truncate me-3"><i
									class="far fa-clock text-primary me-2"></i><%=job.getJobType()%></span>
								<span class="text-truncate me-0"><i
									class="far fa-money-bill-alt text-primary me-2"></i><%=job.getSalleryRange()%></span>
							</div>
						</div>

						<div class="mb-5">
							<h4 class="mb-3">Job Description</h4>
							<p><%=job.getDescription()%></p>


							<ul class="list-unstyled">
								<li><i class="fa fa-angle-right text-primary me-2"></i>Experience
									Required: <%=job.getExperienceRequired()%></li>
								<li><i class="fa fa-angle-right text-primary me-2"></i>Skills
									Required: <%=job.getSkillRequired()%></li>
							</ul>

							<h4 class="mb-3">Qualifications</h4>
							<p><%=job.getQualification()%></p>
						</div>

						<!-- Apply Now Button -->
						<div class="text-center mt-4">
							<button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#applyJobModal">
								Apply For This Job</button>
						</div>



						<!-- Apply Job Modal -->
						<div class="modal fade" id="applyJobModal" tabindex="-1"
							aria-labelledby="applyJobModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-lg modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="applyJobModalLabel">Apply For
											The Job</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">


										<form method="post"
											action="<%=request.getContextPath()%>/ApplyJob"
											enctype="multipart/form-data">

											<div class="row g-3">
												<!-- Add this hidden input to specify action -->
												<input type="hidden" name="action" value="apply">

												<div class="col-12 col-sm-6">
													<input type="text" name="name" class="form-control"
														placeholder="Your Name" value="<%=user.getName()%>"
														readonly>
												</div>
												<div class="col-12 col-sm-6">
													<input type="email" name="email" class="form-control"
														placeholder="Your Email" value="<%=user.getEmail()%>"
														readonly>
												</div>
												<div class="col-12 col-sm-6">
													<input type="text" name="portfolio" class="form-control"
														placeholder="Portfolio Website">
												</div>
												<div class="col-12 col-sm-6">
													<input type="file" name="resume" accept=".pdf, .doc, .docx"
														class="form-control bg-white" required>
												</div>
												<div class="col-12">
													<textarea class="form-control" name="coverletter" rows="5"
														placeholder="Coverletter"></textarea>
												</div>
												<div class="col-12">
													<input type="hidden" name="user_id"
														value="<%=user.getId()%>"> <input type="hidden"
														name="job_id" value="<%=id%>">
													<button class="btn btn-primary w-100" type="submit">
														Submit Application</button>
												</div>
											</div>
										</form>


									</div>
								</div>
							</div>
						</div>

					</div>

					<div class="col-lg-4">
						<div class="bg-light rounded p-5 mb-4 wow slideInUp"
							data-wow-delay="0.1s">
							<h4 class="mb-4">Job Summary</h4>
							<p>
								<i class="fa fa-angle-right text-primary me-2"></i>Published On:
								<%=job.getPublishDate()%></p>
							<p>
								<i class="fa fa-angle-right text-primary me-2"></i>Vacancy:
								<%=job.getNoOfOpening()%>
								Position(s)
							</p>
							<p>
								<i class="fa fa-angle-right text-primary me-2"></i>Job Nature:
								<%=job.getJobType()%></p>
							<p>
								<i class="fa fa-angle-right text-primary me-2"></i>Salary:
								<%=job.getSalleryRange()%></p>
							<p>
								<i class="fa fa-angle-right text-primary me-2"></i>Location:
								<%=job.getJobLocation()%></p>
							<p class="m-0">
								<i class="fa fa-angle-right text-primary me-2"></i>Deadline:
								<%=job.getLastDate()%></p>
						</div>
						<div class="bg-light rounded p-5 wow slideInUp"
							data-wow-delay="0.1s">
							<h4 class="mb-4">Company Detail</h4>
							<p class="m-0"><%=job.getCompanyName()%></p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Job Detail End -->

		<jsp:include page="footer.jsp" />

		<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i
			class="bi bi-arrow-up"></i></a>
	</div>

	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="assets/lib/wow/wow.min.js"></script>
	<script src="assets/lib/easing/easing.min.js"></script>
	<script src="assets/lib/waypoints/waypoints.min.js"></script>
	<script src="assets/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>
