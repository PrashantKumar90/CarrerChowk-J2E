<%@ page import="com.Major.Entity.UserEntity"%>
<%
UserEntity user = (UserEntity) session.getAttribute("user");
//Get the current session, but don't create a new one
session = request.getSession(false); 
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Government Scheme</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- TinyMCE -->
    <script src="https://cdn.tiny.cloud/1/6wri48vev34mapy0677xlqon92y2rfj5yoljt2jurtujwepn/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
    <style>
        body {
            background-color: #f4f7fc;
            font-family: 'Inter', sans-serif;
            color: #333;
        }
        .form-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }
        .form-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1a5f7a;
            margin-bottom: 30px;
            text-align: center;
        }
        .form-label {
            font-weight: 500;
            color: #1a5f7a;
        }
        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #d1d5db;
            padding: 10px;
            transition: border-color 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #1a5f7a;
            box-shadow: 0 0 0 3px rgba(26, 95, 122, 0.1);
            outline: none;
        }
        .btn-custom {
            background-color: #1a5f7a;
            color: #fff;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .btn-custom:hover {
            background-color: #2a829e;
        }
        .form-section {
            margin-bottom: 25px;
        }
        .input-group-text {
            background-color: #f8fafc;
            border: 1px solid #d1d5db;
            border-radius: 8px 0 0 8px;
        }
        textarea#description {
            resize: vertical;
            min-height: 150px;
        }
        .invalid-feedback {
            font-size: 0.875rem;
            color: #dc3545;
        }
        @media (max-width: 576px) {
            .form-container {
                margin: 20px;
                padding: 20px;
            }
            .form-title {
                font-size: 1.5rem;
            }
        }
    </style>
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

        // Form submission handler
        function submitForm() {
            tinymce.triggerSave(); // Sync TinyMCE content to textarea
            return true; // Allow form submission
        }

        // Client-side form validation
        document.addEventListener('DOMContentLoaded', function () {
            const form = document.querySelector('form');
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            });
        });
    </script>
</head>
<body>
    <div class="container form-container">
        <h1 class="form-title">Add Government Scheme</h1>
        <form action="Addscheme" method="POST" onsubmit="return submitForm();" novalidate>
            <!-- Title -->
            <div class="form-section">
                <label for="title" class="form-label"><i class="fas fa-heading me-2"></i>Title</label>
                <input type="text" class="form-control" id="title" name="title" placeholder="Enter scheme title" required>
                <div class="invalid-feedback">Please provide a valid title.</div>
            </div>

            <!-- State -->
            <div class="form-section">
                <label for="state" class="form-label"><i class="fas fa-map-marker-alt me-2"></i>State</label>
                <select id="state" name="state" class="form-select" required>
                    <option value="" selected disabled>Select a state</option>
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
                <div class="invalid-feedback">Please select a state.</div>
            </div>

            <!-- Start Date -->
            <div class="form-section">
                <label for="startDate" class="form-label"><i class="fas fa-calendar-alt me-2"></i>Start Date</label>
                <input type="date" class="form-control" id="startDate" name="start_date" required>
                <div class="invalid-feedback">Please provide a valid start date.</div>
            </div>

            <!-- End Date -->
            <div class="form-section">
                <label for="endDate" class="form-label"><i class="fas fa-calendar-alt me-2"></i>End Date</label>
                <input type="date" class="form-control" id="endDate" name="end_date" required>
                <div class="invalid-feedback">Please provide a valid end date.</div>
            </div>

            <!-- Author Name -->
            <div class="form-section">
                <label for="authorName" class="form-label"><i class="fas fa-user me-2"></i>Author Name</label>
                <input type="text" class="form-control" id="authorName" name="author_name" value="<%= user.getName() %>" readonly required>
            </div>

            <!-- URL -->
            <div class="form-section">
                <label for="url" class="form-label"><i class="fas fa-link me-2"></i>URL</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-globe"></i></span>
                    <input type="url" class="form-control" id="url" name="url" placeholder="https://example.com" required>
                </div>
                <div class="invalid-feedback">Please provide a valid URL.</div>
            </div>

            <!-- Description -->
            <div class="form-section">
                <label for="description" class="form-label"><i class="fas fa-file-alt me-2"></i>Description</label>
                <textarea id="description" class="form-control" name="description" placeholder="Enter scheme description..." required></textarea>
                <div class="invalid-feedback">Please provide a description.</div>
            </div>

            <!-- Submit Button -->
            <div class="text-center mt-4">
             <input type="hidden" name="adminID" value="<%= user.getId() %>">
                <button type="submit" class="btn btn-custom"><i class="fas fa-check me-2"></i>Submit Scheme</button>
            </div>
        </form>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>