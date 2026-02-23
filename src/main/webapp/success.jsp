<%
session = request.getSession(false); // Get the current session, but don't create a new one

if (session == null || session.getAttribute("user") == null) {
	response.sendRedirect("Home");
	return; // Stop further processing
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
    <title>Success Page</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .success-container {
            text-align: center;
            margin-top: 50px;
            animation: fadeIn 1.5s ease-in-out;
        }
        .btn-custom {
            background-color: #24c1cf;
            color: white;
            animation: bounceIn 2s;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
  
    <div class="container success-container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="display-4">Success!</h1>
                <p class="lead">Your information has been successfully submitted.</p>
                <hr>
                <p class="lead">
                    <button class="btn btn-info" onclick="goBack()">Go Back</button></a>
                </p>
            </div>
        </div>
    </div>
</body>
<script>
    function goBack() {
        window.history.back();
    }
</script>
</html>
