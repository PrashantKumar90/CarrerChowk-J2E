<%@ page import="java.util.*" %>
<%@ page import="com.Major.DAO.*" %>
<%@ page import="com.Major.Entity.*" %>
<%
    String jobType = request.getParameter("jobType");
    if (jobType == null) {
        jobType = "featured";
    }

    List<JobEntity> jobList = new ArrayList<>();
    JobDAO jobDAO = new JobDAO(); 

    if ("featured".equals(jobType)) {
        jobList = jobDAO.getJobs(); 
    } else {
        jobList = jobDAO.getJobsByType(jobType);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Scholarship INFO - Jobs</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="assets/img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/lib/animate/animate.min.css" rel="stylesheet">
    <link href="assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
</head>
<body>
<div class="container-xxl bg-white p-0">
    <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
            <span class="sr-only">Loading...</span>
        </div>
    </div>
    <jsp:include page="header.jsp"/>
    <div class="container-xxl py-5 bg-dark page-header mb-5">
        <div class="container my-5 pt-5 pb-4">
            <h1 class="display-3 text-white mb-3 animated slideInDown">Job List</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb text-uppercase">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pages</a></li>
                    <li class="breadcrumb-item text-white active" aria-current="page">Job List</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="container-xxl py-5">
        <div class="container">
            <h1 class="text-center mb-5 wow fadeInUp" data-wow-delay="0.1s">Job Listing</h1>
            <div class="tab-class text-center wow fadeInUp" data-wow-delay="0.3s">
                <ul class="nav nav-pills d-inline-flex justify-content-center border-bottom mb-5">
                    <li class="nav-item">
                        <a href="job-list.jsp?jobType=featured" class="d-flex align-items-center text-start mx-3 pb-3 <% if ("featured".equals(jobType)) { %>active<% } %>">
                            <h6 class="mt-n1 mb-0">Featured</h6>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="job-list.jsp?jobType=Full-time" class="d-flex align-items-center text-start mx-3 pb-3 <% if ("Full-time".equals(jobType)) { %>active<% } %>">
                            <h6 class="mt-n1 mb-0">Full Time</h6>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="job-list.jsp?jobType=Part-time" class="d-flex align-items-center text-start mx-3 pb-3 <% if ("Part-time".equals(jobType)) { %>active<% } %>">
                            <h6 class="mt-n1 mb-0">Part Time</h6>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="job-list.jsp?jobType=Internship" class="d-flex align-items-center text-start mx-3 pb-3 <% if ("Internship".equals(jobType)) { %>active<% } %>">
                            <h6 class="mt-n1 mb-0">Internships</h6>
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div id="tab-content" class="tab-pane fade show p-0 active">
                        <% for (JobEntity job : jobList) { %>
                        <div class="job-item p-4 mb-4">
                            <div class="row g-4">
                                <div class="col-sm-12 col-md-8 d-flex align-items-center">
                                    
                                    <div class="text-start ps-4">
                                        <h5 class="mb-3"><%= job.getJobTitle()%></h5>
                                        <span class="text-truncate me-3"><i class="fa fa-map-marker-alt text-primary me-2"></i><%= job.getJobLocation() %></span>
                                        <span class="text-truncate me-3"><i class="far fa-clock text-primary me-2"></i><%= job.getJobType() %></span>
                                        <span class="text-truncate me-0"><i class="far fa-money-bill-alt text-primary me-2"></i><%= job.getSalleryRange() %></span>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-4 d-flex flex-column align-items-start align-items-md-end justify-content-center">
                                    <div class="d-flex mb-3">
                                        <a href="job-detail.jsp?id=<%= job.getId() %>" class="btn btn-primary">View Detail</a>
                                    </div>
                                    <small class="text-truncate"><i class="far fa-calendar-alt text-primary me-2"></i>Date Line: <%= job.getLastDate() %></small>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="assets/lib/wow/wow.min.js"></script>
<script src="assets/lib/easing/easing.min.js"></script>
<script src="assets/lib/waypoints/waypoints.min.js"></script>
<script src="assets/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="assets/js/main.js"></script>
</body>
</html>
