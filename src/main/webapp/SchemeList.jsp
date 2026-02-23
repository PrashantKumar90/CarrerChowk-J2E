<%@ page import="com.Major.Entity.UserEntity"%>
<%@ page import="com.Major.DAO.UserDAO"%>
<%@ page import="java.util.List"%>
<%
session = request.getSession(false); // Get the current session, but don't create a new one

if (session == null || session.getAttribute("user") == null) {
	response.sendRedirect("login.jsp");
    return; 
}
UserEntity user = (UserEntity) session.getAttribute("user");
if (user.getStatus() != 2 && user.getStatus() !=1) {
    response.sendRedirect("404.jsp");
    return;
}

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache"); 
response.setDateHeader("Expires", 0); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schemes Table</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #00b075;
            --secondary-color: #008a5e;
            --accent-color: #00d394;
            --light-color: #f8f9fa;
            --dark-color: #212529;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding: 20px;
        }
        
        .card-container {
            max-width: 1200px;
            margin: 30px auto;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border-radius: 12px;
            overflow: hidden;
            border: none;
            background: white;
        }
        
        .card-header {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .card-header h2 {
            font-weight: 700;
            margin: 0;
            font-size: 1.8rem;
        }
        
        .btn-custom {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 8px 20px;
            border-radius: 50px;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(0, 176, 117, 0.3);
            display: inline-flex;
            align-items: center;
            color: white !important;
        }
        
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 176, 117, 0.4);
            background: linear-gradient(to right, var(--secondary-color), var(--primary-color));
        }
        
        .btn-custom i {
            margin-right: 8px;
        }
        
        .btn-danger {
            background: linear-gradient(to right, #dc3545, #b02a37);
            border: none;
            padding: 8px 20px;
            border-radius: 50px;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
            color: white !important;
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
            background: linear-gradient(to right, #b02a37, #dc3545);
        }
        
        .table-custom {
            margin: 0;
        }
        
        .table-custom thead {
            background-color: rgba(0, 176, 117, 0.1);
            color: var(--secondary-color);
        }
        
        .table-custom thead th {
            border-bottom: 2px solid var(--primary-color);
            font-weight: 600;
            padding: 15px;
            text-align: center;
        }
        
        .table-custom tbody tr {
            transition: all 0.2s ease;
        }
        
        .table-custom tbody tr:hover {
            background-color: rgba(0, 176, 117, 0.05);
            transform: translateX(2px);
        }
        
        .table-custom tbody td {
            padding: 12px 15px;
            vertical-align: middle;
            border-color: rgba(0, 0, 0, 0.05);
            text-align: center;
        }
        
        .badge-state {
            background-color: rgba(0, 176, 117, 0.1);
            color: var(--secondary-color);
            padding: 5px 12px;
            border-radius: 50px;
            font-weight: 500;
            font-size: 0.85rem;
        }
        
        .empty-message {
            padding: 30px;
            text-align: center;
            color: #6c757d;
        }
        
        .empty-message i {
            font-size: 2rem;
            color: #dee2e6;
            margin-bottom: 15px;
        }
        
        @media (max-width: 768px) {
            .card-header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .card-header h2 {
                font-size: 1.5rem;
            }
            
            .table-custom thead {
                display: none;
            }
            
            .table-custom tbody tr {
                display: block;
                margin-bottom: 20px;
                border: 1px solid #dee2e6;
                border-radius: 8px;
            }
            
            .table-custom tbody td {
                display: block;
                text-align: right;
                padding-left: 50%;
                position: relative;
                border: none;
                border-bottom: 1px solid #dee2e6;
            }
            
            .table-custom tbody td:before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                width: calc(50% - 15px);
                padding-right: 10px;
                font-weight: 600;
                text-align: left;
                color: var(--secondary-color);
            }
            
            .table-custom tbody td:last-child {
                border-bottom: none;
            }
        }
    </style>
</head>
<body>
    <div class="card-container">
        <div class="card-header">
            <h2><i class="fas fa-list-alt"></i> List of Schemes</h2>
            <button onclick="history.back()" class="btn btn-custom">
                <i class="fas fa-arrow-left"></i> Back
            </button>
        </div>
        
        <div class="card-body p-0">
            <%
            int adminId = (Integer) request.getAttribute("adminId");
           
                UserDAO dao = new UserDAO();
                List<UserEntity> schemes = dao.getAllScheme(adminId);
                
                if (schemes != null && !schemes.isEmpty()) {
            %>
            <div class="table-responsive">
                <table class="table table-custom table-hover mb-0">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Name of Scheme</th>
                            <th scope="col">State</th>
                            <th scope="col">View</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (UserEntity scheme : schemes) {
                        %>
                        <tr>
                            <td data-label="ID"><%= scheme.getId() %></td>
                            <td data-label="Scheme Name"><%= scheme.getTitle() %></td>
                            <td data-label="State">
                                <span class="badge-state"><%= scheme.getState() %></span>
                            </td>
                            <td data-label="View">
                                <form action="Viewmore" method="post">
                                    <input type="hidden" name="schemeId" value="<%= scheme.getId() %>">
                                    <button type="submit" class="btn btn-custom btn-sm">
                                        <i class="fas fa-eye"></i> View More
                                    </button>
                                </form>
                            </td>
                            <td data-label="Action">
                                <form action="Terminate" method="post">
                                    <input type="hidden" name="user" value="<%= user.getName() %>">
                                    <input type="hidden" name="schemeId" value="<%= scheme.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="fas fa-trash"></i> Terminate
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <%
                } else {
            %>
            <div class="empty-message">
                <i class="fas fa-inbox"></i>
                <h4>No schemes available</h4>
                <p>There are currently no schemes matching your criteria.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>