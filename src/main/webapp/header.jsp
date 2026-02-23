<%@ page import="com.Major.Entity.UserEntity" %>
<% 
	
%>

<nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
    <a href="<%=request.getContextPath()%>/Home" class="navbar-brand d-flex align-items-center text-center py-0 px-4 px-lg-5">
        <h1 class="m-0 text-primary">
            Scholarship<span style="color: black;">Info</span>
        </h1>
    </a>
    <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">

            <a href="<%=request.getContextPath()%>/Home" class="nav-item nav-link">Home</a>
            <a href="<%=request.getContextPath()%>/About" class="nav-item nav-link">About</a>
            <a href="<%=request.getContextPath()%>/JobList" class="nav-item nav-link">Jobs</a>
            <a href="<%=request.getContextPath()%>/Contact" class="nav-item nav-link">Contact</a>

            <% 
                // Check if user session attribute exists
                UserEntity user = (UserEntity) session.getAttribute("user"); 
                if(user != null && user.getStatus()==3) {
            %>
                <!-- Agar user login hai to dashboard aur logout dikhayenge -->
                
                <a href="<%=request.getContextPath()%>/UserDashboard.jsp" class="nav-item nav-link">Dashboard</a>
                <a href="<%=request.getContextPath()%>/loginsignup" class="btn btn-danger rounded-0 py-4 px-3 d-none d-lg-block">Logout</a>
            <% 
                } else { 
            %>
                <!-- Agar user login nahi hai to login button dikhao -->
                <a href="<%=request.getContextPath()%>/login.jsp" class="btn btn-primary rounded-0 py-4 px-lg-2 d-none d-lg-block">Login<i class="fa fa-arrow-right ms-3"></i></a>
            <% 
                } 
            %>
        </div>
    </div>
</nav>
