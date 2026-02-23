<%@ page import="com.Major.Entity.UserEntity"%>
<%


session = request.getSession(false); // Get the current session, but don't create a new one
if (session == null || session.getAttribute("user") == null) {
    response.sendRedirect("login");
    return; 
}
UserEntity user = (UserEntity) session.getAttribute("user");

if (user.getStatus() != 2 && user.getStatus() !=1) {
    response.sendRedirect("404.jsp");
    return;
}
// Cache-control to prevent back button 
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache"); 
response.setDateHeader("Expires", 0); 
%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Post a Job</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(to right, #f8f9fa, #e0eafc);
      font-family: 'Segoe UI', sans-serif;
    }

    .job-form {
      max-width: 900px;
      margin: 50px auto;
      padding: 40px;
      background: #ffffff;
      border-radius: 30px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .form-title {
      text-align: center;
      font-size: 2rem;
      font-weight: bold;
      margin-bottom: 30px;
      color: #2c3e50;
    }

    label {
      font-weight: 500;
      color: #2c3e50;
    }

    .form-control,
    .form-select {
      border-radius: 12px;
      border: 1px solid #d1d1d1;
      box-shadow: inset 2px 2px 5px rgba(0,0,0,0.05);
    }

    .btn-primary {
      background-color: #4a69bd;
      border: none;
      padding: 10px 40px;
      font-size: 1.1rem;
      border-radius: 25px;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #3b58a7;
    }

    textarea.form-control {
      resize: none;
    }
    
  .was-validated .form-control:invalid,
  .form-control.is-invalid {
    border-color: #dc3545;
  }

    
  </style>
</head>
<body>
  <div class="container">
    <div class="job-form">
      <h2 class="form-title">Post a New Job</h2>
     <form action="Jobs" method="post" onsubmit="return submitForm();" novalidate>
  <div class="mb-3">
    <label for="jobTitle" class="form-label">Job Title</label>
    <input type="text" class="form-control" id="jobTitle" name="jobTitle" required>
  </div>

  <div class="mb-3">
    <label for="companyName" class="form-label">Company Name</label>
    <input type="text" class="form-control" id="companyName" name="companyName" required>
  </div>

  <div class="row mb-3">
    <div class="col-md-6">
      <label for="location" class="form-label">Job Location</label>
      <input type="text" class="form-control" id="location" name="jobLocation">
    </div>
    <div class="col-md-6">
      <label for="jobType" class="form-label">Job Type</label>
      <select class="form-select" id="jobType" name="jobType" required>
        <option selected disabled value="">Choose...</option>
        <option>Full-time</option>
        <option>Part-time</option>
        <option>Internship</option>
      </select>
    </div>
  </div>

  <div class="row mb-3">
    <div class="col-md-6">
      <label for="experience" class="form-label">Experience Required</label>
      <input type="text" class="form-control" id="experience" name="experienceRequired">
    </div>
    <div class="col-md-6">
      <label for="salary" class="form-label">Salary Range</label>
      <input type="text" class="form-control" id="salary" name="salleryRange">
    </div>
  </div>

  <div class="mb-3">
    <label for="skills" class="form-label">Skills Required</label>
    <input type="text" class="form-control" id="skills" name="skillRequired">
  </div>

  <div class="mb-3">
    <label for="qualifications" class="form-label">Educational Qualifications</label>
    <input type="text" class="form-control" id="qualifications" name="qualification">
  </div>

  <div class="row mb-3">
    <div class="col-md-6">
      <label for="deadline" class="form-label">Last Date to Apply</label>
      <input type="date" class="form-control" id="deadline" name="lastDate">
    </div>
    <div class="col-md-6">
      <label for="openings" class="form-label">Number of Openings</label>
      <input type="number" class="form-control" id="openings" name="noOfOpening" min="1">
    </div>
  </div>

  <div class="mb-3">
    <label for="description" class="form-label"><i class="fas fa-file-alt me-2"></i>Job Description</label>
    <textarea id="description" class="form-control" name="description" required placeholder="Enter detailed job description..."></textarea>
    <div class="invalid-feedback">Please provide a job description.</div>
  </div>

  <div class="text-center">
  <input type="hidden" name="adminID" value="<%= user.getId() %>">
    <button type="submit" class="btn btn-primary">Post Job</button>
  </div>
</form>

    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.tiny.cloud/1/xs38gj8k0twvd9aglqzpycuiiiml08sargqve3k031ukb9sx/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
  
  <script>
  // Initialize TinyMCE
  tinymce.init({
    selector: '#description',
    plugins: 'lists link image code',
    toolbar: 'undo redo | bold italic underline | bullist numlist | link image | code',
    menubar: false,
    branding: false,
    min_height: 300,
    content_style: 'body { font-family: Inter, sans-serif; font-size: 16px; }'
  });

  // On DOM Ready
  document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('form');

    form.addEventListener('submit', function (event) {
      tinymce.triggerSave(); // sync TinyMCE content

      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
      }

      form.classList.add('was-validated');
    });
  });
</script>
  
</body>
</html>
