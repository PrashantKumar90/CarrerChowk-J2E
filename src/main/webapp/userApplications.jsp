<%@ page import="java.util.*, com.Major.Entity.*, com.Major.DAO.*, java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Job Applications</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa;
            padding: 30px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.05);
        }
        .table thead {
            background-color: #00b075;
            color: white;
        }
        .btn-view {
            background-color: #00b075;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 6px;
        }
        .btn-view:hover {
            background-color: #008a5e;
        }
        .no-applications {
            text-align: center;
            padding: 50px;
            color: #6c757d;
        }
        .no-applications i {
            font-size: 2rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0"><i class="fas fa-briefcase me-2"></i>Your Applied Jobs</h4>
        </div>
        <div class="card-body">
            <%
                List<JobEntity> applications = (List<JobEntity>) request.getAttribute("applications");
                if (applications == null || applications.isEmpty()) {
            %>
            <div class="no-applications">
                <i class="fas fa-inbox"></i>
                <h5>No applications found</h5>
                <p>It looks like you haven’t applied to any jobs yet.</p>
            </div>
            <%
                } else {
            %>
            <div class="table-responsive">
                <table class="table table-bordered align-middle text-center">
                    <thead>
                        <tr>
                            <th>Job ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Portfolio</th>
                            <th>Resume</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (JobEntity app : applications) {
                        %>
                        <tr>
                            <td><%= app.getJobId() %></td>
                            <td><%= app.getName() %></td>
                            <td><%= app.getEmail() %></td>
                            <td><%= app.getPortfolio() %></td>
                            <td>
                                <%
                                    byte[] resumeBytes = app.getResumeBytes();
                                    if (resumeBytes != null && resumeBytes.length > 0) {
                                        String base64Resume = Base64.getEncoder().encodeToString(resumeBytes);
                                %>
                                <button class="btn btn-view btn-sm" onclick="viewResume('<%= base64Resume %>')">
                                    <i class="fas fa-file-pdf"></i> View
                                </button>
                                <%
                                    } else {
                                %>
                                <span class="text-muted">No resume</span>
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<!-- Resume Viewer Script -->
<script>
    function viewResume(base64Data) {
        // Convert base64 to binary data
        const byteCharacters = atob(base64Data);
        const byteNumbers = new Array(byteCharacters.length);
        for (let i = 0; i < byteCharacters.length; i++) {
            byteNumbers[i] = byteCharacters.charCodeAt(i);
        }

        const byteArray = new Uint8Array(byteNumbers);
        const blob = new Blob([byteArray], { type: 'application/pdf' });
        const blobUrl = URL.createObjectURL(blob);

        // Open in new tab
        window.open(blobUrl, '_blank');
    }
</script>


<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
